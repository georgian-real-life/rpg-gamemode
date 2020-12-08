alias:getplayerip("getip")
CMD:getplayerip(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid;
	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /getplayerip [targetid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	new text[144], targetIP[16];
	GetPlayerIp(targetid, targetIP, sizeof targetIP);
	format(text, sizeof text, "%s[%d]- %s", GetPlayerNameEx(targetid), targetid, targetIP);
	SendClientMessage(playerid, COLOUR_LIGHT_ERROR, text);
	return true;
}
