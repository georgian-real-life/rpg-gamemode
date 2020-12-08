CMD:gethere(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0) { return false; }
	new targetid;

	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /gethere [targetid]");
		return false;
	}

	if (targetid == playerid) { return false; }

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}
	new Float:posX, Float:posY, Float:posZ, virtualworld, interiorid;

	GetPlayerPos(playerid, posX, posY, posZ);
	interiorid = GetPlayerInterior(playerid);
	virtualworld = GetPlayerVirtualWorld(playerid);

	AC_SetPlayerPos(targetid, posX, posY, posZ, true);
	AC_SetPlayerVirtualWorld(targetid, virtualworld, true);
	AC_SetPlayerInteriorID(targetid, interiorid, true);
	return true;
}
