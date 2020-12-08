#include	<YSI_Coding\y_hooks>

forward CheckAccountIPBanStatus(playerid);
forward CheckAccountBanStatus(playerid);
forward CheckAccountAvailability(playerid);
forward TimerUpdatePlayerConnectionTime(playerid);


hook OnPlayerConnect(playerid)
{
	//მეორეჯერ გამოვიყენე ამიტომ დონთ ფაქ ვიზ მი
	static playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof (playerName));
	SetPlayerNameEx(playerid, playerName);

	TogglePlayerSpectating(playerid, 1);
	SetPlayerConnectionState(playerid, "connecting");

	static query[258];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT * FROM `administrator_ipban_logs` WHERE `playerName` = '%e' AND `date` < `unBanDate`", playerName);
	mysql_tquery(DB_GetHandler(), query, "CheckAccountIPBanStatus", "i", playerid);
	return 1;
}

public CheckAccountIPBanStatus(playerid)
{
	new rows;
	cache_get_row_count(rows);

	if (rows > 0)
	{
		KickPlayer(playerid);
		return false;
	}

	new query[512];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `playerName` FROM `administrator_ipban_logs` WHERE `playerName` = '%e'", GetPlayerNameEx(playerid));
	new Cache:result = mysql_query(DB_GetHandler(), query, true);

	cache_get_row_count(rows);

	if (rows > 0)
	{
		mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `administrator_ipban_logs` WHERE `playerName` = '%e'", GetPlayerNameEx(playerid));
		mysql_tquery(DB_GetHandler(), query);

		mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrator_unbanip_logs`(`playerName`, `date`, `issuedBy`, `reason`) VALUES \
		('%s',NOW(),'%s', '%s')", GetPlayerNameEx(playerid), "Server", "Ban Time Expired");
		mysql_tquery(DB_GetHandler(), query);
	}
	cache_delete(result);

	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT * FROM `administrator_ipban_logs` WHERE `playerName` = '%e' AND `date` < `unBanDate`", GetPlayerNameEx(playerid));
	mysql_tquery(DB_GetHandler(), query, "CheckAccountBanStatus", "i", playerid);

	return true;
}

public CheckAccountBanStatus(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if (rows > 0)
	{
		new tempAdminName[MAX_PLAYER_NAME], tempReason[MAX_PLAYER_NAME], date[32], unBanDate[32];
		cache_get_value_index(0, 0, tempAdminName, MAX_PLAYER_NAME);
		cache_get_value_index(0, 2, tempReason, MAX_PLAYER_NAME);
		cache_get_value_index(0, 3, date, 32);
		cache_get_value_index(0, 4, unBanDate, 32);

		new message[580];
		format(message, sizeof(message), "{FFFFFF}Tqveni angarishi dablokilia.\n\nDamblokveli: %s\nBlokis Mizezi: %s\n\
		Dablokvis tarigi: %s\n\n\nAngarishze bloki avtomaturad moixsneba: %s-ze\n\nTu tvlit rom tqveni angarishi daibloka araswori mizezit, shegidzliat mogvmartot shemdeg misamartebze:\n\
		website: forum.melbourne-rp.com\nE-mail: support@melbourne-rp.com\n\n", tempAdminName, tempReason, date, unBanDate);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{800E0E} Account banned", message, "X", "");
		KickPlayer(playerid);
		return 1;
	}

	new query[512];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `playerName` FROM `administrator_ban_logs` WHERE `playerName` = '%e'", GetPlayerNameEx(playerid));
	new Cache:result = mysql_query(DB_GetHandler(), query, true);

	cache_get_row_count(rows);
	if (rows > 0)
	{
		mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `administrator_ban_logs` WHERE `playerName` = '%e'", GetPlayerNameEx(playerid));
		mysql_tquery(DB_GetHandler(), query);

		mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrator_unban_logs`(`playerName`, `date`, `issuedBy`, `reason`) VALUES \
		('%s',NOW(),'%s', '%s')", GetPlayerNameEx(playerid), "Server", "Ban Time Expired");
		mysql_tquery(DB_GetHandler(), query);
	}
	cache_delete(result);

	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `name` FROM `accounts` WHERE `name` = '%e'", GetPlayerNameEx(playerid));
	mysql_tquery(DB_GetHandler(), query, "CheckAccountAvailability", "i", playerid);
	return 1;
}

public CheckAccountAvailability(playerid)
{
	new text[64];
	format(text, sizeof text, "%s tqven gaqvt %s wuti.",
	(IsPlayerRegistering(playerid)) ? ("Registraciistvis"): ("Avtorizaciistvis"),
	(IsPlayerRegistering(playerid)) ? (ConvertSecondsToMinutes(AccSetup_GetRegistrationTime())): (ConvertSecondsToMinutes(AccSetup_GetAuthorizationTime()))
	);

	new rows;
	cache_get_row_count(rows);

	if (rows > 0 )
	{
		SetPlayerConnectionState(playerid, "Authorizing");
		AccSetup_SetPlayerConnTime(playerid, AccSetup_GetAuthorizationTime());

		SendClientMessage(playerid, COLOUR_INFORMATION, text);
		CallRemoteFunction("AccountAuthorizationRequest", "i", playerid);
	}

	else
	{
		SetPlayerConnectionState(playerid, "Registering");
		AccSetup_SetPlayerConnTime(playerid, AccSetup_GetRegistrationTime());

		CallRemoteFunction("AccountRegistrationRequest", "i", playerid);
		SendClientMessage(playerid, COLOUR_INFORMATION, text);
	}

	AccSetup_SetUpConnTimer(playerid); //calls TimerUpdatePlayerConnectionTime
	return 1;
}

public TimerUpdatePlayerConnectionTime(playerid)
{
	new connectionTime = AccSetup_GetPlayerConnTime(playerid);
	AccSetup_SetPlayerConnTime(playerid, connectionTime - 1);
	if (IsPlayerAuthorized(playerid)) { return false; }
	if (connectionTime == 30)
	{
		new text[56];
		format(text, sizeof (text), "%s dagrchat 30 wami.", (IsPlayerRegistering(playerid)) ? ("Registraciistvis"): ("Avtorizaciistvis"));
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, text);
	}

	if (connectionTime <= 0)
	{
		AccSetup_DeleteConnTimer(playerid);
		new text[64];
		format(text, sizeof (text), "%s dro amoiwura, serveri wyvets tqventan kavshirs.", (IsPlayerRegistering(playerid)) ? ("Registraciis"): ("Avtorizaciis"));
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, text);
		KickPlayer(playerid);
		return true;
	}
	return true;
}
