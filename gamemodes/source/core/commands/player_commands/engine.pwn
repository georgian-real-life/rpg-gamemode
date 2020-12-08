alias:engine("en")
CMD:engine(playerid, const params[])
{
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		return false;
	}

	new engine, lights, alarm, doors, bonnet, boot, objective;

	new vehicleid = GetPlayerVehicleID(playerid);
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine == 1)
	{
		SetVehicleParamsEx(vehicleid, false, lights, alarm, doors, bonnet, boot, objective);
		return true;
	}

	SetVehicleParamsEx(vehicleid, true, lights, alarm, doors, bonnet, boot, objective);
	return true;
}
