alias:shout("s", "scream")
CMD:shout(playerid, const params[])
{
	new text[128], formatedText[144];
	if (sscanf(params, "s[128]", text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /shout [text]");
		return false;
	}

	format(formatedText, sizeof formatedText, "%s yviris: %s", GetPlayerNameEx(playerid), text);
	SendProxyMessageByPlayerZ(playerid, 30.0, COLOUR_WHITE, formatedText);
	return true;
}
