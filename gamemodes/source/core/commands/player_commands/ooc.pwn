alias:ooc("b")
CMD:ooc(playerid, const params[])
{
	new text[128];
	if (sscanf(params, "s[128]", text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /ooc [text]");
		return false;
	}

	new formatedText[144];
	format(formatedText, sizeof formatedText, "(( %s[%d]: %s ))", GetPlayerNameEx(playerid), playerid, text);
	SendProxyMessageByPlayerZ(playerid, 3.0, COLOUR_WHITE, formatedText);
	return true;
}
