#if defined MAX_PICKUP
	#error MAX_PICKUP Already defined
#endif
#define MAX_PICKUP		256

#if defined DEFAULT_PICKUP_MODELID
	#error DEFAULT_PICKUP_MODELID Already defined
#endif
#define DEFAULT_PICKUP_MODELID		19198

#if defined DEFAULT_PICKUP_TYPE
	#error DEFAULT_PICKUP_TYPE Already defined
#endif
#define DEFAULT_PICKUP_TYPE		23

#if defined MAX_PICKUP_LABEL_TEXT_LENGTH
	#error MAX_PICKUP_LABEL_TEXT_LENGTH Already defined
#endif
#define MAX_PICKUP_LABEL_TEXT_LENGTH		128

#if defined INVALID_PICKUP_ID
	#error INVALID_PICKUP_ID Already defined
#endif
#define INVALID_PICKUP_ID		cellmax


static
		gPickupID[MAX_PICKUP],
		gPickupEntranceModel[MAX_PICKUP],
		gPickupEntranceType[MAX_PICKUP],
Float:	gPickupEntrancePosX[MAX_PICKUP],
Float:	gPickupEntrancePosY[MAX_PICKUP],
Float:	gPickupEntrancePosZ[MAX_PICKUP],
		gPickupEntranceVirtualworld[MAX_PICKUP],
		gPickupEntranceInteriorid[MAX_PICKUP],
		gPickupEntranceLabelText[MAX_PICKUP][MAX_PICKUP_LABEL_TEXT_LENGTH],
Text3D:	gPickupEntranceLabel[MAX_PICKUP],

		gPickupExitModel[MAX_PICKUP],
		gPickupExitType[MAX_PICKUP],
Float:	gPickupExitPosX[MAX_PICKUP],
Float:	gPickupExitPosY[MAX_PICKUP],
Float:	gPickupExitPosZ[MAX_PICKUP],
		gPickupExitVirtualworld[MAX_PICKUP],
		gPickupExitInteriorid[MAX_PICKUP],
Text3D:	gPickupExitLabel[MAX_PICKUP],
		gPickupExitLabelText[MAX_PICKUP][MAX_PICKUP_LABEL_TEXT_LENGTH];

static bool:gPickupDebugger[MAX_PLAYERS];


new Iterator:gPickups<MAX_PICKUP>;

new
	gPickupEntrancePickup[MAX_PICKUP],
	gPickupExitPickup[MAX_PICKUP];


stock Pickup_SetPickupID(index, ID)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupID[index] = ID;
	return true;
}

stock Pickup_GetPickupID(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupID[index];
}

stock Pickup_SetPickupEntranceModel(index, modelID)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupEntranceModel[index] = modelID;
	return true;
}

stock Pickup_GetPickupEntranceModel(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupEntranceModel[index];
}

stock Pickup_SetPickupEntranceType(index, type)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupEntranceType[index] = type;
	return true;
}

stock Pickup_GetPickupEntranceType(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupEntranceType[index];
}

stock Pickup_SetPickupEntrancePos(index, Float:posX, Float:posY, Float:posZ)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupEntrancePosX[index] = posX;
	gPickupEntrancePosY[index] = posY;
	gPickupEntrancePosZ[index] = posZ;
	return true;
}

stock Pickup_GetPickupEntrancePos(index, &Float:posX, &Float:posY, &Float:posZ)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	posX = gPickupEntrancePosX[index];
	posY = gPickupEntrancePosY[index];
	posZ = gPickupEntrancePosZ[index];
	return true;
}

stock Pickup_SetPickupEntranceVW(index, virtualworld)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupEntranceVirtualworld[index] = virtualworld;
	return true;
}

stock Pickup_GetPickupEntranceVW(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupEntranceVirtualworld[index];
}

stock Pickup_SetPickupEntranceInt(index, interiorid)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupEntranceInteriorid[index] = interiorid;
	return true;
}

stock Pickup_GetPickupEntranceInt(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupEntranceInteriorid[index];
}

stock Pickup_SetPickupEntranceLabel(index, const text[])
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupEntranceLabelText[index][0] = EOS;
	strcat(gPickupEntranceLabelText[index], text, MAX_PICKUP_LABEL_TEXT_LENGTH);
	return true;
}

