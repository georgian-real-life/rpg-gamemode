#if defined MAX_PLAYER_LEVEL_EXP_POINT
	#error MAX_PLAYER_LEVEL_EXP_POINT Already defined
#endif
#define MAX_PLAYER_LEVEL_EXP_POINT		10_000


#include	"player_constructor.pwn"
#include	"player_load_save.pwn"
#include	"player_restrictions.pwn"
#include	"player_timers.pwn"
#include	"player_functions.pwn"
#include	"player_misc.pwn"


public OnPlayerRequestClass(playerid, classid)
{
	if (GetPlayerJailTime(playerid) > 0)
	{
		SetSpawnInfo(playerid, NO_TEAM, GetPlayerSpawnSkin(playerid), 5495.6226, 1247.5204, 8.1286, 268.0606, 0, 0, 0, 0, 0, 0);
	}

	UpdatePlayerSpawnInfo(playerid);
	return 1;
}

//new kote[MAX_PLAYERS];
public OnPlayerConnect(playerid)
{
	ShowServerNameTextDraw(playerid);
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof (playerName));
	SetPlayerNameEx(playerid, playerName);

	//fixing some issues caused by sa-mp.
	DisablePlayerRaceCheckpoint(playerid);
	DisablePlayerCheckpoint(playerid);

	RemoveBuildingForPlayer(playerid, 14795, 1388.8828, -20.8828, 1005.2031, 0.25);

	for (new i = 0; i < 85; i++)
	{
		GangZoneShowForPlayer(playerid, gangzone[i], GangZoneColours[i][0]);
		GangZoneShowForPlayer(playerid, gangzoneBorders[i][0], COLOUR_LIGHT_GREY);
		GangZoneShowForPlayer(playerid, gangzoneBorders[i][1], COLOUR_LIGHT_GREY);
		GangZoneShowForPlayer(playerid, gangzoneBorders[i][2], COLOUR_LIGHT_GREY);
		GangZoneShowForPlayer(playerid, gangzoneBorders[i][3], COLOUR_LIGHT_GREY);
	}



	// SetTimerEx("test", 5500, 1, "i", playerid);
	return true;
}
// forward test(playerid);
// public test(playerid)
// {
// 	new Float:x, Float:y, Float:z;
// 	GetPlayerPos(playerid, x, y, z);
// 	GetXYInFrontOfPlayer(playerid, x, y, 1.0);
// 	kote[playerid] = CreateDynamicActor(203, x, y, z, 90.0);
// 	SetTimerEx("toest2", 500, 0, "i", playerid);
// 	return true;
// }
// forward toest2(playerid);
// public toest2(playerid)
// {
// 	DestroyDynamicActor(kote[playerid]);
// 	return true;
// }
public OnPlayerDisconnect(playerid, reason)
{
	if (IsPlayerAuthorized(playerid))
	{
		CallRemoteFunction("SavePlayerData", "i", playerid);
	}

	AC_SetPlayerVehicleID(playerid, INVALID_VEHICLE_ID);
	AC_SetPlayerVehicleCount(playerid, 0);

	for (new i = 0; i <= 12; i++)
	{
		AC_ResetPlayerWeaponData(playerid, i);
	}

	SetPlayerConnectionState(playerid, "none");
	return true;
}

public OnPlayerUpdate(playerid)
{
	if (!IsPlayerAuthorized(playerid))
	{
		return false;
	}

	return true;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerCash(playerid, GetPlayerCash(playerid), false);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	AC_SetPlayerPos(playerid,x, y, z, false);
	return 1;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		RemovePlayerFromVehicle(playerid);
	}

	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK && newkeys & KEY_SECONDARY_ATTACK)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		ClearAnimations(playerid, 1);
		return 1;
	}

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}
