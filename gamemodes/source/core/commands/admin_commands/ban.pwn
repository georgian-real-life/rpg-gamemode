forward DB_UnbanPlayer(const playerid, const name[], const reason[]);
forward DB_UnbanPlayerIP(const playerid, const name[], const reason[]);
forward DB_OffBanPlayer(const playerid, const name[], const days, const reason[], silent);


CMD:ban(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}

	new targetid, days, reason[128], silent;

	if (sscanf(params, "iis[128]i", targetid, days, reason, silent))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /ban [targetid] [days 1-30] [reason] [silent]");
		return true;
	}

	if (!IsPlayerConnected(targetid) || targetid == playerid)
	{
		return false;
	}

	if (GetPlayerAdminLevel(targetid) >= GetPlayerAdminLevel(playerid))
	{
		return false;
	}

	if (!(1 <= days <= 30))
	{
		return false;
	}

	new message[256];
	if (silent == 0)
	{
		format(message, sizeof message, "Administratorma %s dabloka %s - %d dgit, mizezi: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), days, reason);
		SendClientMessageToAll(COLOUR_ADMIN_RED, message);
	}
	else
	{
		silent = 1;
		format(message, sizeof message, "%s[AdminCMD] %s[%d] banned %s for %d days, reason:%s", FormatHex(COLOUR_ADMIN_RED), GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(targetid), days, reason);
		SendAdminMessage(message);
	}

	new query[256];
	format(query, sizeof query, "INSERT INTO `administrator_ban_logs`(`adminName`, `playerName`, `reason`, `date`, `unBanDate`, `wasSilent`) VALUES \
	('%s', '%s', '%s', NOW() , DATE_ADD(NOW(), INTERVAL '%d' DAY), '%d')", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason, days, silent);
	mysql_tquery(DB_GetHandler(), query);
	KickPlayer(targetid);
	return true;
}

CMD:offban(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetName[MAX_PLAYER_NAME], days, reason[128], silent;

	sscanf(params, "s[24]is[64]i", targetName, days, reason, silent);

	if ((isnull(targetName)) || (!strcmp(targetName, "%s")) || (isnull(reason)) || (!strcmp(reason, "%s")) || !(1 <= days <= 30))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /offban [player name] [days (0-30)] [reason] [silent (0 - 1 optional)]");
		return false;
	}

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `adminName` FROM `administrators` WHERE `adminName` = '%e'", targetName);
	mysql_tquery(DB_GetHandler(), query, "DB_OffBanPlayer", "isisi", playerid, targetName, days, reason, silent);


	return true;
}

CMD:unban(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetName[MAX_PLAYER_NAME], reason[32];
	if (sscanf(params, "s[24]s[32]", targetName, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /unban [targetName] [reason]");
		return false;
	}

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `playerName` FROM `administrator_ban_logs` WHERE `playerName` = '%e'", targetName);
	mysql_tquery(DB_GetHandler(), query, "DB_UnbanPlayer", "iss", playerid, targetName, reason);

	return true;
}

alias:ipban("banip")
CMD:ipban(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}

	new targetid, days, reason[24];

	if (sscanf(params, "iis[24]i", targetid, days, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /ipban [targetid] [days 1-30] [reason]");
		return true;
	}

	if (!IsPlayerConnected(targetid) || targetid == playerid)
	{
		return false;
	}

	if (GetPlayerAdminLevel(targetid) >= GetPlayerAdminLevel(playerid))
	{
		return false;
	}

	if (!(1 <= days <= 30))
	{
		return false;
	}

	new message[256];
	format(message, sizeof message, "Administratorma %s dabloka %s-s IP %d dgit, mizezi: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), days, reason);
	SendClientMessageToAll(COLOUR_ADMIN_RED, message);

	new query[256], targetidIP[16];

	GetPlayerIp(targetid, targetidIP, sizeof targetidIP);

	format(query, sizeof query, "INSERT INTO `administrator_ipban_logs`(`issuerName`, `playerName`, `bannedIP`, `date`, `unBanDate`, `reason`) VALUES \
	('%s', '%s', '%s', NOW(), DATE_ADD(NOW(), INTERVAL '%d' DAY), '%s')",\
	GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), targetidIP, days, reason);

	mysql_tquery(DB_GetHandler(), query);
	KickPlayer(targetid);
	return true;
}

CMD:unbanip(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetIP[16], reason[32];
	if (sscanf(params, "s[16]s[32]", targetIP, reason))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /unbanip [playerIP] [reason]");
		return false;
	}

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `bannedIP` FROM `administrator_ipban_logs` WHERE `bannedIP` = '%e'", targetIP);
	mysql_tquery(DB_GetHandler(), query, "DB_UnbanPlayerIP", "iss", playerid, targetIP, reason);
	return true;
}


