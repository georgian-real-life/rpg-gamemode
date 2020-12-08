CMD:ame(playerid, const params[])
{
	new text[128];
	if (sscanf(params, "s[128]", text))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /ame [text]");
		return false;
	}

	SetPlayerChatBubble(playerid, text, COLOUR_PURPLE, 10.0, 5_000);
	return true;
}
