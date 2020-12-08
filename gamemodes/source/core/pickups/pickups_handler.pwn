#include	<YSI_Coding\y_hooks>


forward TimerUpdatePickupFreezeTime(playerid);


static
	gPlayerPickupCoolDown[MAX_PLAYERS],
	gPlayerPickupFreezeTimer[MAX_PLAYERS];


hook OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	TogglePlayerControllable(playerid, false);
	gPlayerPickupFreezeTimer[playerid] = SetPreciseTimer("TimerUpdatePickupFreezeTime", 3_000, false, "i", playerid);
	return true;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DeletePreciseTimer(gPlayerPickupFreezeTimer[playerid]);
	return true;
}

hook OnPlayerPickUpDynPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	{
		return false;
	}

	if (GetTickCount() < gPlayerPickupCoolDown[playerid])
	{
		return false;
	}

	gPlayerPickupCoolDown[playerid] = GetTickCount() + 5_000;

	foreach (new pid : gPickups)
	{
		if (IsPickupDebuggerEnabled(playerid))
		{
			new text[14];
			format(text, 14, "%d", Pickup_GetPickupID(pid));
			SendClientMessage(playerid, COLOUR_WHITE, text);
		}

		if (gPickupEntrancePickup[pid] == pickupid)
		{
			new Float:x, Float:y, Float:z;
			Pickup_GetPickupExitPos(pid, x, y, z);

			if (x == 0.0)
			{
				return true;
			}
			AC_SetPlayerPos(playerid, x, y, z, true);
			AC_SetPlayerVirtualWorld(playerid, Pickup_GetPickupExitVW(pid), true);
			AC_SetPlayerInteriorID(playerid, Pickup_GetPickupExitInt(pid), true);
		}

		else if (gPickupExitPickup[pid] == pickupid)
		{
			new Float:x, Float:y, Float:z;
			Pickup_GetPickupEntrancePos(pid, x, y, z);
			AC_SetPlayerPos(playerid, x, y, z, true);
			AC_SetPlayerVirtualWorld(playerid, Pickup_GetPickupEntranceVW(pid), true);
			AC_SetPlayerInteriorID(playerid, Pickup_GetPickupEntranceInt(pid), true);
		}
	}
	return true;
}


public TimerUpdatePickupFreezeTime(playerid)
{
	DeletePreciseTimer(gPlayerPickupFreezeTimer[playerid]);
	TogglePlayerControllable(playerid, true);
	return true;
}
