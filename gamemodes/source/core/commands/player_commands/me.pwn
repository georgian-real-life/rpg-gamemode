CMD:me(playerid, const params[])
{
	new text[128], formatedText[144];
	if (sscanf(params, "s[128]", text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /me [text]");
		return false;
	}

	format(formatedText, sizeof formatedText, "^ %s %s", GetPlayerNameEx(playerid), text);

	SendProxyMessageByPlayerZ(playerid, 3.0, COLOUR_PURPLE, formatedText);
	SetPlayerChatBubble(playerid, text, COLOUR_PURPLE, 10.0, 5_000);
	return true;
}
