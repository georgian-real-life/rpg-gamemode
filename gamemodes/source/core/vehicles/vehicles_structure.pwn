#if defined MAX_VEHICLE_NUMBERPLATE_LENGTH
	#error MAX_VEHICLE_NUMBERPLATE_LENGTH Already defined
#endif
#define MAX_VEHICLE_NUMBERPLATE_LENGTH		14

#if defined INVALID_VEHICLE_OWNER_NAME
	#error INVALID_VEHICLE_OWNER_NAME
#endif
#define INVALID_VEHICLE_OWNER_NAME		"NO"


enum _:E_VEHICLE_TYPES
{
	E_VEHICLE_TYPE_NONE,
	E_VEHICLE_TYPE_JOB,
	E_VEHICLE_TYPE_SERVICE,
	E_VEHICLE_TYPE_RENTAL,
	E_VEHICLE_TYPE_FACTION,
	E_VEHICLE_TYPE_OWNABLE,
	E_VEHICLE_TYPE_TEMP,
};

enum _:E_VEHICLE_INSURANCE_TYPES
{
	E_VEHICLE_INSURANCE_LEVEL_NONE,
	E_VEHICLE_INSURANCE_LEVEL_ONE,
	E_VEHICLE_INSURANCE_LEVEL_TWO,
	E_VEHICLE_INSURANCE_LEVEL_THREE
};

static
		gVehicleID[MAX_VEHICLES],
		gVehicleServerID[MAX_VEHICLES],
		gVehicleModelID[MAX_VEHICLES],
		gVehicleOwnerName[MAX_VEHICLES][MAX_PLAYER_NAME],
		gVehicleNumberPlate[MAX_VEHICLES][MAX_VEHICLE_NUMBERPLATE_LENGTH],
		gVehicleInsuranceType[MAX_VEHICLES],
Float:	gVehicleSpawnPosX[MAX_VEHICLES],
Float:	gVehicleSpawnPosY[MAX_VEHICLES],
Float:	gVehicleSpawnPosZ[MAX_VEHICLES],
Float:	gVehicleSpawnPosAngle[MAX_VEHICLES],
		gVehicleRespawnDelay[MAX_VEHICLES],
		gVehicleSpawnVirtualWorld[MAX_VEHICLES],
		gVehicleSpawnInteriorID[MAX_VEHICLES],
Float:	gVehicleKilometrage[MAX_VEHICLES],
Float:	gVehicleFuelTankAmount[MAX_VEHICLES],
Float:	gVehicleHealth[MAX_VEHICLES],
Float:	gVehicleMaxHealth[MAX_VEHICLES],
		gVehicleColourOne[MAX_VEHICLES],
		gVehicleColourTwo[MAX_VEHICLES],
		gVehiclePaintJob[MAX_VEHICLES],
		gVehicleType[MAX_VEHICLES],
		gVehicleSiren[MAX_VEHICLES],
bool:	gVehicleMegaphone[MAX_VEHICLES],
bool:	gVehicleGPSNavigator[MAX_VEHICLES],
//
		gVehicleEngine[MAX_VEHICLES],
		gVehicleLights[MAX_VEHICLES],
		gVehicleAlarm[MAX_VEHICLES],
		gVehicleLock[MAX_VEHICLES],
		gVehicleBonnet[MAX_VEHICLES],
		gVehicleBoot[MAX_VEHICLES],

//Tuning
		gVehicleSpoiler[MAX_VEHICLES],
		gVehicleHood[MAX_VEHICLES],
		gVehicleRoof[MAX_VEHICLES],
		gVehicleSideSkirt[MAX_VEHICLES],
		gVehicleLamps[MAX_VEHICLES],
		gVehicleNitrous[MAX_VEHICLES],
		gVehicleExhaust[MAX_VEHICLES],
		gVehicleWheels[MAX_VEHICLES],
		gVehicleStereo[MAX_VEHICLES],
		gVehicleHydraulics[MAX_VEHICLES],
		gVehicleFrontBumper[MAX_VEHICLES],
		gVehicleRearBumper[MAX_VEHICLES],
		gVehiclesRightVent[MAX_VEHICLES],
		gVehiclesLeftVent[MAX_VEHICLES],
Float:	gVehicleGravity[MAX_VEHICLES];

new Iterator:gVehicles<MAX_VEHICLES>;