public DB_OffBanPlayer(const playerid, const name[], const days, const reason[], silent)
{
	new rows;
	cache_get_row_count(rows);

	if (rows != 0)
	{
		new text[64];
		format(text, sizeof text, "Motamashe %s administratoria", name);
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, text);
		return false;
	}

	if (!DB_PlayerNameExists(name))
	{
		new text[64];
		format(text, sizeof text, "Motamashe %s ar aris registrirebuli", name);
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, text);
		return false;
	}

	new message[256];
	if (silent == 0)
	{
		format(message, sizeof message, "Administratorma %s dabloka %s - %d dgit, mizezi: %s", GetPlayerNameEx(playerid), name, days, reason);
		SendClientMessageToAll(COLOUR_ADMIN_RED, message);
	}
	else
	{
		silent = 1;
		format(message, sizeof message, "%s[AdminCMD] %s[%d] banned %s for %d days, reason: %s", FormatHex(COLOUR_ADMIN_RED), GetPlayerNameEx(playerid), playerid, name, days, reason);
		SendAdminMessage(message);
	}

	new query[256];
	format(query, sizeof query, "INSERT INTO `administrator_ban_logs`(`adminName`, `playerName`, `reason`, `date`, `unBanDate`, `wasSilent`) VALUES \
	('%s', '%s', '%s', NOW() , DATE_ADD(NOW(), INTERVAL '%d' DAY), '%d')", GetPlayerNameEx(playerid), name, reason, days, silent);
	mysql_query(DB_GetHandler(), query, false);
	return true;
}

public DB_UnbanPlayer(const playerid, const name[], const reason[])
{
	new rows;
	cache_get_row_count(rows);
	if (rows > 0)
	{
		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `administrator_ban_logs` WHERE `playerName` = '%e'", name);
		mysql_tquery(DB_GetHandler(), query);

		mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrator_unban_logs`(`playerName`, `date`, `issuedBy`, `reason`) VALUES\
		('%s',NOW(),'%s', '%s')", name, GetPlayerNameEx(playerid), reason);
		mysql_tquery(DB_GetHandler(), query);
		return true;
	}
	SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Serveris motamashe mocemuli saxelit ar moidzebna banebis siashi");
	return true;
}

public DB_UnbanPlayerIP(const playerid, const name[], const reason[])
{
	new rows;
	cache_get_row_count(rows);
	if (rows > 0)
	{
		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `administrator_ipban_logs` WHERE `bannedIP` = '%e'", name);
		mysql_tquery(DB_GetHandler(), query);

		mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrator_unbanip_logs`(`playerIP`, `date`, `issuedBy`, `reason`) VALUES\
		('%s', NOW(), '%s', '%s')", name, GetPlayerNameEx(playerid), reason);
		mysql_tquery(DB_GetHandler(), query);

		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Motamashes aexsna IP bani");
		return true;
	}
	SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Serveris motamashe mocemuli IP-it ar moidzebna banebis siashi");
	return true;
}
