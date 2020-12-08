CMD:admins(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}

	new message[144];
	foreach (new admin : gAdministrators)
	{
		format(message, sizeof message, "Administrator - %s[%d] - Level - %d", GetPlayerNameEx(admin), admin, GetPlayerAdminLevel(admin));
		SendClientMessage(playerid, COLOUR_INFORMATION, message);
	}
	return true;
}