stock Vehicle_GetVehicleID(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleID[index];
}

stock Vehicle_SetVehicleServerID(index, vehicleID)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleServerID[index] = vehicleID;
}

stock Vehicle_GetVehicleServerID(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleServerID[index];
}

stock Vehicle_SetVehicleModelID(index, id)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleModelID[index] = id;
	return true;
}

stock Vehicle_GetVehicleModelID(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleModelID[index];
}

stock Vehicle_SetVehicleOwnerName(index, const ownerName[])
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleOwnerName[index][0] = EOS;
	strcat(gVehicleOwnerName[index], ownerName, MAX_ACTOR_NAME);
	return true;
}

stock Vehicle_GetVehicleOwnerName(index, output[], length = MAX_PLAYER_NAME)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	strcat(output, gVehicleOwnerName[index], length);
	return true;
}

stock Vehicle_SetVehicleNumberPlate(index, const plate[])
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleNumberPlate[index][0] = EOS;
	strcat(gVehicleNumberPlate[index], plate, MAX_VEHICLE_NUMBERPLATE_LENGTH);
	return true;
}

stock Vehicle_GetVehicleNumberPlate(index, output[], length = MAX_VEHICLE_NUMBERPLATE_LENGTH)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	strcat(output, gVehicleNumberPlate[index], length);
	return true;
}

stock Vehicle_SetVehicleInsuranceType(index, insuranceType)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	if (insuranceType < E_VEHICLE_INSURANCE_LEVEL_NONE)
	{
		insuranceType = E_VEHICLE_INSURANCE_LEVEL_NONE;
	}
	else if (insuranceType > E_VEHICLE_INSURANCE_LEVEL_THREE)
	{
		insuranceType = E_VEHICLE_INSURANCE_LEVEL_THREE;
	}

	gVehicleInsuranceType[index] = E_VEHICLE_INSURANCE_LEVEL_THREE;
	return true;
}

stock Vehicle_GetVehicleInsuranceType(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleInsuranceType[index];
}

stock Vehicle_SetVehiclePos(index, Float:x, Float:y, Float:z)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleSpawnPosX[index] = x;
	gVehicleSpawnPosY[index] = y;
	gVehicleSpawnPosZ[index] = z;
	return true;
}

stock Vehicle_GetVehiclePos(index, &Float:x, &Float:y, &Float:z)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	x = gVehicleSpawnPosX[index];
	y = gVehicleSpawnPosY[index];
	z = gVehicleSpawnPosZ[index];
	return true;
}

stock Vehicle_SetVehiclePosAngle(index, Float:angle)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleSpawnPosAngle[index] = angle;
	return true;
}


stock Vehicle_GetVehiclePosAngle(index, &Float:angle)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	angle = gVehicleSpawnPosAngle[index];
	return true;
}

stock Vehicle_SetVehicleRespawnDelay(index, respawnDelay)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleRespawnDelay[index] = respawnDelay;
	return true;
}

stock Vehicle_GetVehicleRespawnDelay(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleRespawnDelay[index];
}

stock Vehicle_SetVehicleVirtualWorld(index, virtualworld, update = false)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleSpawnVirtualWorld[index] = virtualworld;

	if (update)
	{
		SetVehicleVirtualWorld(gVehicleServerID[index], virtualworld);
	}

	return true;
}

stock Vehicle_GetVehicleVirtualWorld(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleSpawnVirtualWorld[index];
}

stock Vehicle_SetVehicleInteriorID(index, interiorid, update = false)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleSpawnInteriorID[index] = interiorid;

	if (update)
	{
		LinkVehicleToInterior(gVehicleServerID[index], interiorid);
	}
	return true;
}

stock Vehicle_GetVehicleInteriorID(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleSpawnInteriorID[index];
}

stock Vehicle_SetVehicleKilometrage(index, Float:metres)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleKilometrage[index] = metres;
	return true;
}


stock Vehicle_GetVehicleKilometrage(index, &Float:metres)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	metres = gVehicleKilometrage[index];
	return true;
}

stock Vehicle_SetVehicleFuelTank(index, Float:amount)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleFuelTankAmount[index] = amount;
	return true;
}


stock Vehicle_GetVehicleFuelTank(index, &Float:fuelTank)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	fuelTank = gVehicleFuelTankAmount[index];
	return true;
}

