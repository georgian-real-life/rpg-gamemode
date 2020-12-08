alias:setplayerarmour("setparmour", "setplayerarmor")
CMD:setplayerarmour(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}

	new targetid, armour;
	if (sscanf(params, "ii", targetid, armour))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayerarmour [targetid] [armour]");
		return true;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		return false;
	}

	SetPlayerArmour(targetid, float(armour));

	new text[144];
	format(text, sizeof text, "%s Administratorma %s shegicvalat tqven bronis machvenebeli %d -ze", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), armour);
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, text);

	format(text, sizeof text, "%s [AdminCMD] %s[%d] sheucvala bronis machvenebeli %s[%d] %d -ze", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(targetid), targetid, armour);
	SendAdminMessage(text);
	return true;
}
