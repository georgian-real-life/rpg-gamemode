CMD:goto(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0) { return false; }
	new targetid;

	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /goto [targetid]");
		return false;
	}

	if (targetid == playerid) { return false; }

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	new Float:posX, Float:posY, Float:posZ, virtualworld, interiorid;

	GetPlayerPos(targetid, posX, posY, posZ);
	interiorid = GetPlayerInterior(targetid);
	virtualworld = GetPlayerVirtualWorld(targetid);

	AC_SetPlayerPos(playerid, posX, posY, posZ, true);
	AC_SetPlayerVirtualWorld(playerid, virtualworld, true);
	AC_SetPlayerInteriorID(playerid, interiorid, true);
	return true;
}
