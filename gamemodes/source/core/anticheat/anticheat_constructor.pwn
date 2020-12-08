#if defined INVALID_WEAPON_ID
	#error INVALID_WEAPON_ID Already defined
#endif
#define INVALID_WEAPON_ID		0xFFFF

#if defined INVALID_WEAPON_AMMO
	#error INVALID_WEAPON_AMMO Already defined
#endif
#define INVALID_WEAPON_AMMO		0xFFFF


enum _:E_ANTICHEAT_CODES
{
	E_ANTICHEAT_CODE_NONE,
	E_ANTICHEAT_CODE_INVALID_ANIM,
	E_ANTICHEAT_CODE_JETPACK,
	E_ANTICHEAT_CODE_3ZDARVANKA,
	E_ANTICHEAT_CODE_FLY_CHEAT,
	E_ANTICHEAT_CODE_AIRBREAK,

	E_ANTICHEAT_CODE_WEAPON,
	E_ANTICHEAT_CODE_WEAPON_AMMO,

	E_ANTICHEAT_CODE_DRIVER2DRIVER,
	E_ANTICHEAT_CODE_DRIVER2PASSNGR,
	E_ANTICHEAT_CODE_PASSNGR2DRIVER,
	E_ANTICHEAT_CODE_PASSNGR2PASSNG,
	E_ANTICHEAT_CODE_VEHICLESPAWNER,
	E_ANTICHEAT_CODE_VEHICLETP,

	E_ANTICHEAT_CODE_BULLET_CRASH1,
	E_ANTICHEAT_CODE_BULLET_CRASH2,
	E_ANTICHEAT_CODE_BULLET_CRASH3,

};


static
Float:	gACPlayerPos_X[MAX_PLAYERS],
Float:	gACPlayerPos_Y[MAX_PLAYERS],
Float:	gACPlayerPos_Z[MAX_PLAYERS],
		gACVirtualWorld[MAX_PLAYERS],
		gACInteriorID[MAX_PLAYERS],

		gACWeaponID[MAX_PLAYERS][13] = {INVALID_WEAPON_ID, ...},
		gACWeaponAmmo[MAX_PLAYERS][13] = {INVALID_WEAPON_AMMO, ...},

		gACVehicleEntranceCount[MAX_PLAYERS],
		gACVehicleID[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};



stock AC_SetPlayerPos(playerid, Float:posX, Float:posY, Float:posZ, bool:updatePos = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	gACPlayerPos_X[playerid] = posX;
	gACPlayerPos_Y[playerid] = posY;
	gACPlayerPos_Z[playerid] = posZ;

	if (updatePos)
	{
		SetPlayerPos(playerid, posX, posY, posZ);
	}

	return true;
}

stock AC_GetPlayerPos(playerid, &Float:posX, &Float:posY, &Float:posZ)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	posX = gACPlayerPos_X[playerid];
	posY = gACPlayerPos_Y[playerid];
	posZ = gACPlayerPos_Z[playerid];
	return true;
}

stock AC_SetPlayerVirtualWorld(playerid, virtualworld, bool:updateVirtualWorld)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	gACVirtualWorld[playerid] = virtualworld;

	if (updateVirtualWorld)
	{
		SetPlayerVirtualWorld(playerid, virtualworld);
	}
	return true;
}

stock AC_GetPlayerVirtualWorld(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gACVirtualWorld[playerid];
}

stock AC_SetPlayerInteriorID(playerid, interiorid, bool:updateInterior)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	gACInteriorID[playerid] = interiorid;

	if (updateInterior)
	{
		SetPlayerInterior(playerid, interiorid);
	}
	return true;
}

stock AC_GetPlayerInteriorID(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gACInteriorID[playerid];
}

stock AC_GivePlayerWeapon(playerid, weaponid, ammo)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	new weaponSlot; AC_GetWeaponSlotByWeaponID(weaponid, weaponSlot);

	if (weaponSlot == 0xFF)
	{
		return false;
	}

	AC_ResetPlayerWeaponData(playerid, weaponSlot);

	gACWeaponID[playerid][weaponSlot] = weaponid;
	gACWeaponAmmo[playerid][weaponSlot] = ammo;

	AC_GivePlayerAllWeapon(playerid);
	return true;
}

stock AC_GivePlayerAllWeapon(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	for (new i = 0; i <=12; i++)
	{
		new weaponID, weaponAmmo;
		AC_GetPlayerWeaponData(playerid, i, weaponID, weaponAmmo);
		GivePlayerWeapon(playerid, weaponID, weaponAmmo);
	}

	return true;
}

stock AC_GetPlayerWeaponData(playerid, slot, &weaponid, &ammo)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	if (!(-1 <= slot <= 13))
	{
		return false;
	}

	weaponid = gACWeaponID[playerid][slot];
	ammo = gACWeaponAmmo[playerid][slot];
	return true;
}

stock AC_UpdatePlayerWeaponData(playerid, slot, weaponid, ammo)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	if (!(-1 <= slot <= 13))
	{
		return false;
	}

	gACWeaponID[playerid][slot] = weaponid;
	gACWeaponAmmo[playerid][slot] = ammo;
	return true;
}

stock AC_ResetPlayerWeaponData(playerid, slot)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	if (!(-1 <= slot <= 13))
	{
		return false;
	}

	ResetPlayerWeapons(playerid);

	gACWeaponID[playerid][slot] = INVALID_WEAPON_ID;
	gACWeaponAmmo[playerid][slot] = INVALID_WEAPON_AMMO;
	return true;
}

stock AC_SetPlayerVehicleCount(playerid, count)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	gACVehicleEntranceCount[playerid] = count;
	return true;
}

stock AC_GetPlayerVehicleCount(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gACVehicleEntranceCount[playerid];
}

stock AC_PlayerIncreaseVehicleCount(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	gACVehicleEntranceCount[playerid]++;
	return true;
}

stock AC_SetPlayerVehicleID(playerid, vehicleID)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	gACVehicleID[playerid] = vehicleID;
	return true;
}

stock AC_GetPlayerVehicleID(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gACVehicleID[playerid];
}
