CMD:setplayervirtualworld(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, virtualworld;

	if (sscanf(params, "ii", targetid, virtualworld))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayervirtualworld [targetid] [virtualworld]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	AC_SetPlayerVirtualWorld(targetid, virtualworld, true);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - sheucvala virtualworld-i %s[%d]-s. virtualworld [%d]", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid, virtualworld);
	SendAdminMessage(adminMessage);

	format(adminMessage, sizeof adminMessage, "%s Administratorma %s shegicvalat virtualworld-i.", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid));
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, adminMessage);

	return true;
}
