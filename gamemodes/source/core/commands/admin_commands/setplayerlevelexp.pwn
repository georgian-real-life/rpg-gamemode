
CMD:setplayerlevelexp(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new targetid, levelExp;

	if (sscanf(params, "ii", targetid, levelExp))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayerlevelexp [targetid] [levelexp]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	SetPlayerLevelExp(targetid, (GetPlayerLevelExp(targetid) + levelExp), false);

	new adminMessage[144], playerText[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - sheucvala levelis exp %s[%d]-s. levelexp:[%d]", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid, levelExp);
	SendAdminMessage(adminMessage);

	format(playerText, sizeof playerText, "%s Administratorma %s shegicvalat levelis exp %d-ze.", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), levelExp);
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, playerText);
	return true;
}
