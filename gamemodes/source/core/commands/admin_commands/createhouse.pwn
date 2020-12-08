CMD:createhouse(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new houseIndex = Iter_Alloc(gHouses);

	if (!(-1 <= houseIndex <= MAX_HOUSES))
	{
		print("[Houses] House buffer overflow");
		return false;
	}

	mysql_query(DB_GetHandler(), "INSERT INTO `house_data` (`owner`) VALUES ('NO')", false);

	new Cache:result;
	result = mysql_query(DB_GetHandler(), "SELECT MAX(`id`) FROM `house_data`", true);

	new dbID;
	cache_get_value_index_int(0, 0, dbID);
	cache_delete(result);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	new virtualworld = GetPlayerVirtualWorld(playerid), interiorid = GetPlayerInterior(playerid);

	House_SetHouseID(houseIndex, dbID);
	House_SetHouseOwnerName(houseIndex, HOUSE_DEFAULT_OWNER_NAME);
	House_SetHouseLockStatus(houseIndex, HOUSE_DEFUALT_LOCK_STATUS);
	House_SetHousePurchasePrice(houseIndex, HOUSE_DEFAULT_PURCHASE_PRICE);
	House_SetHouseClassType(houseIndex, HOUSE_DEFAULT_CLASS_TYPE);
	House_SetHouseInteriorID(houseIndex, HOUSE_DEFAULT_INTERIOR_ID);
	House_SetHouseElectricityFee(houseIndex, HOUSE_DEFAULT_ELECTRICITY_FEE);
	House_SetHouseMaintenanceFee(houseIndex, HOUSE_DEFAULT_MAINTENANCE_FEE);
	House_SetHouseLandFee(houseIndex, HOUSE_DEFAULT_LAND_FEE);
	House_SetHouseSecurityLevel(houseIndex, HOUSE_DEFAULT_SECURITY_LEVEL);
	House_SetHouseEntrancePos(houseIndex, x, y, z - 1.0);
	House_SetHouseExitPos(houseIndex, 0.0, 0.0, 0.0);
	House_SetHouseSpawnPos(houseIndex, 0.0, 0.0, 0.0, 0.0);
	House_SetHouseSpawnVirtualWorld(houseIndex, virtualworld);
	House_SetHouseSpawnInteriorID(houseIndex, interiorid);

	House_CreateHouse(houseIndex);
	CallRemoteFunction("House@SaveHouse", "i", houseIndex);
	return true;
}

CMD:deletehouse(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new house;

	if (sscanf(params, "i", house))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /deletehouse [house Index]");
		return false;
	}

	if (!(-1 <= house <= MAX_LABELS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[house] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gHouses, house))
	{
		return false;
	}

	Iter_Remove(gHouses, house);

	House_DeleteHouse(house);

	new query[64];
	mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `house_data` WHERE `id` = '%d'", House_GetHouseID(house));
	mysql_query(DB_GetHandler(), query, false);

	return true;
}

CMD:edithouse(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new houseindex;
	if (sscanf(params, "i", houseindex))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /edithouse [houseID]");
		return false;
	}

	if (!(-1 <= houseindex <= MAX_HOUSES))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Houses] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gHouses, houseindex))
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

			new value = strval(inputtextt);
			switch (listitem)
			{
				case 0:
				{
					House_SetHousePurchasePrice(houseindex, value);
				}
				case 1:
				{
					House_SetHouseClassType(houseindex, value);
				}
				case 2:
				{
					House_SetHouseInteriorID(houseindex, value);
				}
				case 3:
				{
					House_SetHouseElectricityFee(houseindex, value);
				}
				case 4:
				{
					House_SetHouseMaintenanceFee(houseindex, value);
				}
				case 5:
				{
					House_SetHouseLandFee(houseindex, value);
				}
				case 6:
				{
					House_SetHouseSecurityLevel(houseindex, value);
				}
				case 7:
				{
					new Float:x, Float:y, Float:z;
					GetPlayerPos(playerid, x, y, z);
					House_SetHouseEntrancePos(houseindex, x, y, z);
				}
				case 8:
				{
					new Float:x, Float:y, Float:z;
					GetPlayerPos(playerid, x, y, z);
					House_SetHouseExitPos(houseindex, x, y, z);
				}
				case 9:
				{
					new Float:x, Float:y, Float:z, Float:a;
					GetPlayerPos(playerid, x, y, z);
					GetPlayerFacingAngle(playerid, a);
					House_SetHouseSpawnPos(houseindex, x, y, z, a);
					House_SetHouseSpawnVirtualWorld(houseindex, GetPlayerVirtualWorld(playerid));
					House_SetHouseSpawnInteriorID(houseindex, GetPlayerInterior(playerid));
				}

				default:
				{
					return false;
				}
			}

			return true;
		}
		Dialog_ShowCallback(playerid, using inline __response, DIALOG_STYLE_INPUT, !"{226db8} Houses", "{FFFFFF}Gtxovt sheiyvanot axali parametri", !">>", !"X");
	}

	new output[1024];
	new
		Float:enX, Float:enY, Float:enZ,
		Float:exX, Float:exY, Float:exZ,
		Float:spX, Float:spY, Float:spZ, Float:spA;

	House_GetHouseEntrancePos(houseindex, enX, enY, enZ);
	House_GetHouseExitPos(houseindex, exX, exY, exZ);
	House_GetHouseSpawnPos(houseindex, spX, spY, spZ, spA);

	format(output, sizeof output, "\
	Price\t\t\t\t%d\n\
	Class Type\t\t\t%d\n\
	InteriorID\t\t\t%d\n\
	Electricity Fee\t\t\t%d\n\
	Maintenance Fee\t\t%d\n\
	Land Fee\t\t\t%d\n\
	Security Level\t\t\t%d\n\
	Entrance Pos\t\t\t%f %f %f\n\
	Exit Pos\t\t\t%f %f %f\n\
	Spawn Pos\t\t\t%f %f %f\n",

	House_GetHousePurchasePrice(houseindex),
	House_GetHouseClassType(houseindex),
	House_GetHouseInteriorID(houseindex),
	House_GetHouseElectricityFee(houseindex),
	House_GetHouseMaintenanceFee(houseindex),
	House_GetHouseLandFee(houseindex),
	House_GetHouseSecurityLevel(houseindex),
	enX, enY, enZ,
	exX, exY, exZ,
	spX, spY, spZ, spA);
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Houses", output, !">>", !"X");
	return true;
}

CMD:gotohouse(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new houseID;
	if (sscanf(params, "i", houseID))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /gotohouse [houseid]");
		return false;
	}
	if (!(-1 <= houseID <= MAX_HOUSES))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Houses] Invalid ID");
		return false;
	}
	if (!Iter_Contains(gHouses, houseID))
	{
		return false;
	}

	new Float:x, Float:y, Float:z;
	House_GetHouseEntrancePos(houseID, x, y, z);
	AC_SetPlayerPos(playerid, x, y, z, true);
	AC_SetPlayerVirtualWorld(playerid, 0, true);
	AC_SetPlayerInteriorID(playerid, 0, true);
	return true;
}
