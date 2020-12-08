CMD:setplayerinteriorid(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, interiorid;

	if (sscanf(params, "ii", targetid, interiorid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayerinteriorid [targetid] [interiorid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	AC_SetPlayerInteriorID(targetid, interiorid, true);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - sheucvala interiorid-i %s[%d]-s. interiorid [%d]", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid, interiorid);
	SendAdminMessage(adminMessage);

	format(adminMessage, sizeof adminMessage, "%s Administratorma %s shegicvalat interiorid-i.", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid));
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, adminMessage);
	return true;
}