stock Pickup_GetPickupEntranceLabel(index, output[], length)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	strcat(output, gPickupEntranceLabelText[index], length);
	return true;
}

stock Pickup_SetPickupExitModel(index, modelID)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupExitModel[index] = modelID;
	return true;
}

stock Pickup_GetPickupExitModel(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupExitModel[index];
}

stock Pickup_SetPickupExitType(index, type)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupExitType[index] = type;
	return true;
}

stock Pickup_GetPickupExitType(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupExitType[index];
}

stock Pickup_SetPickupExitPos(index, Float:posX, Float:posY, Float:posZ)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupExitPosX[index] = posX;
	gPickupExitPosY[index] = posY;
	gPickupExitPosZ[index] = posZ;
	return true;
}

stock Pickup_GetPickupExitPos(index, &Float:posX, &Float:posY, &Float:posZ)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	posX = gPickupExitPosX[index];
	posY = gPickupExitPosY[index];
	posZ = gPickupExitPosZ[index];
	return true;
}

stock Pickup_SetPickupExitVW(index, virtualworld)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupExitVirtualworld[index] = virtualworld;
	return true;
}

stock Pickup_GetPickupExitVW(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupExitVirtualworld[index];
}

stock Pickup_SetPickupExitInt(index, interiorid)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupExitInteriorid[index] = interiorid;
	return true;
}

stock Pickup_GetPickupExitInt(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	return gPickupExitInteriorid[index];
}

stock Pickup_SetPickupExitLabel(index, const text[])
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupExitLabelText[index][0] = EOS;
	strcat(gPickupExitLabelText[index], text, MAX_PICKUP_LABEL_TEXT_LENGTH);
	return true;
}

stock Pickup_GetPickupExitLabel(index, output[], length)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return INVALID_PICKUP_ID;
	}

	strcat(output, gPickupExitLabelText[index], length);
	return true;
}

stock Pickup_CreatePickup(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	gPickupEntrancePickup[index] =
		CreateDynamicPickup(gPickupEntranceModel[index], gPickupEntranceType[index], gPickupEntrancePosX[index], gPickupEntrancePosY[index], gPickupEntrancePosZ[index],\
	gPickupEntranceVirtualworld[index], gPickupEntranceInteriorid[index]);

	gPickupExitPickup[index] =
		CreateDynamicPickup(gPickupExitModel[index], gPickupExitType[index], gPickupExitPosX[index], gPickupExitPosY[index], gPickupExitPosZ[index],\
	gPickupExitVirtualworld[index], gPickupExitInteriorid[index]);

	gPickupEntranceLabel[index] =
		CreateDynamic3DTextLabel(gPickupEntranceLabelText[index], COLOUR_WHITE, gPickupEntrancePosX[index], gPickupEntrancePosY[index], gPickupEntrancePosZ[index], 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, gPickupEntranceVirtualworld[index], gPickupEntranceInteriorid[index]);

	gPickupExitLabel[index] =
		CreateDynamic3DTextLabel(gPickupExitLabelText[index], COLOUR_WHITE, gPickupExitPosX[index], gPickupExitPosY[index], gPickupExitPosZ[index], 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, gPickupExitVirtualworld[index], gPickupExitInteriorid[index]);
	return true;
}

stock Pickup_UpdatePickup(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	Pickup_DestroyPickup(index);

	Pickup_CreatePickup(index);
	return true;
}

stock Pickup_DestroyPickup(index)
{
	if (!(-1 <= index <= MAX_PICKUP))
	{
		return false;
	}

	DestroyDynamicPickup(gPickupEntrancePickup[index]);
	DestroyDynamicPickup(gPickupExitPickup[index]);
	DestroyDynamic3DTextLabel(gPickupEntranceLabel[index]);
	DestroyDynamic3DTextLabel(gPickupExitLabel[index]);
	return true;
}

stock Pickup_EnablePickupDebugger(playerid, bool:toggle)
{
	gPickupDebugger[playerid] = toggle;
	return true;
}

stock IsPickupDebuggerEnabled(playerid)
{
	return gPickupDebugger[playerid] ? true : false;
}
