alias:setcommandfloodertime("setcommandflood")
CMD:setcommandfloodertime(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new timeout;

	if (sscanf(params, "i", timeout))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setcommandfloodertime [seconds]");
		return false;
	}

	SetCommandFlooderTime(timeout);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - Shecvala command flooder-i %d wamze", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	(timeout));
	SendAdminMessage(adminMessage);

	return true;
}
