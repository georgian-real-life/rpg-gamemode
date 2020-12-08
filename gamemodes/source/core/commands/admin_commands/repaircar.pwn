alias:repaircar("repairvehicle")
CMD:repaircar(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new vehicleid = 0;
	sscanf(params, "i", vehicleid);

	if (vehicleid > 0 && IsValidVehicle(vehicleid))
	{
		RepairVehicle(vehicleid);
		new index = vehicleid - 1;
		Vehicle_SetVehicleHealth(index, 1000.00);
		return true;
	}

	new playerState = GetPlayerState(playerid);
	if (playerState == PLAYER_STATE_PASSENGER || playerState == PLAYER_STATE_DRIVER)
	{
		new vehicleID = GetPlayerVehicleID(playerid);
		RepairVehicle(vehicleID);
		return true;
	}
	else
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /repaircar [vehicleid [/dl]]");
	}

	return true;
}
