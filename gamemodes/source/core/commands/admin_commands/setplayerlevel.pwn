CMD:setplayerlevel(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new targetid, level;

	if (sscanf(params, "ii", targetid, level))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayerlevel [targetid] [level]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	SetPlayerLevel(playerid, level, true);

	new adminMessage[144], playerText[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - sheucvala leveli %s[%d]-s. level:[$%d]", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid, level);
	SendAdminMessage(adminMessage);

	format(playerText, sizeof playerText, "%s Administratorma %s shegicvalat level-i %d-ze.", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), level);
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, playerText);
	return true;
}
