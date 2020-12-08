CMD:createmapicon(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new type;

	if (sscanf(params, "i", type))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /createmapicon [type]");
		return false;
	}

	new index = Iter_Alloc(gMapIcons);

	if (!(-1 <= index <= MAX_MAPICONS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"MapIcon ver sheiqmna");
		return false;
	}

	mysql_query(DB_GetHandler(), "INSERT INTO `mapicons` (`colour`) VALUES ('0xFFFFFFFF');", false);

	new Cache:result;
	result = mysql_query(DB_GetHandler(), "SELECT MAX(`id`) FROM `mapicons`", true);

	new dbID;
	cache_get_value_index_int(0, 0, dbID);
	cache_delete(result);


	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	MapIcon_SetMapIconID(index, dbID);
	MapIcon_SetMapIconPos(index, x, y, z);
	MapIcon_SetMapIconType(index, type);
	MapIcon_SetMapIconColour(index, "0xFFFFFFFF", MAX_MAPICONS_COLOUR_LENGTH);
	MapIcon_SetMapIconVirtualWorld(index, GetPlayerVirtualWorld(playerid));
	MapIcon_SetMapIconInteriorID(index, GetPlayerInterior(playerid));

	new query[1024];

	mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `mapicons` SET `posX` = '%f', `posY` = '%f', `posZ` = '%f', \
		`type` = '%d', `colour` = '%s', `virtualworld` = '%d', `interiorid` = '%d' \
		WHERE `id` = '%d';", \
	x, y, z, type, MAPICON_DEFAULT_COLOUR, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), dbID);
	mysql_tquery(DB_GetHandler(), query);

	MapIcon_CreateMapIcon(index);
	return true;
}

CMD:editmapicon(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new index;

	if (sscanf(params, "i", index))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /editmapicon [index]");
		return false;
	}

	if (!(-1 <= index <= MAX_MAPICONS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Map Icon] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gMapIcons, index))
	{
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, playerID, inputtext

		if (!response)
		{
			return false;
		}

		inline __response(playerIDD, dialogIDD, responsee, listitemm, string:inputtextt[])
		{
			#pragma unused dialogIDD, playerIDD, listitemm

			if (!responsee)
			{
				return false;
			}

			if (isnull(inputtextt))
			{
				return false;
			}

			new x = strval(inputtextt);

			switch (listitem)
			{
				case 0:
				{
					MapIcon_SetMapIconType(index, x);
				}

				case 1:
				{
					new Float:px, Float:py, Float:pz;
					GetPlayerPos(playerid, px, py, pz);
					MapIcon_SetMapIconPos(index, px, py, pz);
				}

				case 2:
				{
					MapIcon_SetMapIconColour(index, inputtextt);
				}

				case 3:
				{
					MapIcon_SetMapIconVirtualWorld(index, x);
				}

				case 4:
				{
					MapIcon_SetMapIconInteriorID(index, x);
				}

				default:
				{
					return false;
				}
			}

			MapIcon_UpdateMapIcon(index);
			MapIcon_SaveMapIcon(index);
			return true;
		}
		Dialog_ShowCallback(playerid, using inline __response, DIALOG_STYLE_INPUT, !"{226db8} Map Icons", "{FFFFFF}Gtxovt sheiyvanot axali parametri", !">>", !"X");

	}

	new Float:posX, Float:posY, Float:posZ;	MapIcon_GetMapIconPos(index, posX, posY, posZ);
	new type = MapIcon_GetMapIconType(index);
	new colour[MAX_MAPICONS_COLOUR_LENGTH]; MapIcon_GetMapIconColour(index, colour, MAX_MAPICONS_COLOUR_LENGTH);
	new virtualworld = MapIcon_GetMapIconVirtualWorld(index);
	new interiorid = MapIcon_GetMapIconInteriorID(index);

	new mapIcon[512];
	format(mapIcon, sizeof mapIcon, "\
		type\t\t\t%d\n\
		pos\t\t\tx - %f y - %f z - %f\n\
		colour\t\t\t%s\n\
		virtualworld\t\t%d\n\
		interiorid\t\t%d",\
	type, posX, posY, posZ, colour, virtualworld, interiorid);
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Map Icons", mapIcon, !">>", !"X");
	return true;
}

CMD:deletemapicon(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new mapiconIndex;

	if (sscanf(params, "i", mapiconIndex))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /deletemapicon [index]");
		return false;
	}

	if (!(-1 <= mapiconIndex <= MAX_MAPICONS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Map Icon] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gMapIcons, mapiconIndex))
	{
		return false;
	}

	Iter_Remove(gMapIcons, mapiconIndex);

	MapIcon_DeleteMapIcon(mapiconIndex);

	new query[64];
	mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `mapicons` WHERE `id` = '%d'", MapIcon_GetMapIconID(mapiconIndex));
	mysql_tquery(DB_GetHandler(), query);

	return true;
}

CMD:gotomapicon(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new index;

	if (sscanf(params, "i", index))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /gotomapicon [index]");
		return false;
	}
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[MAP ICON] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gMapIcons, index))
	{
		return false;
	}

	new Float:x, Float:y, Float:z;
	MapIcon_GetMapIconPos(index, x, y, z);
	AC_SetPlayerPos(playerid, x, y, z, true);
	AC_SetPlayerVirtualWorld(playerid, MapIcon_GetMapIconVirtualWorld(index), true);
	AC_SetPlayerInteriorID(playerid, MapIcon_GetMapIconInteriorID(index), true);
	return true;
}

CMD:reloadmapicons(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new index : gMapIcons)
	{
		MapIcon_UpdateMapIcon(index);
	}
	return true;
}

CMD:getallmapicons(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new index : gMapIcons)
	{
		new text[144];

		format(text, sizeof text, "Index - %d | ID - %d | Type - %d", index, MapIcon_GetMapIconID(index), MapIcon_GetMapIconType(index));
		SendClientMessage(playerid, COLOUR_INFORMATION, text);
		SendClientMessage(playerid, COLOUR_INFORMATION, !"~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	return true;
}
