#if defined MAX_HOUSES
	#error MAX_HOUSES is already defined
#endif
#define		MAX_HOUSES						700

#if defined INVALID_HOUSE_ID
	#error INVALID_HOUSE_ID is already defined
#endif
#define		INVALID_HOUSE_ID				cellmax

#if defined MAX_HOUSE_LABEL_TEXT
	#error MAX_HOUSE_LABEL_TEXT is already defined
#endif
#define		MAX_HOUSE_LABEL_TEXT			128

#if defined HOUSE_DEFAULT_OWNER_NAME
	#error HOUSE_DEFAULT_OWNER_NAME is already defined
#endif
#define		HOUSE_DEFAULT_OWNER_NAME		"NO"

#if defined HOUSE_DEFUALT_LOCK_STATUS
	#error HOUSE_DEFUALT_LOCK_STATUS is already defined
#endif
#define		HOUSE_DEFUALT_LOCK_STATUS		true

#if defined HOUSE_DEFAULT_PURCHASE_PRICE
	#error HOUSE_DEFAULT_PURCHASE_PRICE is already defined
#endif
#define HOUSE_DEFAULT_PURCHASE_PRICE		10000

#if defined HOUSE_DEFAULT_CLASS_TYPE
	#error HOUSE_DEFAULT_CLASS_TYPE is already defined
#endif
#define HOUSE_DEFAULT_CLASS_TYPE			0

#if defined HOUSE_DEFAULT_INTERIOR_ID
	#error HOUSE_DEFAULT_INTERIOR_ID is already defined
#endif
#define HOUSE_DEFAULT_INTERIOR_ID			0

#if defined HOUSE_DEFAULT_ELECTRICITY_FEE
	#error HOUSE_DEFAULT_ELECTRICITY_FEE is already defined
#endif
#define HOUSE_DEFAULT_ELECTRICITY_FEE		100

#if defined HOUSE_DEFAULT_MAINTENANCE_FEE
	#error HOUSE_DEFAULT_MAINTENANCE_FEE is already defined
#endif
#define HOUSE_DEFAULT_MAINTENANCE_FEE		100

#if defined HOUSE_DEFAULT_LAND_FEE
	#error HOUSE_DEFAULT_LAND_FEE is already defined
#endif
#define HOUSE_DEFAULT_LAND_FEE				100

#if defined HOUSE_DEFAULT_SECURITY_LEVEL
	#error HOUSE_DEFAULT_SECURITY_LEVEL is already defined
#endif
#define HOUSE_DEFAULT_SECURITY_LEVEL		0




enum _:E_HOUSE_SECURITY_LEVELS
{
	E_HOUSE_SECURITY_LEVEL_NONE,
	E_HOUSE_SECURITY_LEVEL_ONE,
	E_HOUSE_SECURITY_LEVEL_TWO,
	E_HOUSE_SECURITY_LEVEL_THREE
};

enum _:E_HOUSE_CLASS_TYPES
{
	E_HOUSE_CLASS_TYPE_NONE,
	E_HOUSE_CLASS_TYPE_F, // 1 TACHKA
	E_HOUSE_CLASS_TYPE_D, // 1 TACHKA
	E_HOUSE_CLASS_TYPE_C,//maximum 2
	E_HOUSE_CLASS_TYPE_B,//maximum 2
	E_HOUSE_CLASS_TYPE_A,// 4
	E_HOUSE_CLASS_TYPE_S,// 5
	E_HOUSE_CLASS_TYPE_ELITE
};


static
		gHouseID[MAX_HOUSES],
		gHouseOwnerName[MAX_HOUSES][MAX_PLAYER_NAME],
bool:	gHouseLockStatus[MAX_HOUSES],
		gHousePurchasePrice[MAX_HOUSES],
		gHouseClassType[MAX_HOUSES],
		gHouseInteriorID[MAX_HOUSES],
		gHouseElectricityFee[MAX_HOUSES],
		gHouseMaintenanceFee[MAX_HOUSES],
		gHouseLandFee[MAX_HOUSES],
		gHouseSecurityLevel[MAX_HOUSES],

Text3D:	gHouseEntrancePickupLabel[MAX_HOUSES],
Float:	gHouseEntrancePosX[MAX_HOUSES],
Float:	gHouseEntrancePosY[MAX_HOUSES],
Float:	gHouseEntrancePosZ[MAX_HOUSES],

Float:	gHouseExitPosX[MAX_HOUSES],
Float:	gHouseExitPosY[MAX_HOUSES],
Float:	gHouseExitPosZ[MAX_HOUSES],

Float:	gHouseSpawnPosX[MAX_HOUSES],
Float:	gHouseSpawnPosY[MAX_HOUSES],
Float:	gHouseSpawnPosZ[MAX_HOUSES],
Float:	gHouseSpawnPosAngle[MAX_HOUSES],

		gHouseSpawnPosVirtualWorld[MAX_HOUSES],
		gHouseSpawnPosInteriorID[MAX_HOUSES],
		gHouseMapIcon[MAX_HOUSES];

new
		gHouseEntrancePickup[MAX_HOUSES],
		Iterator:gHouses<MAX_HOUSES>;



stock House_SetHouseID(index, ID)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseID[index] = ID;
}

stock House_GetHouseID(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseID[index];
}

stock House_SetHouseOwnerName(index, const name[])
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseOwnerName[index][0] = EOS;
	strcat(gHouseOwnerName[index], name, MAX_PLAYER_NAME);
}

