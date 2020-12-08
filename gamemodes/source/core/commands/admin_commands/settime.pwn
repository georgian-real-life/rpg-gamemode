CMD:settime(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new time;
	if (sscanf(params, "i", time))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /settime [time]");
		return false;
	}

	if (time < 0 || time >= 24)
	{
		time = 0;
	}

	SetWorldTime(time);
	return true;
}
