CMD:tpcoor(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}
	new Float:x, Float:y, Float:z, virtualworld, interiorid;

	if (sscanf(params, "fffii", x, y, z, virtualworld, interiorid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /tpcoor [x] [y] [z] [virtualworld] [interiorid]");
		return true;
	}

	AC_SetPlayerPos(playerid, x, y, z, true);
	AC_SetPlayerVirtualWorld(playerid, virtualworld, true);
	AC_SetPlayerInteriorID(playerid, interiorid, true);
	return true;
}
