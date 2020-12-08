CMD:payday(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach(new player : Player)
	{
		SetPlayerPayDayTime(player, 3600, false);
	}
	return true;
}
