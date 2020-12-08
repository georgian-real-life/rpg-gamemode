alias:setcarcolour("setcarcolor", "setvehcolor")
CMD:setcarcolour(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new vehicleid, colour1, colour2;

	if (sscanf(params, "iii", vehicleid, colour1, colour2))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setcarcolour [vehicleID] [colour1] [colour2]");
		return false;
	}

	if (!IsValidVehicle(vehicleid))
	{
		return false;
	}

	new index = vehicleid - 1;
	Vehicle_SetVehicleColour(index, colour1, colour2, true);

	return true;
}
