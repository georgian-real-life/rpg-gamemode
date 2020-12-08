CMD:do(playerid, const params[])
{
	new text[128];
	if (sscanf(params, "s[128]", text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /do [text]");
		return false;
	}

	new formatedText[144];
	format(formatedText, sizeof formatedText, "^ %s ((%s))", text, GetPlayerNameEx(playerid));

	SendProxyMessageByPlayerZ(playerid, 3.0, COLOUR_PURPLE, formatedText);
	SetPlayerChatBubble(playerid, text, COLOUR_PURPLE, 10.0, 5_000);
	return true;
}
