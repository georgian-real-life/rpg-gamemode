#include	<YSI_Coding\y_hooks>


forward Timer_UpdatePayDayTimer(playerid);


static
	gPlayerPayDayTimer[MAX_PLAYERS];


hook OnPlayerDisconnect(playerid, reason)
{
	Timer_KillPayDayTimer(playerid);
	return true;
}


stock Timer_TriggerPayDayTimer(playerid)
{
	Timer_KillPayDayTimer(playerid);
	gPlayerPayDayTimer[playerid] = SetPreciseTimer("Timer_UpdatePayDayTimer", 1000, true, "i", playerid);
	return true;
}

stock Timer_KillPayDayTimer(playerid)
{
	DeletePreciseTimer(gPlayerPayDayTimer[playerid]);
	return true;
}

public Timer_UpdatePayDayTimer(playerid)
{
	new
		paydayTime = GetPlayerPayDayTime(playerid),
		playerExpPoint = GetPlayerLevelExpPoint(playerid);

	new text[144];
	format(text, sizeof text, "%d %d ", paydayTime, playerExpPoint);
	SendClientMessage(playerid, -1, text);

	if (paydayTime >= 3600)
	{
		SetPlayerLevelExpPoint(playerid, playerExpPoint + MAX_PLAYER_LEVEL_EXP_POINT);
		UpdatePlayerLevelStatistics(playerid);
		paydayTime = -1;

		SetPlayerCash(playerid, GetPlayerCash(playerid) + GetPlayerPaycheck(playerid), false);
	}

	SetPlayerPayDayTime(playerid, paydayTime + 1, false);
	return true;
}
