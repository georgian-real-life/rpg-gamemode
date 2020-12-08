#include	<YSI_Coding\y_hooks>


enum _:E_HOUSE_DATABASE_INDEXES
{
	E_HOUSE_DATABASE_ID,
	E_HOUSE_DATABASE_OWNER_NAME,
	E_HOUSE_DATABASE_LOCK_STATUS,
	E_HOUSE_DATABASE_PURCHASE_PRICE,
	E_HOUSE_DATABASE_CLASS_TYPE,
	E_HOUSE_DATABASE_INTERIOR_ID,
	E_HOUSE_DATABASE_ELECTRICITYFEE,
	E_HOUSE_DATABASE_MAINTENANCEFEE,
	E_HOUSE_DATABASE_LAND_FEE,
	E_HOUSE_DATABASE_SECURITY_LEVEL,
	E_HOUSE_DATABASE_ENTRANCE_POSX,
	E_HOUSE_DATABASE_ENTRANCE_POSY,
	E_HOUSE_DATABASE_ENTRANCE_POSZ,
	E_HOUSE_DATABASE_EXIT_POSX,
	E_HOUSE_DATABASE_EXIT_POSY,
	E_HOUSE_DATABASE_EXIT_POSZ,
	E_HOUSE_DATABASE_SPAWN_POSX,
	E_HOUSE_DATABASE_SPAWN_POSY,
	E_HOUSE_DATABASE_SPAWN_POSZ,
	E_HOUSE_DATABASE_SPAWN_POSA,
	E_HOUSE_DATABASE_SPAWN_VWORLD,
	E_HOUSE_DATABASE_SPAWN_INT_ID
};


forward House@LoadHouses();
forward House@SaveHouse(houseIndex);


hook OnGameModeInit()
{
	mysql_tquery(DB_GetHandler(), "SELECT * FROM `house_data`", "House@LoadHouses");
	return 1;
}

public House@LoadHouses()
{
	new rows;
	cache_get_row_count(rows);

	if (rows == 0)
	{
		print("[Houses] Table is empty");
		return false;
	}

	new
			tempDatabaseID,
			tempOwnerName[MAX_PLAYER_NAME],
	bool:	tempLockStatus,
			tempPurchasePrice,
			tempClassType,
			tempInteriorID,
			tempElectricityFee,
			tempMaintenanceFee,
			tempLandFee,
			tempSecurityLevel,
	Float:	tempEntrancePosX,
	Float:	tempEntrancePosY,
	Float:	tempEntrancePosZ,
	Float:	tempExitPosX,
	Float:	tempExitPosY,
	Float:	tempExitPosZ,
	Float:	tempSpawnPosX,
	Float:	tempSpawnPosY,
	Float:	tempSpawnPosZ,
	Float:	tempSpawnPosA,
			tempSpawnVirtualworld,
			tempSpawnInteriorID;

	for (new i = 0; i < rows; i++)
	{
		new houseIndex = Iter_Alloc(gHouses);

		if (!(-1 <= houseIndex <= MAX_HOUSES))
		{
			print("[Houses] House buffer overflow");
			break;
		}

		cache_get_value_index_int(i, E_HOUSE_DATABASE_ID, tempDatabaseID);
		cache_get_value_index(i, E_HOUSE_DATABASE_OWNER_NAME, tempOwnerName, MAX_PLAYER_NAME);
		cache_get_value_index_bool(i, E_HOUSE_DATABASE_LOCK_STATUS, tempLockStatus);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_PURCHASE_PRICE, tempPurchasePrice);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_CLASS_TYPE, tempClassType);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_INTERIOR_ID, tempInteriorID);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_ELECTRICITYFEE, tempElectricityFee);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_MAINTENANCEFEE, tempMaintenanceFee);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_LAND_FEE, tempLandFee);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_SECURITY_LEVEL, tempSecurityLevel);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_ENTRANCE_POSX, tempEntrancePosX);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_ENTRANCE_POSY, tempEntrancePosY);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_ENTRANCE_POSZ, tempEntrancePosZ);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_EXIT_POSX, tempExitPosX);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_EXIT_POSY, tempExitPosY);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_EXIT_POSZ, tempExitPosZ);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_SPAWN_POSX, tempSpawnPosX);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_SPAWN_POSY, tempSpawnPosY);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_SPAWN_POSZ, tempSpawnPosZ);
		cache_get_value_index_float(i, E_HOUSE_DATABASE_SPAWN_POSA, tempSpawnPosA);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_SPAWN_VWORLD, tempSpawnVirtualworld);
		cache_get_value_index_int(i, E_HOUSE_DATABASE_SPAWN_INT_ID, tempSpawnInteriorID);

		House_SetHouseID(houseIndex, tempDatabaseID);
		House_SetHouseOwnerName(houseIndex, tempOwnerName);
		House_SetHouseLockStatus(houseIndex, tempLockStatus);
		House_SetHousePurchasePrice(houseIndex, tempPurchasePrice);
		House_SetHouseClassType(houseIndex, tempClassType);
		House_SetHouseInteriorID(houseIndex, tempInteriorID);
		House_SetHouseElectricityFee(houseIndex, tempElectricityFee);
		House_SetHouseMaintenanceFee(houseIndex, tempMaintenanceFee);
		House_SetHouseLandFee(houseIndex, tempLandFee);
		House_SetHouseSecurityLevel(houseIndex, tempSecurityLevel);
		House_SetHouseEntrancePos(houseIndex, tempEntrancePosX, tempEntrancePosY, tempEntrancePosZ);
		House_SetHouseExitPos(houseIndex, tempExitPosX, tempExitPosY, tempExitPosZ);
		House_SetHouseSpawnPos(houseIndex, tempSpawnPosX, tempSpawnPosY, tempSpawnPosZ, tempSpawnPosA);
		House_SetHouseSpawnVirtualWorld(houseIndex, tempSpawnVirtualworld);
		House_SetHouseSpawnInteriorID(houseIndex, tempSpawnInteriorID);

		House_CreateHouse(houseIndex);
	}

	printf("[Houses] Loaded %d houses", Iter_Count(gHouses));
	return true;
}

