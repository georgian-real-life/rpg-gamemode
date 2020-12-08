alias:setplayerskin("setskin", "skin", "playerskin")
CMD:setplayerskin(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new targetid, skinid;

	if (sscanf(params, "ii", targetid, skinid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayerskin [targetid] [skinid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	SetPlayerSpawnSkin(targetid, skinid, true, true);
	UpdatePlayerSpawnInfo(targetid);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - sheucvala skini %s[%d]-s. skinid [%d]", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid, skinid);
	SendAdminMessage(adminMessage);

	format(adminMessage, sizeof adminMessage, "%s Administratorma %s shegicvalat skini.", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid));
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, adminMessage);
	return true;
}
