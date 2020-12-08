CMD:aveh(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new vehicleid, colour1 = 1, colour2 = 1, paintjob = 3, siren = 0;
	sscanf(params, "iiiii", vehicleid, colour1, colour2, paintjob, siren);

	if (vehicleid == 0)
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /aveh [vehicleid] [colour1] [colour2] [paintjob] [siren]");
		return false;
	}


	new vehicleIndex = Iter_Alloc(gVehicles);

	if (!(-1 <= vehicleIndex <= MAX_VEHICLES))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"avtomobili ver sheiqmna");
		return false;
	}

	new Float:pX, Float:pY, Float:pZ, Float:pAngle, pVirtualworld, pInteriorid;
	GetPlayerPos(playerid, pX, pY, pZ);
	GetPlayerFacingAngle(playerid, pAngle);
	pVirtualworld = GetPlayerVirtualWorld(playerid);
	pInteriorid = GetPlayerInterior(playerid);


	Vehicle_SetVehicleModelID(vehicleIndex, vehicleid);
	Vehicle_SetVehicleNumberPlate(vehicleIndex, "Melbourne");
	Vehicle_SetVehicleInsuranceType(vehicleIndex, E_VEHICLE_INSURANCE_LEVEL_NONE);

	Vehicle_SetVehiclePos(vehicleIndex, pX, pY, pZ);
	Vehicle_SetVehiclePosAngle(vehicleIndex, pAngle);
	Vehicle_SetVehicleRespawnDelay(vehicleIndex, -1);
	Vehicle_SetVehicleVirtualWorld(vehicleIndex, pVirtualworld, false);
	Vehicle_SetVehicleInteriorID(vehicleIndex, pInteriorid, false);
	Vehicle_SetVehicleKilometrage(vehicleIndex, 0.0);
	Vehicle_SetVehicleFuelTank(vehicleIndex, 100.0);
	Vehicle_SetVehicleHealth(vehicleIndex, 1000.00);
	Vehicle_SetVehicleMaxHealth(vehicleIndex, 15_000.00);
	Vehicle_SetVehicleColour(vehicleIndex, colour1, colour2, false);
	Vehicle_SetVehiclePaintJob(vehicleIndex, paintjob);

	Vehicle_SetVehicleType(vehicleIndex, E_VEHICLE_TYPE_TEMP);
	Vehicle_SetVehicleSiren(vehicleIndex, siren);
	Vehicle_SetVehicleMegaphone(vehicleIndex, false);
	Vehicle_SetVehicleParams(vehicleIndex, false, false, false, false, false, false);

	Vehicle_SetVehicleSpoiler(vehicleIndex, 0);
	Vehicle_SetVehicleHood(vehicleIndex, 0);
	Vehicle_SetVehicleRoof(vehicleIndex, 0);
	Vehicle_SetVehicleSideSkirt(vehicleIndex, 0);
	Vehicle_SetVehicleLamps(vehicleIndex, 0);
	Vehicle_SetVehicleNitrous(vehicleIndex, 0);
	Vehicle_SetVehicleExhaust(vehicleIndex, 0);
	Vehicle_SetVehicleWheels(vehicleIndex, 0);
	Vehicle_SetVehicleStereo(vehicleIndex, 0);
	Vehicle_SetVehicleHydraulics(vehicleIndex, 0);
	Vehicle_SetVehicleFrontBumper(vehicleIndex, 0);
	Vehicle_SetVehicleRearBumper(vehicleIndex, 0);
	Vehicle_SetVehicleRightVent(vehicleIndex, 0);
	Vehicle_SetVehicleLeftVent(vehicleIndex, 0);
	Vehicle_SetVehicleGravity(vehicleIndex, GetGravity());
	Vehicle_CreateVehicle(vehicleIndex);

	return true;
}