stock Vehicle_SetVehicleHealth(index, Float:health)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleHealth[index] = health;
	return true;
}


stock Vehicle_GetVehicleHealth(index, &Float:health)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	health = gVehicleHealth[index];
	return true;
}

stock Vehicle_SetVehicleMaxHealth(index, Float:health)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleMaxHealth[index] = health;
	return true;
}


stock Vehicle_GetVehicleMaxHealth(index, &Float:health)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	health = gVehicleMaxHealth[index];
	return true;
}

stock Vehicle_SetVehicleColour(index, colour1, colour2, updateColour = false)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleColourOne[index] = colour1;
	gVehicleColourTwo[index] = colour2;

	if (updateColour)
	{
		ChangeVehicleColor(gVehicleServerID[index], colour1, colour2);
	}

	return true;
}

stock Vehicle_GetVehicleColour(index, &colourOne, &colourTwo)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	colourOne = gVehicleColourOne[index];
	colourTwo = gVehicleColourTwo[index];
	return true;
}

stock Vehicle_SetVehiclePaintJob(index, paintJobID)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehiclePaintJob[index] = paintJobID;
	return true;
}

stock Vehicle_GetVehiclePaintJob(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehiclePaintJob[index];
}

stock Vehicle_SetVehicleType(index, type)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleType[index] = type;
	return true;
}

stock Vehicle_GetVehicleType(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleType[index];
}

stock Vehicle_SetVehicleSiren(index, siren)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleSiren[index] = siren;
	return true;
}

stock Vehicle_GetVehicleSiren(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleSiren[index];
}

stock Vehicle_SetVehicleMegaphone(index, bool:toggle)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleMegaphone[index] = toggle;
	return true;
}

stock bool:Vehicle_GetVehicleMegaphone(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleMegaphone[index];
}

stock Vehicle_SetVehicleGPSNavigator(index, bool:toggle)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleGPSNavigator[index] = toggle;
	return true;
}

stock bool:Vehicle_GetVehicleGPSNavigator(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleGPSNavigator[index];
}

stock Vehicle_SetVehicleParams(index, engine, lights, alarm, lock, bonnet, boot)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleEngine[index] = engine;
	gVehicleLights[index] = lights;
	gVehicleAlarm[index] = alarm;
	gVehicleLock[index] = lock;
	gVehicleBonnet[index] = bonnet;
	gVehicleBoot[index] = boot;
	return true;
}

stock Vehicle_GetVehicleParams(index, &engine, &lights, &alarm, &lock, &bonnet, &boot)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	engine = gVehicleEngine[index];
	lights = gVehicleLights[index];
	alarm = gVehicleAlarm[index];
	lock = gVehicleLock[index];
	bonnet = gVehicleBonnet[index];
	boot = gVehicleBoot[index];
	return true;
}

stock Vehicle_SetVehicleSpoiler(index, spoiler)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, spoiler))
	{
		return false;
	}

	gVehicleSpoiler[index] = spoiler;
	return true;
}

stock Vehicle_GetVehicleSpoiler(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleSpoiler[index];
}

stock Vehicle_SetVehicleHood(index, hood)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, hood))
	{
		return false;
	}

	gVehicleHood[index] = hood;
	return true;
}

stock Vehicle_GetVehicleHood(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleHood[index];
}

stock Vehicle_SetVehicleRoof(index, roof)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, roof))
	{
		return false;
	}

	gVehicleRoof[index] = roof;
	return true;
}

stock Vehicle_GetVehicleRoof(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleRoof[index];
}

stock Vehicle_SetVehicleSideSkirt(index, sideskirt)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, sideskirt))
	{
		return false;
	}

	gVehicleSideSkirt[index] = sideskirt;
	return true;
}

stock Vehicle_GetVehicleSideSkirt(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleSideSkirt[index];
}

stock Vehicle_SetVehicleLamps(index, lamps)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, lamps))
	{
		return false;
	}

	gVehicleLamps[index] = lamps;
	return true;
}

stock Vehicle_GetVehicleLamps(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleLamps[index];
}

stock Vehicle_SetVehicleNitrous(index, nitrous)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, nitrous))
	{
		return false;
	}

	gVehicleNitrous[index] = nitrous;
	return true;
}

stock Vehicle_GetVehicleNitrous(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleNitrous[index];
}

