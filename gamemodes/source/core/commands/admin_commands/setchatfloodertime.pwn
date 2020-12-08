alias:setchatfloodertime("setchatflood")
CMD:setchatfloodertime(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new timeout;

	if (sscanf(params, "i", timeout))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setchatfloodertime [seconds]");
		return false;
	}

	SetChatFlooderTime(timeout);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - Shecvala chat flooder-i %d wamze", \
		FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
		(timeout));
	SendAdminMessage(adminMessage);

	return true;
}
