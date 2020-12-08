alias:setplayerhealth("setphp", "sethp")
CMD:setplayerhealth(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0) { return true; }

	new targetid, health;
	if (sscanf(params, "ii", targetid, health))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayerhealth [targetid] [health]");
		return true;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		return false;
	}

	SetPlayerHealth(targetid, float(health));

	new text[144];
	format(text, sizeof text, "%s Administratorma %s shegicvalat tqven sicocxlis machvenebeli %d -ze", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), health);
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, text);

	format(text, sizeof text, "%s [AdminCMD] %s[%d] sheucvala sicocxlis machvenebeli %s[%d] %d -ze", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(targetid), targetid, health);
	SendAdminMessage(text);
	return true;
}
