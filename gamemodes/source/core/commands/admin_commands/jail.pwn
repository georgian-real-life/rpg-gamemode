CMD:jail(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new targetid, seconds, reason[128];

	if (sscanf(params, "iis[128]", targetid, seconds, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /jail [targetid] [seconds] [reason]");
		return false;
	}

	if (seconds <= 0)
	{
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		return false;
	}

	SetPlayerJailTime(targetid, seconds, true);
	SafeSpawnPlayer(playerid);

	new message[256];
	format(message, sizeof message, "Administratorma %s chasva tvit izolaciashi %s - %s wutit, mizezi: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), ConvertSecondsToMinutes(seconds), reason);
	SendClientMessageToAll(COLOUR_ADMIN_RED, message);

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, \
		"INSERT INTO `administrator_jail_logs` \
		(`issuerName`, `playerName`, `date`, `reason`, `jailTime`) \
		VALUES \
		('%s', '%s', NOW(), '%s', '%d')",
	GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason, seconds);
	mysql_tquery(DB_GetHandler(), query);

	return true;
}

CMD:unjail(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new targetid, reason[128];

	if (sscanf(params, "is[128]", targetid, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /unjail [targetid] [reason]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		return false;
	}

	if (GetPlayerJailTime(targetid) > 0)
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Motamashe ar zis cixeshi");
		return false;
	}

	SetPlayerJailTime(targetid, 0, true);

	new message[256];
	format(message, sizeof message, "Administratorma %s gamoushva %s karantinidan, mizezi: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason);
	SendClientMessageToAll(COLOUR_ADMIN_RED, message);

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, \
		"INSERT INTO `administrator_unjail_logs` \
		(`issuerName`, `playerName`, `date`, `reason`) \
		VALUES \
		('%s', '%s', NOW(), '%s')",
	GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason);
	mysql_tquery(DB_GetHandler(), query);
	return true;
}

CMD:offjail(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new playerName[MAX_PLAYER_NAME], seconds, reason[128];

	if (sscanf(params, "s[24]is[128]", playerName, seconds, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /offjail [playername] [seconds] [reason]");
		return false;
	}

	new text[144];
	format(text, sizeof text, "%s [AdminCMD] %s[%d] chasva offline motamashe %s karantinshi, mizezi: %s", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, playerName, reason);
	SendAdminMessage(text);

	new updateQuery[128], logQuery[256];
	mysql_format(DB_GetHandler(), updateQuery, sizeof updateQuery, \
		"UPDATE `player_restrictions` SET \
		`jailTime` = '%d'\
		WHERE `playerName` = '%s'", seconds, playerName);
	mysql_tquery(DB_GetHandler(), updateQuery);


	mysql_format(DB_GetHandler(), logQuery, sizeof logQuery, \
		"INSERT INTO `administrator_jail_logs` \
		(`issuerName`, `playerName`, `date`, `reason`) \
		VALUES \
		('%s', '%s', NOW(), '%s')",
	GetPlayerNameEx(playerid), playerName, reason);
	mysql_tquery(DB_GetHandler(), logQuery);
	return true;
}

CMD:offunjail(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new playerName[MAX_PLAYER_NAME], reason[128];

	if (sscanf(params, "s[24]s[128]", playerName, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /offunjail [playername] [reason]");
		return false;
	}

	new text[144];
	format(text, sizeof text, "%s [AdminCMD] %s[%d] gamoushvi offline motamashe %s karantinidan, mizezi: %s", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, playerName, reason);
	SendAdminMessage(text);

	new updateQuery[128], logQuery[256];
	mysql_format(DB_GetHandler(), updateQuery, sizeof updateQuery, \
		"UPDATE `player_restrictions` SET \
		`jailTime` = '0'\
		WHERE `playerName` = '%s'", playerName);
	mysql_tquery(DB_GetHandler(), updateQuery);


	mysql_format(DB_GetHandler(), logQuery, sizeof logQuery, \
		"INSERT INTO `administrator_unjail_logs` \
		(`issuerName`, `playerName`, `date`, `reason`) \
		VALUES \
		('%s', '%s', NOW(), '%s')",
	GetPlayerNameEx(playerid), playerName, reason);
	mysql_tquery(DB_GetHandler(), logQuery);
	return true;
}
