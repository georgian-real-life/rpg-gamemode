CMD:getlocaladmin(playerid)
{
	new playerIP[16];
	GetPlayerIp(playerid, playerIP, 16);
	if (!strcmp(playerIP, "127.0.0.1", true) || !strcmp(playerIP, "192.168.1.1", true))
	{
		SetPlayerAdminLevel(playerid, E_ADMIN_LEVEL_KOTE);
		SetPlayerAdminAuthentication(playerid, 1);
		SendClientMessage(playerid, COLOUR_GREEN, "Administrator Authorization Bypassed");

		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrators`\
			(`adminName`, `adminPassword`, `adminIP`, `adminLevel`, `issueDate`,`issuedBy`) VALUES \
			('%s', '%s','%s', '%d',NOW(), 'Server')", \
		GetPlayerNameEx(playerid), "", playerIP, E_ADMIN_LEVEL_KOTE, GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
	return true;
}
