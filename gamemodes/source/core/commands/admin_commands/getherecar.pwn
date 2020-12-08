alias:getherecar("gethereveh")
CMD:getherecar(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new vehicleid;
	if (sscanf(params, "i", vehicleid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /getherecar [vehicleid [/dl]]");
		return false;
	}

	if (!IsValidVehicle(vehicleid))
	{
		return false;
	}

	new Float:pX, Float:pY, Float:pZ, pVirtualWorld, pInteriorid;
	GetPlayerPos(playerid, pX, pY, pZ);
	pVirtualWorld = GetPlayerVirtualWorld(playerid);
	pInteriorid = GetPlayerInterior(playerid);


	SetVehiclePos(vehicleid, pX, pY, pZ);
	SetVehicleVirtualWorld(vehicleid, pVirtualWorld);
	LinkVehicleToInterior(vehicleid, pInteriorid);
	return true;
}
