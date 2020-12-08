alias:clearchat("cc")
CMD:clearchat(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	ClearChatForAll();
	return true;
}
