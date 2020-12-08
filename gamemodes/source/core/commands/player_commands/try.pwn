CMD:try(playerid, const params[])
{
	new text[64];
	if (sscanf(params, "s[64]", text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /try [text]");
	}

	new outputText[144];
	new randomNum = random(2);

	format(outputText, sizeof outputText, "%s: %s | %s", GetPlayerNameEx(playerid), text, (randomNum > 0)? "Warmatebit" : "Warumateblad");
	SendProxyMessageByPlayerZ(playerid, 3.0, COLOUR_WHITE, text);
	return true;
}
