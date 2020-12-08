CMD:jetpack(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return true;
}
