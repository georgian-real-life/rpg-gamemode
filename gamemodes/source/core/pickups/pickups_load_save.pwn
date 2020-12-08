#include	<YSI_Coding\y_hooks>


forward Pickup_LoadPickups();


hook OnScriptInit()
{
	mysql_tquery(DB_GetHandler(), "SELECT * FROM `pickups`", "Pickup_LoadPickups");
	return true;
}


public Pickup_LoadPickups()
{
	new rows;
	cache_get_row_count(rows);

	if (!rows)
	{
		return false;
	}

	for (new i = 0; i < rows; i++)
	{
		new pickupIndex = Iter_Alloc(gPickups);

		if (!(-1 <= pickupIndex <= MAX_PICKUP))
		{
			print("[Pickups] Pickups buffer overflow");
			break;
		}

		new
			tempPickupID,
			tempEntranceModel,
			tempEntranceType,
		Float:tempEntranceX,
		Float:tempEntranceY,
		Float:tempEntranceZ,
			tempEntranceVirtualworld,
			tempEntranceInteriorid,
			tempEntranceLabel[MAX_PICKUP_LABEL_TEXT_LENGTH],

			tempExitModel,
			tempExitType,
		Float:tempExitX,
		Float:tempExitY,
		Float:tempExitZ,
			tempExitVirtualworld,
			tempExitInteriorid,
			tempExitLabel[MAX_PICKUP_LABEL_TEXT_LENGTH];

		cache_get_value_index_int(i, 0, tempPickupID);
		cache_get_value_index_int(i, 1, tempEntranceModel);
		cache_get_value_index_int(i, 2, tempEntranceType);
		cache_get_value_index_float(i, 3, tempEntranceX);
		cache_get_value_index_float(i, 4, tempEntranceY);
		cache_get_value_index_float(i, 5, tempEntranceZ);
		cache_get_value_index_int(i, 6, tempEntranceVirtualworld);
		cache_get_value_index_int(i, 7, tempEntranceInteriorid);
		cache_get_value_index(i, 8, tempEntranceLabel, MAX_PICKUP_LABEL_TEXT_LENGTH);

		cache_get_value_index_int(i, 9, tempExitModel);
		cache_get_value_index_int(i, 10, tempExitType);
		cache_get_value_index_float(i, 11, tempExitX);
		cache_get_value_index_float(i, 12, tempExitY);
		cache_get_value_index_float(i, 13, tempExitZ);
		cache_get_value_index_int(i, 14, tempExitVirtualworld);
		cache_get_value_index_int(i, 15, tempExitInteriorid);
		cache_get_value_index(i, 16, tempExitLabel, MAX_PICKUP_LABEL_TEXT_LENGTH);

		Pickup_SetPickupID(pickupIndex, tempPickupID);
		Pickup_SetPickupEntranceModel(pickupIndex, tempEntranceModel);
		Pickup_SetPickupEntranceType(pickupIndex, tempEntranceType);
		Pickup_SetPickupEntrancePos(pickupIndex, tempEntranceX, tempEntranceY, tempEntranceZ);
		Pickup_SetPickupEntranceVW(pickupIndex, tempEntranceVirtualworld);
		Pickup_SetPickupEntranceInt(pickupIndex, tempEntranceInteriorid);
		Pickup_SetPickupEntranceLabel(pickupIndex, tempEntranceLabel);

		Pickup_SetPickupExitModel(pickupIndex, tempExitModel);
		Pickup_SetPickupExitType(pickupIndex, tempExitType);
		Pickup_SetPickupExitPos(pickupIndex, tempExitX, tempExitY, tempExitZ);
		Pickup_SetPickupExitVW(pickupIndex, tempExitVirtualworld);
		Pickup_SetPickupExitInt(pickupIndex, tempExitInteriorid);
		Pickup_SetPickupExitLabel(pickupIndex, tempExitLabel);

		Pickup_CreatePickup(pickupIndex);
	}

	printf("\n[Pickups] Loaded %d", rows);
	return true;
}


stock Pickup_SavePickup(pickup)
{
	if (!(-1 <= pickup <= MAX_PICKUP))
	{
		return false;
	}

	new tempPickupID = Pickup_GetPickupID(pickup);
	new tempEntranceModel = Pickup_GetPickupEntranceModel(pickup);
	new tempEntranceType = Pickup_GetPickupEntranceType(pickup);
	new tempEntranceVW = Pickup_GetPickupEntranceVW(pickup);
	new tempEntranceInterior = Pickup_GetPickupEntranceInt(pickup);
	new tempEntranceLabel[MAX_PICKUP_LABEL_TEXT_LENGTH + 1];
	Pickup_GetPickupEntranceLabel(pickup, tempEntranceLabel, MAX_PICKUP_LABEL_TEXT_LENGTH);

	new tempExitModel = Pickup_GetPickupExitModel(pickup);
	new tempExitType = Pickup_GetPickupExitType(pickup);
	new tempExitVW = Pickup_GetPickupExitVW(pickup);
	new tempExitInterior = Pickup_GetPickupExitInt(pickup);
	new tempExitLabel[MAX_PICKUP_LABEL_TEXT_LENGTH + 1];
	Pickup_GetPickupExitLabel(pickup, tempExitLabel, MAX_PICKUP_LABEL_TEXT_LENGTH);

	new Float:x, Float:y, Float:z, Float:x2, Float:z2, Float:y2;
	Pickup_GetPickupEntrancePos(pickup, x, y, z);
	Pickup_GetPickupExitPos(pickup, x2, y2, z2);

	new query[1024];
	mysql_format(DB_GetHandler(), query, sizeof query, \
	"UPDATE `pickups` SET `entranceModel` = '%d', `entranceType` = '%d', `entranceX` = '%f', `entranceY` = '%f', `entranceZ` = '%f', `entranceVirtualworld` = '%d', `entranceInteriorid` = '%d', `entranceLabel` = '%s', \
	`exitModel` = '%d', `exitType` = '%d', `exitX` = '%f', `exitY` = '%f', `exitZ` = '%f', `exitVirtualworld` = '%d', `exitInteriorid` = '%d' , `exitLabel` = '%s' \
	WHERE `id` = '%d';", \
	tempEntranceModel, tempEntranceType, x, y, z, tempEntranceVW, tempEntranceInterior, tempEntranceLabel, \
	tempExitModel, tempExitType, x2, y2, z2, tempExitVW, tempExitInterior, tempExitLabel, tempPickupID);
	mysql_tquery(DB_GetHandler(), query);
	return true;
}
