alias:whisper("w")
CMD:whisper(playerid, const params[])
{
	new text[128], formatedText[144];
	if (sscanf(params, "s[128]", text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /whisper [text]");
		return false;
	}

	format(formatedText, sizeof formatedText, "%s churchulebs: %s", GetPlayerNameEx(playerid), text);
	SendProxyMessageByPlayerZ(playerid, 3.0, COLOUR_WHITE, formatedText);
	SetPlayerChatBubble(playerid, "Chaichurchula", COLOUR_LIGHT_GREY, 3.0, 2_000);
	return true;
}
