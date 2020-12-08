CMD:createpickup(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new pickupIndex = Iter_Alloc(gPickups);

	if (!(-1 <= pickupIndex <= MAX_PICKUP))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Pickupi ver sheiqmna");
		return false;
	}

	mysql_query(DB_GetHandler(), "INSERT INTO `pickups` (`entranceModel`) VALUES ('1');", false);

	new Cache:result;
	result = mysql_query(DB_GetHandler(), "SELECT MAX(`id`) FROM `pickups`", true);

	new dbID;
	cache_get_value_index_int(0, 0, dbID);
	cache_delete(result);


	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	Pickup_SetPickupID(pickupIndex, dbID);
	Pickup_SetPickupEntranceModel(pickupIndex, DEFAULT_PICKUP_MODELID);
	Pickup_SetPickupEntranceType(pickupIndex, DEFAULT_PICKUP_TYPE);
	Pickup_SetPickupEntrancePos(pickupIndex, x, y, z);
	Pickup_SetPickupEntranceVW(pickupIndex, GetPlayerVirtualWorld(playerid));
	Pickup_SetPickupEntranceInt(pickupIndex, GetPlayerInterior(playerid));
	Pickup_SetPickupEntranceLabel(pickupIndex, "None");

	Pickup_SetPickupExitModel(pickupIndex, DEFAULT_PICKUP_MODELID);
	Pickup_SetPickupExitType(pickupIndex, DEFAULT_PICKUP_TYPE);
	Pickup_SetPickupExitPos(pickupIndex, 0.0, 0.0, 0.0);
	Pickup_SetPickupExitVW(pickupIndex, 0);
	Pickup_SetPickupExitInt(pickupIndex, 0);
	Pickup_SetPickupExitLabel(pickupIndex, "None");

	new query[1024];

	mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `pickups` SET `entranceModel` = '%d', `entranceType` = '%d', `entranceX` = '%f', `entranceY` = '%f', `entranceZ` = '%f', `entranceVirtualworld` = '%d', `entranceInteriorid` = '%d', `entranceLabel` = '%s', \
		`exitModel` = '%d', `exitType` = '%d', `exitX` = '%f', `exitY` = '%f', `exitZ` = '%f', `exitVirtualworld` = '%d', `exitInteriorid` = '%d' , `exitLabel` = '%s' \
		WHERE `id` = '%d';", \
	DEFAULT_PICKUP_MODELID, DEFAULT_PICKUP_TYPE, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), "None", \
	DEFAULT_PICKUP_MODELID, DEFAULT_PICKUP_TYPE, 0.0, 0.0, 0.0, 0, 0, "None", dbID);
	mysql_tquery(DB_GetHandler(), query);

	Pickup_CreatePickup(pickupIndex);
	return true;
}

CMD:deletepickup(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new pickupid;

	if (sscanf(params, "i", pickupid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /deletepickup [pickup Index]");
		return false;
	}

	if (!(-1 <= pickupid <= MAX_PICKUP))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Pickups] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gPickups, pickupid))
	{
		return false;
	}

	Iter_Remove(gPickups, pickupid);

	Pickup_DestroyPickup(pickupid);

	new query[64];
	mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `pickups` WHERE `id` = '%d'", Pickup_GetPickupID(pickupid));
	mysql_tquery(DB_GetHandler(), query);

	return true;
}

