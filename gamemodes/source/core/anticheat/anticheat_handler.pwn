#include	<YSI_Coding\y_hooks>


forward Timer_AC_OneSecondTimer(playerid);


static
	gAC_OneSecondTimer[MAX_PLAYERS];


hook OnPlayerDisconnect(playerid, reason)
{
	DeletePreciseTimer(gAC_OneSecondTimer[playerid]);
	return true;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if((hittype == BULLET_HIT_TYPE_PLAYER && ! IsPlayerConnected(hitid)) || (hittype == BULLET_HIT_TYPE_VEHICLE && !IsValidVehicle(hitid)) || (hittype == BULLET_HIT_TYPE_OBJECT && !IsValidVehicle(hitid)) || (hittype == BULLET_HIT_TYPE_PLAYER_OBJECT && !IsValidPlayerObject(playerid, hitid))) return false;

	if (hittype != BULLET_HIT_TYPE_NONE)
	{
		if (!(-1000.0 <= fX <= 1000.0) || !(-1000.0 <= fY <= 1000.0) || !(-1000.0 <= fZ <= 1000.0))
		{
			AC_KickPlayer(playerid, E_ANTICHEAT_CODE_BULLET_CRASH1);
			return false;
		}
	}

	if (hittype == BULLET_HIT_TYPE_VEHICLE && hitid != INVALID_VEHICLE_ID)
	{
		if ((floatcmp(floatabs(fX), 100.0) == 1) || (floatcmp(floatabs(fY), 100.0) == 1) || (floatcmp(floatabs(fZ), 100.0) == 1))
		{
			AC_KickPlayer(playerid, E_ANTICHEAT_CODE_BULLET_CRASH2);
			return false;
		}
	}

	if (hittype == BULLET_HIT_TYPE_PLAYER && ((fX >= 10.0 || fX <= -10.0) || (fY >= 10.0 || fY <= -10.0) || (fZ >= 10.0 || fZ <= -10.0)))
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_BULLET_CRASH3);
		return false;
	}

	new weaponSlot; AC_GetWeaponSlotByWeaponID(weaponid, weaponSlot);

	if (weaponSlot == 0xFF)
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "[Server] Serverma ar daaregistrira gasrolili iaragis informacias");

		new adminMessage[144];
		format(adminMessage, sizeof adminMessage,"{DF1800}[ANTI-CHEAT] [Warning] %s[%d] serverma ar daareigstrira gasrolili iaragis informacia.", GetPlayerNameEx(playerid), playerid);
		SendAdminMessage(adminMessage);
		return false;
	}

	new
		currentWeaponID, currentWeaponAmmo,
		dataWeaponID, dataWeaponAmmo;

	GetPlayerWeaponData(playerid, weaponSlot, currentWeaponID, currentWeaponAmmo);
	AC_GetPlayerWeaponData(playerid, weaponSlot, dataWeaponID, dataWeaponAmmo);

	if ((currentWeaponID != dataWeaponID) && (dataWeaponID != INVALID_WEAPON_ID))
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_WEAPON);
		return false;
	}

	if ((currentWeaponAmmo != dataWeaponAmmo) && currentWeaponAmmo >= 0)
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_WEAPON_AMMO);
		return false;
	}

	currentWeaponAmmo--;

	if (currentWeaponAmmo <= 0)
	{
		currentWeaponID = INVALID_WEAPON_ID;
		currentWeaponAmmo = INVALID_WEAPON_AMMO;
	}

	AC_UpdatePlayerWeaponData(playerid, weaponSlot, currentWeaponID, currentWeaponAmmo);
	return true;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	AC_SetPlayerVehicleID(playerid, vehicleid);
	return true;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	AC_SetPlayerVehicleID(playerid, INVALID_VEHICLE_ID);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	AC_SetPlayerPos(playerid, x, y, z, false);
	return true;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_DRIVER)
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_DRIVER2DRIVER);
		return false;
	}
	else if (oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_PASSENGER)
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_DRIVER2PASSNGR);
		return false;
	}

	if (oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_PASSENGER)
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_PASSNGR2DRIVER);
		return false;
	}
	else if (oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_DRIVER)
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_PASSNGR2PASSNG);
		return false;
	}

	if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		new playerVehicleCount = AC_GetPlayerVehicleCount(playerid);
		if (playerVehicleCount >= 3)
		{
			AC_KickPlayer(playerid, E_ANTICHEAT_CODE_VEHICLESPAWNER);
			return false;
		}

		new vehicleID = GetPlayerVehicleID(playerid);
		new acVehicleID = AC_GetPlayerVehicleID(playerid);
		if (vehicleID != acVehicleID)
		{
			AC_KickPlayer(playerid, E_ANTICHEAT_CODE_VEHICLETP);
			return false;
		}
	}

	return true;
}


