#include 	<YSI_Coding\y_hooks>


forward Timer_UpdatePlayerMuteTimer(playerid);
forward Timer_UpdatePlayerJailTimer(playerid);


static
		gPlayerMuteTime[MAX_PLAYERS],
		gPlayerMuteTimer[MAX_PLAYERS],
		gPlayerJailTime[MAX_PLAYERS],
		gPlayerJailTimer[MAX_PLAYERS];


hook OnPlayerConnect(playerid)
{
	SetPlayerMuteTime(playerid, 0, false);
	SetPlayerJailTime(playerid, 0, false);
	return true;
}


stock SetPlayerMuteTime(playerid, time_in_seconds, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	if (time_in_seconds <= 0)
	{
		time_in_seconds = 0;
		Timer_KillPlayerMuteTimer(playerid);
	}
	else
	{
		Timer_SetPlayerMuteTimer(playerid);
	}

	gPlayerMuteTime[playerid] = time_in_seconds;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_restrictions` SET `muteTime` = '%d' WHERE `playerName` = '%e'", gPlayerMuteTime[playerid], GetPlayerNameEx(playerid));
		mysql_tquery(DB_GetHandler(), query);
	}

	return true;
}

stock GetPlayerMuteTime(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}
	return gPlayerMuteTime[playerid];
}

stock Timer_SetPlayerMuteTimer(playerid)
{
	Timer_KillPlayerMuteTimer(playerid);
	gPlayerMuteTimer[playerid] = SetPreciseTimer("Timer_UpdatePlayerMuteTimer", 1000, true, "i", playerid);
	return true;
}

stock Timer_KillPlayerMuteTimer(playerid)
{
	DeletePreciseTimer(gPlayerMuteTimer[playerid]);
	return true;
}


public Timer_UpdatePlayerMuteTimer(playerid)
{
	new playerMuteTime = GetPlayerMuteTime(playerid);

	if (playerMuteTime > 0)
	{
		SetPlayerMuteTime(playerid, (playerMuteTime - 1), false);
	}

	if (playerMuteTime <= 0)
	{
		SendClientMessage(playerid, COLOUR_GREEN, "Chattan wvdoma agdgenilia");
		Timer_KillPlayerMuteTimer(playerid);
		SetPlayerMuteTime(playerid, 0, true);
	}
	return true;
}


stock SetPlayerJailTime(playerid, time_in_seconds, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	if (time_in_seconds <= 0)
	{
		time_in_seconds = 0;
		Timer_KillPlayerJailTimer(playerid);
		UpdatePlayerSpawnInfo(playerid);
		SafeSpawnPlayer(playerid);
	}
	else
	{
		Timer_SetPlayerJailTimer(playerid);
		SetSpawnInfo(playerid, NO_TEAM, GetPlayerSpawnSkin(playerid), 5495.6226, 1247.5204, 8.1286, 268.0606, 0, 0, 0, 0, 0, 0);
	}

	gPlayerJailTime[playerid] = time_in_seconds;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_restrictions` SET `jailTime` = '%d' WHERE `playerName` = '%e'", gPlayerJailTime[playerid], GetPlayerNameEx(playerid));
		mysql_tquery(DB_GetHandler(), query);
	}

	return true;
}

stock GetPlayerJailTime(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}
	return gPlayerJailTime[playerid];
}

stock Timer_SetPlayerJailTimer(playerid)
{
	Timer_KillPlayerJailTimer(playerid);
	gPlayerJailTimer[playerid] = SetPreciseTimer("Timer_UpdatePlayerJailTimer", 1000, true, "i", playerid);
	return true;
}

stock Timer_KillPlayerJailTimer(playerid)
{
	DeletePreciseTimer(gPlayerJailTimer[playerid]);
	return true;
}


public Timer_UpdatePlayerJailTimer(playerid)
{
	new playerJailTime = GetPlayerJailTime(playerid);
	if (playerJailTime > 0)
	{
		SetPlayerJailTime(playerid, (playerJailTime - 1), false);
	}

	if (playerJailTime <= 0)
	{
		Timer_KillPlayerJailTimer(playerid);
		SetPlayerJailTime(playerid, 0, true);
	}
	return true;
}


stock DB_CheckPlayerRestrictions(playerid)
{
	new Cache:result, rows, query[128];

	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT * FROM `player_restrictions` WHERE `playerName` = '%e'", GetPlayerNameEx(playerid));
	result = mysql_query(DB_GetHandler(), query, true);

	cache_get_row_count(rows);

	if (rows > 0)
	{
		new tempMuteTime, tempJailTime;
		cache_get_value_index_int(0, 1, tempMuteTime);
		cache_get_value_index_int(0, 2, tempJailTime);

		SetPlayerMuteTime(playerid, tempMuteTime, false);
		SetPlayerJailTime(playerid, tempJailTime, false);
	}
	cache_delete(result);
	return true;
}
