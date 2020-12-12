CMD:coinflip(playerid, const params[])
{
	new randomFlip = random(2);

	new text[128];
	format(text, sizeof text, "%s agdebs monetas da svams %s", GetPlayerNameEx(playerid), randomFlip ? "aversze" : "reversze");
	SendProxyMessageByPlayerZ(playerid, 3.0, COLOUR_PURPLE, text);
	SetPlayerChatBubble(playerid, text, COLOUR_PURPLE, 3.0, 2_000);
	return true;
}
