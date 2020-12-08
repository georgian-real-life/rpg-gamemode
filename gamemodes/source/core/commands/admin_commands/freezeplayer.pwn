alias:freezeplayer("freeze")
CMD:freezeplayer(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}

	new targetid;
	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /freezeplayer [targetid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	if (IsPlayerControllable(targetid))
	{
		TogglePlayerControllable(targetid, false);
	}

	else
	{
		TogglePlayerControllable(targetid, true);
	}
	return true;
}