stock House_GetHouseOwnerName(index, output[], length = MAX_PLAYER_NAME)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	strcat(output, gHouseOwnerName[index], length);
}


stock House_SetHouseLockStatus(index, bool:value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseLockStatus[index] = value;
}

stock bool:House_GetHouseLockStatus(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return false;
	}

	return gHouseLockStatus[index];
}

stock House_SetHousePurchasePrice(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHousePurchasePrice[index] = value;
}

stock House_GetHousePurchasePrice(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHousePurchasePrice[index];
}

stock House_SetHouseClassType(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseClassType[index] = value;
}

stock House_GetHouseClassType(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseClassType[index];
}

stock House_SetHouseInteriorID(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseInteriorID[index] = value;
}

stock House_GetHouseInteriorID(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseInteriorID[index];
}


stock House_SetHouseElectricityFee(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseElectricityFee[index] = value;
}

stock House_GetHouseElectricityFee(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseElectricityFee[index];
}

stock House_SetHouseMaintenanceFee(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseMaintenanceFee[index] = value;
}

stock House_GetHouseMaintenanceFee(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseMaintenanceFee[index];
}

stock House_SetHouseLandFee(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseLandFee[index] = value;
}

stock House_GetHouseLandFee(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseLandFee[index];
}

stock House_SetHouseSecurityLevel(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	if (value < E_HOUSE_SECURITY_LEVEL_NONE)
	{
		value = E_HOUSE_SECURITY_LEVEL_NONE;
	}
	else if (value > E_HOUSE_SECURITY_LEVEL_THREE)
	{
		value = E_HOUSE_SECURITY_LEVEL_THREE;
	}

	gHouseSecurityLevel[index] = value;
}

stock House_GetHouseSecurityLevel(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseSecurityLevel[index];
}

stock House_SetHouseEntrancePos(index, Float:posX, Float:posY, Float:posZ)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseEntrancePosX[index] = posX;
	gHouseEntrancePosY[index] = posY;
	gHouseEntrancePosZ[index] = posZ;

}

stock House_GetHouseEntrancePos(index, &Float:posX, &Float:posY, &Float:posZ)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	posX = gHouseEntrancePosX[index];
	posY = gHouseEntrancePosY[index];
	posZ = gHouseEntrancePosZ[index];
}

stock House_SetHouseExitPos(index, Float:posX, Float:posY, Float:posZ)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseExitPosX[index] = posX;
	gHouseExitPosY[index] = posY;
	gHouseExitPosZ[index] = posZ;

}

stock House_GetHouseExitPos(index, &Float:posX, &Float:posY, &Float:posZ)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	posX = gHouseExitPosX[index];
	posY = gHouseExitPosY[index];
	posZ = gHouseExitPosZ[index];
}

stock House_SetHouseSpawnPos(index, Float:posX, Float:posY, Float:posZ, Float:posAngle)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseSpawnPosX[index] = posX;
	gHouseSpawnPosY[index] = posY;
	gHouseSpawnPosZ[index] = posZ;
	gHouseSpawnPosAngle[index] = posAngle;

}

stock House_GetHouseSpawnPos(index, &Float:posX, &Float:posY, &Float:posZ, &Float:posAngle)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	posX = gHouseSpawnPosX[index];
	posY = gHouseSpawnPosY[index];
	posZ = gHouseSpawnPosZ[index];
	posAngle = gHouseSpawnPosAngle[index];
}

stock House_SetHouseSpawnVirtualWorld(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseSpawnPosVirtualWorld[index] = value;
}

stock House_GetHouseSpawnVirtualWorld(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseSpawnPosVirtualWorld[index];
}

stock House_SetHouseSpawnInteriorID(index, value)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseSpawnPosInteriorID[index] = value;
}

stock House_GetHouseSpawnInteriorID(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return INVALID_HOUSE_ID;
	}

	return gHouseSpawnPosInteriorID[index];
}

stock House_CreateHouse(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	gHouseEntrancePickup[index] =
		CreateDynamicPickup((gHouseLockStatus[index]) ? 19470 : 19522, 23, gHouseEntrancePosX[index], gHouseEntrancePosY[index], gHouseEntrancePosZ[index]);

	new text[128];

	if (!strcmp(gHouseOwnerName[index], "No", true))
	{
		format(text, sizeof text, "House ID: %d\nFor Sale\nPrice: $%d", index, gHousePurchasePrice[index]);
	}
	else
	{
		format(text, sizeof text, "House ID: %d\nOwner: %s", index, gHouseOwnerName[index]);
	}

	gHouseEntrancePickupLabel[index] =
		CreateDynamic3DTextLabel(text, COLOUR_WHITE, \
		gHouseEntrancePosX[index], gHouseEntrancePosY[index], gHouseEntrancePosZ[index], 8.0);

	gHouseMapIcon[index] =
		CreateDynamicMapIcon(gHouseEntrancePosX[index], gHouseEntrancePosY[index], gHouseEntrancePosZ[index], \
		(gHouseLockStatus[index] ? 31 : 32), COLOUR_WHITE);
	return;
}

stock House_UpdateHouse(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	House_DeleteHouse(index);
	House_CreateHouse(index);
	return;
}

stock House_DeleteHouse(index)
{
	if (!(-1 <= index <= MAX_HOUSES))
	{
		return;
	}

	DestroyDynamicPickup(gHouseEntrancePickup[index]);
	DestroyDynamic3DTextLabel(gHouseEntrancePickupLabel[index]);
	DestroyDynamicMapIcon(gHouseMapIcon[index]);
	return;
}
