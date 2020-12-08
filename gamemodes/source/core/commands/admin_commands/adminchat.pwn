alias:adminchat("a", "admin")
CMD:adminchat(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0) { return false; }

	new userText[100+1];
	if (sscanf(params, "s[100]", userText))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /adminchat [text]");
		return false;
	}

	new adminMessage[144+1];
	format(adminMessage, sizeof (adminMessage), "{22D856}[AdminChat] | %s[%d]: %s", GetPlayerNameEx(playerid), playerid, userText);
	SendAdminMessage(adminMessage);

	return true;
}