stock Timer_TriggerAntiCheatTimer(playerid)
{
	DeletePreciseTimer(gAC_OneSecondTimer[playerid]);
	gAC_OneSecondTimer[playerid] = SetPreciseTimer("Timer_AC_OneSecondTimer", 1_000, true, "i", playerid);
	return true;
}


public Timer_AC_OneSecondTimer(playerid)
{
	if (GetPlayerAdminLevel(playerid > 0))
	{
		return false;
	}

	if (!WC_IsPlayerSpawned(playerid))
	{
		return false;
	}

	new playerState = GetPlayerState(playerid);
	new playerSpecialAction = GetPlayerSpecialAction(playerid);

	if (playerSpecialAction == SPECIAL_ACTION_USEJETPACK)
	{
		AC_KickPlayer(playerid, E_ANTICHEAT_CODE_JETPACK);
		return true;
	}

	if (playerState == PLAYER_STATE_ONFOOT)
	{
		new Float:vX, Float:vY, Float:vZ;
		GetPlayerVelocity(playerid, vX, vY, vZ);

		if (vX > 2.0 || vY > 2.0)
		{
			SetPVarInt(playerid, "AC_314zda", GetPVarInt(playerid, "AC_314zda") + 1);
			if(GetPVarInt(playerid, "AC_314zda") >= 2)
			{
				AC_KickPlayer(playerid, E_ANTICHEAT_CODE_3ZDARVANKA);
				return false;
			}
		}

		new animLib[32], animName[32], animIndex = GetPlayerAnimationIndex(playerid);
		GetAnimationName(animIndex, animLib, 32, animName, 32);
		new Float:playerSpeed; GetPlayerSpeed(playerid, playerSpeed);

		if (!strcmp(animName, "CAR_SIT_PRO", true))
		{
			AC_KickPlayer(playerid, E_ANTICHEAT_CODE_INVALID_ANIM);
			return false;
		}

		if ((animIndex == 1538 || animIndex == 1539 || animIndex == 1543) && playerSpeed >= 20.0)
		{
			AC_KickPlayer(playerid, E_ANTICHEAT_CODE_FLY_CHEAT);
			return false;
		}

		new Float:x, Float:y, Float:z, Float:acX, Float:acY, Float:acZ;
		GetPlayerPos(playerid, x, y, z);
		AC_GetPlayerPos(playerid, acX, acY, acZ);
		new distanceTraveledByPlayer = GetDistanceBetweenPoints(x, y, z, acX, acY, acZ);

		if ((GetPlayerWeapon(playerid) != 46 || animIndex != 1130))
		{
			if (GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)
			{
				switch (distanceTraveledByPlayer)
				{
					case 0..18:
					{
						AC_SetPlayerPos(playerid, x, y, z, false);
					}

					case 19..40:
					{
						new adminMessage[144];
						format(adminMessage, sizeof adminMessage,"{DF1800}[ANTI-CHEAT] [Warning] %s[%d] sheidzleba iyenebdes fly/airbreak-s.", GetPlayerNameEx(playerid), playerid);
						SendAdminMessage(adminMessage);

						AC_SetPlayerPos(playerid, x, y, z, false);
					}

					default:
					{
						AC_KickPlayer(playerid, E_ANTICHEAT_CODE_AIRBREAK);
					}
				}
			}

			else
			{
				AC_SetPlayerPos(playerid, x, y, z, false);
			}
		}
	}

	AC_SetPlayerVehicleCount(playerid, 0);

	return true;
}

// hook OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z) // Mankanebs Ro krian e magi.
// {
// 	if(floatcmp(new_x, new_x) != 0 || floatcmp(new_y, new_y) != 0 || floatcmp(new_z, new_z) != 0) return 0;

// 	if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) > 10.0) return 0;

// 	return 1;

// }
