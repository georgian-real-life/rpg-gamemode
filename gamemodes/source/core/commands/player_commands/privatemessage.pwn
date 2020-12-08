alias:privatemessage("pm")
CMD:privatemessage(playerid, const params[])
{
	new targetid, text[128];

	if (sscanf(params, "is[128]", targetid, text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /privatemessage [targetid] [text]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar moidzebna");
		return false;
	}

	if (targetid == playerid)
	{
		return false;
	}

	new formatedText[144];
	format(formatedText, sizeof formatedText, "(( PM from %s[%d]: %s ))", GetPlayerNameEx(playerid), playerid, text);
	SendClientMessage(targetid, COLOUR_LIGHT_ORANGE, formatedText);

	format(formatedText, sizeof formatedText, "(( PM send to %s[%d]: %s ))", GetPlayerNameEx(playerid), playerid, text);
	SendClientMessage(playerid, COLOUR_LIGHT_ORANGE, formatedText);

	return true;
}
