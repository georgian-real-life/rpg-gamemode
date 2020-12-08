CMD:kick(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}

	new targetid = INVALID_PLAYER_ID, reason[24], silent;

	sscanf(params, "is[24]i", targetid, reason, silent);

	if ((targetid == INVALID_PLAYER_ID) && (!isnull(reason) || !strcmp(reason, "%s")))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /kick [targetid] [reason] [silent]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || targetid == playerid)
	{
		return false;
	}

	if (GetPlayerAdminLevel(targetid) >= GetPlayerAdminLevel(playerid))
	{
		return false;
	}

	new text[144];
	if (silent == 0)
	{
		format(text, sizeof text, "Administratorma %s gaagdo %s serveridan. mizezi: %s", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason);
		SendClientMessageToAll(COLOUR_ADMIN_RED, text);
	}
	else
	{
		silent = 1;
		format(text, sizeof text, "[AdminCMD] %s[%d] skicked %s[%d]. reason %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(targetid), targetid, reason);
		SendAdminMessage(text);
	}

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrator_kick_logs`\
	(`adminName`, `playerName`, `reason`, `date`, `wasSilent`) VALUES \
	('%s','%s','%s',NOW(), '%d')",\
	GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), reason, silent);
	mysql_tquery(DB_GetHandler(), query);

	KickPlayer(targetid);
	return true;
}
