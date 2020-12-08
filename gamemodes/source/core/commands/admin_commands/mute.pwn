CMD:mute(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, seconds, reason[128];

	if (sscanf(params, "iis[128]", targetid, seconds, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /mute [targetid] [seconds] [reason]");
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

	SetPlayerMuteTime(targetid, seconds, true);

	new message[256];
	format(message, sizeof message, "Administratorma %s sheuwyvita chattan wvdoma %s - %s wutit, mizezi: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), ConvertSecondsToMinutes(seconds), reason);
	SendClientMessageToAll(COLOUR_ADMIN_RED, message);

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, \
	"INSERT INTO `administrator_mutelogs` \
	(`issuerName`, `playerName`, `date`, `reason`, `muteTime`) \
	VALUES \
	('%s', '%s', NOW(), '%s', '%d')",
	GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason, seconds);
	mysql_tquery(DB_GetHandler(), query);
	return true;
}

CMD:unmute(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, reason[128];

	if (sscanf(params, "is[128]", targetid, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /unmute [targetid] [reason]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		return false;
	}

	if (GetPlayerMuteTime(playerid) <= 0)
	{
		return false;
	}

	SetPlayerMuteTime(targetid, 0, true);

	new message[256];
	format(message, sizeof message, "Administratorma %s agudgina chattan wvdoma %s-s, mizezi: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason);
	SendClientMessageToAll(COLOUR_ADMIN_RED, message);

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, \
	"INSERT INTO `administrator_unmute_logs` \
	(`issuerName`, `playerName`, `date`, `reason`) \
	VALUES \
	('%s', '%s', NOW(), '%s')",
	GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason);
	mysql_tquery(DB_GetHandler(), query);
	return true;
}

CMD:offmute(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new playerName[MAX_PLAYER_NAME], seconds, reason[128];

	if (sscanf(params, "s[24]is[128]", playerName, seconds, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /offmute [playername] [seconds] [reason]");
		return false;
	}

	new text[144];
	format(text, sizeof text, "%s [AdminCMD] %s[%d] sheuwyvita chattan wvdoma offline motamashes [%s]-s mizezi: %s", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, playerName, reason);
	SendAdminMessage(text);

	new updateQuery[128], logQuery[256];
	mysql_format(DB_GetHandler(), updateQuery, sizeof updateQuery, \
	"UPDATE `player_restrictions` SET \
	`muteTime` = '%d' \
	WHERE `playerName` = '%s'", seconds, playerName);
	mysql_tquery(DB_GetHandler(), updateQuery);


	mysql_format(DB_GetHandler(), logQuery, sizeof logQuery, \
	"INSERT INTO `administrator_mutelogs` \
	(`issuerName`, `playerName`, `date`, `reason`, `muteTime`) \
	VALUES \
	('%s', '%s', NOW(), '%s', '%d')",
	GetPlayerNameEx(playerid), playerName, reason, seconds);
	mysql_tquery(DB_GetHandler(), logQuery);
	return true;
}

CMD:offunmute(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new playerName[MAX_PLAYER_NAME], reason[128];

	if (sscanf(params, "s[24]s[128]", playerName, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /unmute [playername] [reason]");
		return false;
	}

	new text[144];
	format(text, sizeof text, "%s [AdminCMD] %s[%d] agudgina offline motamashe [%s]-s chattan wvdoma, mizezi: %s", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, playerName, reason);
	SendAdminMessage(text);

	new updateQuery[128], logQuery[256];
	mysql_format(DB_GetHandler(), updateQuery, sizeof updateQuery, \
	"UPDATE `player_restrictions` SET \
	`muteTime` = '0'\
	WHERE `playerName` = '%s'", playerName);
	mysql_tquery(DB_GetHandler(), updateQuery);


	mysql_format(DB_GetHandler(), logQuery, sizeof logQuery, \
	"INSERT INTO `administrator_unmute_logs` \
	(`issuerName`, `playerName`, `date`, `reason`) \
	VALUES \
	('%s', '%s', NOW(), '%s')",
	GetPlayerNameEx(playerid), playerName, reason);
	mysql_tquery(DB_GetHandler(), logQuery);
	return true;
}
