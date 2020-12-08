#include	<YSI_Coding\y_hooks>


forward MapIcons_LoadMapIcons();


hook OnScriptInit()
{
	mysql_tquery(DB_GetHandler(), "SELECT * FROM `mapicons`", "MapIcons_LoadMapIcons");
	return true;
}


public MapIcons_LoadMapIcons()
{
	new rows;
	cache_get_row_count(rows);

	if (!rows)
	{
		return false;
	}

	for (new i = 0; i < rows; i++)
	{
		new index = Iter_Alloc(gMapIcons);

		if (!(-1 <= index <= MAX_LABELS))
		{
			print("[mapIcons] mapIconIndex buffer overflow");
			break;
		}

		new
				ID,
		Float:	posX,
		Float:	posY,
		Float:	posZ,
				type,
				colour[MAX_MAPICONS_COLOUR_LENGTH],
				virtualworld,
				interiorid;

		cache_get_value_index_int(i, 0, ID);
		cache_get_value_index_float(i, 1, posX);
		cache_get_value_index_float(i, 2, posY);
		cache_get_value_index_float(i, 3, posZ);
		cache_get_value_index_int(i, 4, type);
		cache_get_value_index(i, 5, colour, MAX_MAPICONS_COLOUR_LENGTH);
		cache_get_value_index_int(i, 6, virtualworld);
		cache_get_value_index_int(i, 7, interiorid);

		MapIcon_SetMapIconID(index, ID);
		MapIcon_SetMapIconPos(index, posX, posY, posZ);
		MapIcon_SetMapIconType(index, type);
		MapIcon_SetMapIconColour(index, colour, MAX_MAPICONS_COLOUR_LENGTH);
		MapIcon_SetMapIconVirtualWorld(index, virtualworld);
		MapIcon_SetMapIconInteriorID(index, interiorid);
	}

	printf("\n[MapIcons] Loaded %d", rows);
	return true;
}


stock MapIcon_SaveMapIcon(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	new ID = MapIcon_GetMapIconID(index);
	new Float:posX, Float:posY, Float:posZ;	MapIcon_GetMapIconPos(index, posX, posY, posZ);
	new type = MapIcon_GetMapIconType(index);
	new colour[MAX_MAPICONS_COLOUR_LENGTH]; MapIcon_GetMapIconColour(index, colour, MAX_MAPICONS_COLOUR_LENGTH);
	new virtualworld = MapIcon_GetMapIconVirtualWorld(index);
	new interiorid = MapIcon_GetMapIconInteriorID(index);

	new query[512];
	mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `mapicons` SET `posX` = '%f', `posY` = '%f', `posZ` = '%f', \
		`type` = '%d', `colour` = '%s', `virtualworld` = '%d', `interiorid` = '%d' \
		WHERE `id` = '%d';", \
	posX, posY, posZ, type, colour, virtualworld, interiorid, ID);
	mysql_query(DB_GetHandler(), query, false);
	return true;
}
