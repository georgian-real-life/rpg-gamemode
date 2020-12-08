alias:setplayertempskin("playertempskin", "settempskin", "tempskin")
CMD:setplayertempskin(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0) { return false; }
	new targetid, skinid;

	if (sscanf(params, "ii", targetid, skinid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayertempskin [targetid] [skinid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	SetPlayerSkin(targetid, skinid);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - misca droebiti skini %s[%d]-s. skinid [%d]", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid, skinid);
	SendAdminMessage(adminMessage);

	format(adminMessage, sizeof adminMessage, "%s Administratorma %s dagiyenat droebiti skini.", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid));
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, adminMessage);
	return true;
}
