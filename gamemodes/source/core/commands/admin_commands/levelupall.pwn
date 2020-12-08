CMD:levelupall(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new oldXP;
	foreach(new player : Player)
	{
		oldXP = GetPlayerLevelExp(player);
		IncreasePlayerLevel(player);
		SetPlayerLevelExp(player, oldXP, false);
	}

	new text[144];
	format(text, sizeof text, "Administratorma %s moumata gauzarda yvela motamashes leveli", GetPlayerNameEx(playerid));
	SendClientMessageToAll(COLOUR_ADMIN_RED, text);
	return true;
}