public House@SaveHouse(houseIndex)
{
	if (!(-1 <= houseIndex <= MAX_HOUSES))
	{
		print("[Houses] House buffer overflow");
		return false;
	}

	new
			tempDatabaseID,
			tempOwnerName[MAX_PLAYER_NAME],
	bool:	tempLockStatus,
			tempPurchasePrice,
			tempClassType,
			tempInteriorID,
			tempElectricityFee,
			tempMaintenanceFee,
			tempLandFee,
			tempSecurityLevel,
	Float:	tempEntrancePosX,
	Float:	tempEntrancePosY,
	Float:	tempEntrancePosZ,
	Float:	tempExitPosX,
	Float:	tempExitPosY,
	Float:	tempExitPosZ,
	Float:	tempSpawnPosX,
	Float:	tempSpawnPosY,
	Float:	tempSpawnPosZ,
	Float:	tempSpawnPosA,
			tempSpawnVirtualworld,
			tempSpawnInteriorID;

	tempDatabaseID = House_GetHouseID(houseIndex);
	House_GetHouseOwnerName(houseIndex, tempOwnerName);
	tempLockStatus = House_GetHouseLockStatus(houseIndex);
	tempPurchasePrice = House_GetHousePurchasePrice(houseIndex);
	tempClassType = House_GetHouseClassType(houseIndex);
	tempInteriorID = House_GetHouseInteriorID(houseIndex);
	tempElectricityFee = House_GetHouseElectricityFee(houseIndex);
	tempMaintenanceFee = House_GetHouseMaintenanceFee(houseIndex);
	tempLandFee = House_GetHouseLandFee(houseIndex);
	tempSecurityLevel = House_GetHouseSecurityLevel(houseIndex);
	House_GetHouseEntrancePos(houseIndex, tempEntrancePosX, tempEntrancePosY, tempEntrancePosZ);
	House_GetHouseExitPos(houseIndex, tempExitPosX, tempExitPosY, tempExitPosZ);
	House_GetHouseSpawnPos(houseIndex, tempSpawnPosX, tempSpawnPosY, tempSpawnPosZ, tempSpawnPosA);
	tempSpawnVirtualworld = House_GetHouseSpawnVirtualWorld(houseIndex);
	tempSpawnInteriorID = House_GetHouseSpawnInteriorID(houseIndex);

	new query[1024];
	mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `house_data` SET `owner`='%s',`lockstatus`= '%d',`purchasePrice`='%d', \
		`classType`= '%d',`interiorID`='%d',`electricityFee`= '%d' ,`maintenanceFee`= '%d', \
		`landFee`= '%d',`securityLevel`= '%d',`entrancePosX`= '%f',`entrancePosY`='%f',`entrancePosZ`='%f', \
		`exitPosX`='%f',`exitPosY`='%f',`exitPosZ`='%f',`spawnPosX`='%f',`spawnPosY`='%f', \
		`spawnPosZ`='%f',`spawnPosAngle`='%f',`spawnVirtualworld`='%f',`spawnInteriorID`='%f' WHERE `id` = %d",
	tempOwnerName, tempLockStatus, tempPurchasePrice, tempClassType, tempInteriorID, tempElectricityFee, tempMaintenanceFee, tempLandFee,
	tempSecurityLevel, tempEntrancePosX, tempEntrancePosY, tempEntrancePosZ, tempExitPosX, tempExitPosY, tempExitPosZ, tempSpawnPosX,
	tempSpawnPosY, tempSpawnPosZ, tempSpawnPosA, tempSpawnVirtualworld, tempSpawnInteriorID, tempDatabaseID);

	mysql_query(DB_GetHandler(), query, false);

	return true;
}
