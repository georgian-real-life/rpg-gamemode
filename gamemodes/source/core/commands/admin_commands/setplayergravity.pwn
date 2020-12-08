CMD:setplayergravity(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, Float:gravity;
	if (sscanf(params, "if", targetid, gravity))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayergravity [targetid] [gravity]");
		return false;
	}

	SetPlayerGravity(targetid, gravity);
	return true;
}
