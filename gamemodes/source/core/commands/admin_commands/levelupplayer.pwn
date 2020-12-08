CMD:levelupplayer(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid;

	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /levelupplayer [targetid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	new playerOldEXP = GetPlayerLevelExp(targetid);
	IncreasePlayerLevel(targetid);
	SetPlayerLevelExp(targetid, playerOldEXP, false);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - moumata leveli %s[%d]-s", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid);
	SendAdminMessage(adminMessage);

	format(adminMessage, sizeof adminMessage, "%s Administratorma %s mogimatat leveli.", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid));
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, adminMessage);
	return true;
}
