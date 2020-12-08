alias:gotocar("gotoveh")
CMD:gotocar(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new vehicleid;
	if (sscanf(params, "i", vehicleid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /gotocar [vehicleid [/dl]]");
		return false;
	}

	if (!IsValidVehicle(vehicleid))
	{
		return false;
	}

	new Float:vPosX, Float:vPosY, Float:vPosZ, vVirtualworld, vInteriorid;
	GetVehiclePos(vehicleid, vPosX, vPosY, vPosZ);
	vVirtualworld = GetVehicleVirtualWorld(vehicleid);

	new index = vehicleid - 1;
	vInteriorid = Vehicle_GetVehicleInteriorID(index);

	AC_SetPlayerPos(playerid, vPosX, vPosY, vPosZ, true);
	AC_SetPlayerVirtualWorld(playerid, vVirtualworld, true);
	AC_SetPlayerInteriorID(playerid, vInteriorid, true);
	return true;
}