CMD:editpickup(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new pickupid;

	if (sscanf(params, "i", pickupid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /editpickup [pickup Index]");
		return false;
	}

	if (!(-1 <= pickupid <= MAX_PICKUP))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Pickups] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gPickups, pickupid))
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

			switch (listitem)
			{
				case 0, 6:
				{
					new x = strval(inputtextt);

					if (listitem == 0)
					{
						Pickup_SetPickupEntranceModel(pickupid, x);
					}
					else if (listitem == 6)
					{
						Pickup_SetPickupExitModel(pickupid, x);
					}
				}

				case 1, 7:
				{
					new x = strval(inputtextt);

					if (listitem == 1)
					{
						Pickup_SetPickupEntranceType(pickupid, x);
					}
					else if (listitem == 7)
					{
						Pickup_SetPickupExitType(pickupid, x);
					}
				}

				case 2, 8:
				{
					new Float:x, Float:y, Float:z;
					GetPlayerPos(playerid, x, y, z);

					if (listitem == 2)
					{
						Pickup_SetPickupEntrancePos(pickupid, x, y, z);
					}
					else if (listitem == 8)
					{
						Pickup_SetPickupExitPos(pickupid, x, y, z);
					}
				}

				case 3, 9:
				{
					new x = strval(inputtextt);

					if (listitem == 3)
					{
						Pickup_SetPickupEntranceVW(pickupid, x);
					}
					else if (listitem == 9)
					{
						Pickup_SetPickupExitVW(pickupid, x);
					}
				}

				case 4, 10:
				{
					new x = strval(inputtextt);
					if (listitem == 4)
					{
						Pickup_SetPickupEntranceInt(pickupid, x);
					}
					else if (listitem == 10)
					{
						Pickup_SetPickupExitInt(pickupid, x);
					}
				}

				case 5, 11:
				{
					if (listitem == 5)
					{
						Pickup_SetPickupEntranceLabel(pickupid, inputtextt);
					}
					else if (listitem == 11)
					{
						Pickup_SetPickupExitLabel(pickupid, inputtextt);
					}
				}

				default:
				{
					return false;
				}
			}

			Pickup_UpdatePickup(pickupid);
			Pickup_SavePickup(pickupid);
			return true;
		}
		Dialog_ShowCallback(playerid, using inline __response, DIALOG_STYLE_INPUT, !"{226db8} Pickups", "{FFFFFF}Gtxovt sheiyvanot axali parametri", !">>", !"X");

	}

	new Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2;
	Pickup_GetPickupEntrancePos(pickupid, x, y, z);
	Pickup_GetPickupExitPos(pickupid, x2, y2, z2);

	new label[MAX_PICKUP_LABEL_TEXT_LENGTH], label2[MAX_PICKUP_LABEL_TEXT_LENGTH];
	Pickup_GetPickupEntranceLabel(pickupid, label, MAX_PICKUP_LABEL_TEXT_LENGTH);
	Pickup_GetPickupExitLabel(pickupid, label2, MAX_PICKUP_LABEL_TEXT_LENGTH);

	new pickupInfo[512];
	format(pickupInfo, sizeof pickupInfo, "\
		entrance model\t\t%d\n\
		entrance type\t\t\t%d\n\
		entrance Pos\t\t\tx - %f y - %f z - %f\n\
		entrance virtualworld\t\t%d\n\
		entrance interiorid\t\t%d\n\
		entrance label\t\t\t%s\n\
		exit model\t\t\t%d\n\
		exit type\t\t\t%d\n\
		exit Pos\t\t\tx - %f y - %f z - %f\n\
		exit virtualworld\t\t%d\n\
		exit interiorid\t\t\t%d\n\
		exit label\t\t\t%s\n",\
	Pickup_GetPickupEntranceModel(pickupid), Pickup_GetPickupEntranceType(pickupid), x, y, z, Pickup_GetPickupEntranceVW(pickupid), Pickup_GetPickupEntranceInt(pickupid), label,\
	Pickup_GetPickupExitModel(pickupid), Pickup_GetPickupExitType(pickupid), x2, y2, z2, Pickup_GetPickupExitVW(pickupid), Pickup_GetPickupExitInt(pickupid), label2);
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Pickups", pickupInfo, !">>", !"X");
	return true;
}

CMD:gotopickup(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new pickupid;

	if (sscanf(params, "i", pickupid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /gotopickup [pickup Index]");
		return false;
	}
	if (!(-1 <= pickupid <= MAX_PICKUP))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Pickups] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gPickups, pickupid))
	{
		return false;
	}

	new Float:x, Float:y, Float:z;
	Pickup_GetPickupEntrancePos(pickupid, x, y, z);
	AC_SetPlayerPos(playerid, x, y, z, true);
	AC_SetPlayerVirtualWorld(playerid, Pickup_GetPickupEntranceVW(pickupid), true);
	AC_SetPlayerInteriorID(playerid, Pickup_GetPickupEntranceInt(pickupid), true);
	return true;
}

CMD:reloadpickups(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new pickupid : gPickups)
	{
		Pickup_UpdatePickup(pickupid);
	}
	return true;
}

CMD:getallpickups(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new pickupid : gPickups)
	{
		new text[144], entranceLabel[MAX_PICKUP_LABEL_TEXT_LENGTH], exitLabel[MAX_PICKUP_LABEL_TEXT_LENGTH];
		Pickup_GetPickupEntranceLabel(pickupid, entranceLabel, MAX_PICKUP_LABEL_TEXT_LENGTH);
		Pickup_GetPickupExitLabel(pickupid, exitLabel, MAX_PICKUP_LABEL_TEXT_LENGTH);
		format(text, sizeof text, "Index - %d | ID - %d | Entrance label %s {F7E54B}| Exit label %s", pickupid, Pickup_GetPickupID(pickupid), entranceLabel, exitLabel);
		SendClientMessage(playerid, COLOUR_INFORMATION, text);
		SendClientMessage(playerid, COLOUR_INFORMATION, !"~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	return true;
}

CMD:pickupdebugger(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	if (!IsPickupDebuggerEnabled(playerid))
	{
		Pickup_EnablePickupDebugger(playerid, true);
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Pickup Debugger enabled");
		return true;
	}

	Pickup_EnablePickupDebugger(playerid, false);
	SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Pickup Debugger disabled");
	return true;
}
