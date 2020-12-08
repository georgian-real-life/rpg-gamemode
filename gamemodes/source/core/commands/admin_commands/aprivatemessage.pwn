alias:aprivatemessage("apm")
CMD:aprivatemessage(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, text[128];

	if (sscanf(params, "is[128]", targetid, text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /aprivatemessage [targetid] [text]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	new formatedText[144];
	format(formatedText, sizeof formatedText, "Administrator %s mogwerat: %s", GetPlayerNameEx(playerid), text);
	SendClientMessage(targetid, COLOUR_LIGHT_ERROR, formatedText);

	return true;
}