stock Vehicle_SetVehicleExhaust(index, exhaust)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, exhaust))
	{
		return false;
	}

	gVehicleExhaust[index] = exhaust;
	return true;
}

stock Vehicle_GetVehicleExhaust(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleExhaust[index];
}

stock Vehicle_SetVehicleWheels(index, wheels)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, wheels))
	{
		return false;
	}

	gVehicleWheels[index] = wheels;
	return true;
}

stock Vehicle_GetVehicleWheels(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleWheels[index];
}

stock Vehicle_SetVehicleStereo(index, stereo)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, stereo))
	{
		return false;
	}

	gVehicleStereo[index] = stereo;
	return true;
}

stock Vehicle_GetVehicleStereo(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleStereo[index];
}

stock Vehicle_SetVehicleHydraulics(index, hydraulics)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, hydraulics))
	{
		return false;
	}

	gVehicleHydraulics[index] = hydraulics;
	return true;
}

stock Vehicle_GetVehicleHydraulics(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleHydraulics[index];
}

stock Vehicle_SetVehicleFrontBumper(index, frontBumper)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, frontBumper))
	{
		return false;
	}

	gVehicleFrontBumper[index] = frontBumper;
	return true;
}

stock Vehicle_GetVehicleFrontBumper(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleFrontBumper[index];
}

stock Vehicle_SetVehicleRearBumper(index, rearBumper)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, rearBumper))
	{
		return false;
	}

	gVehicleRearBumper[index] = rearBumper;
	return true;
}

stock Vehicle_GetVehicleRearBumper(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehicleRearBumper[index];
}

stock Vehicle_SetVehicleRightVent(index, rightVent)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, rightVent))
	{
		return false;
	}

	gVehiclesRightVent[index] = rightVent;
	return true;
}

stock Vehicle_GetVehicleRightVent(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehiclesRightVent[index];
}

stock Vehicle_SetVehicleLeftVent(index, leftVent)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	new vehicleid = Vehicle_GetVehicleModelID(index);
	if (!IsVehicleUpgradeCompatible(vehicleid, leftVent))
	{
		return false;
	}

	gVehiclesLeftVent[index] = leftVent;
	return true;
}

stock Vehicle_GetVehicleLeftVent(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	return gVehiclesLeftVent[index];
}

stock Vehicle_SetVehicleGravity(index, Float:gravity)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleGravity[index] = gravity;
	return true;
}

stock Vehicle_GetVehicleGravity(index, &Float:gravity)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gravity = gVehicleGravity[index];
	return true;
}

stock Vehicle_CreateVehicle(index)
{
	if (!(-1 <= index <= MAX_VEHICLES))
	{
		return false;
	}

	gVehicleServerID[index] = CreateVehicle(gVehicleModelID[index], gVehicleSpawnPosX[index], gVehicleSpawnPosY[index], gVehicleSpawnPosZ[index], gVehicleSpawnPosAngle[index], gVehicleColourOne[index], gVehicleColourTwo[index], gVehicleRespawnDelay[index], gVehicleSiren[index]);
	SetVehicleToRespawn(gVehicleServerID[index]);
	SetVehicleParamsEx(gVehicleServerID[index], gVehicleEngine[index], gVehicleLights[index], gVehicleAlarm[index], gVehicleLock[index], gVehicleBonnet[index], gVehicleBoot[index], 0);
	SetVehicleVirtualWorld(gVehicleServerID[index], gVehicleSpawnVirtualWorld[index]);
	LinkVehicleToInterior(gVehicleServerID[index], gVehicleSpawnInteriorID[index]);
	SetVehicleHealth(gVehicleServerID[index], gVehicleHealth[index]);
	ChangeVehiclePaintjob(gVehicleServerID[index], gVehiclePaintJob[index]);
	SetVehicleNumberPlate(gVehicleServerID[index], gVehicleNumberPlate[index]);

	AddVehicleComponent(gVehicleServerID[index], gVehicleSpoiler[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleHood[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleRoof[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleSideSkirt[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleLamps[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleNitrous[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleExhaust[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleWheels[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleStereo[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleHydraulics[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleFrontBumper[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehicleRearBumper[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehiclesRightVent[index]);
	AddVehicleComponent(gVehicleServerID[index], gVehiclesLeftVent[index]);
	return true;
}
