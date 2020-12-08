alias:acarinfo("avehinfo")
CMD:acarinfo(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new vehicleid;
	if (sscanf(params, "i", vehicleid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /acarinfo [vehicleid [/dl]]");
	}

	if (!IsValidVehicle(vehicleid))
	{
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused playerID, dialogID, response, listitem, inputtext
	}

	new index = vehicleid - 1;

	new outputBox[2048];

	new ownerName[MAX_PLAYER_NAME];
	Vehicle_GetVehicleOwnerName(index, ownerName);
	new numberPlate[MAX_VEHICLE_NUMBERPLATE_LENGTH + 1];
	Vehicle_GetVehicleNumberPlate(index, numberPlate, MAX_VEHICLE_NUMBERPLATE_LENGTH);

	new Float:x, Float:y, Float:z, Float:angle;
	Vehicle_GetVehiclePos(index, x, y, z);
	Vehicle_GetVehiclePosAngle(index, angle);

	new Float:kilometrage;
	Vehicle_GetVehicleKilometrage(index, kilometrage);

	new Float:fuelTank;
	Vehicle_GetVehicleFuelTank(index, fuelTank);

	new Float:health;
	Vehicle_GetVehicleHealth(index, health);

	new Float:maxHealth;
	Vehicle_GetVehicleMaxHealth(index, maxHealth);

	new colour1, colour2;
	Vehicle_GetVehicleColour(index, colour1, colour2);

	new Float:gravity;
	Vehicle_GetVehicleGravity(index, gravity);


	format(outputBox, sizeof outputBox, "\
	DB ID\t\t\t\t %d\n\
	Server ID\t\t\t %d\n\
	Model ID\t\t\t %d\n\
	Owner Name\t\t\t %s\n\
	Number Plate\t\t\t %s\n\
	Insurance Type\t\t\t %d\n\
	Spawn X Y Z A\t\t %f %f %f %f\n\
	Respawn Delay\t\t%d\n\
	Spawn Virtualworld\t\t %d\n\
	Spawn InteriorID\t\t %d\n\
	Kilometrage\t\t\t %f\n\
	Fuel Tank\t\t\t%f\n\
	Health\t\t\t\t%f\n\
	Max Health\t\t\t\t%f\n\
	Colours\t\t\t %d %d\n\
	PaintJob\t\t\t %d\n\
	Type\t\t\t\t %d\n\
	Siren\t\t\t\t %d\n\
	Megaphone\t\t\t %d\n\
	GPS Navigator\t\t\t %d\n\
\
	Spoiler\t\t\t\t %d\n\
	Hood\t\t\t\t %d\n\
	Roof\t\t\t\t %d\n\
	SideSkirt\t\t\t %d\n\
	Lamps\t\t\t\t %d\n\
	Nitrous\t\t\t\t %d\n\
	Exhaust\t\t\t %d\n\
	Wheels\t\t\t\t %d\n\
	Stereo\t\t\t\t %d\n\
	Hydraulics\t\t\t %d\n\
	Front Bumper\t\t\t %d\n\
	Rear Bumper\t\t\t %d\n\
	Right Vent\t\t\t %d\n\
	Left Vent\t\t\t %d\n\
	Gravity\t\t\t\t%f",

	Vehicle_GetVehicleID(index),
	Vehicle_GetVehicleServerID(index),
	Vehicle_GetVehicleModelID(index),
	ownerName,
	numberPlate,
	Vehicle_GetVehicleInsuranceType(index),
	x, y, z, angle,
	Vehicle_GetVehicleRespawnDelay(index),
	Vehicle_GetVehicleVirtualWorld(index),
	Vehicle_GetVehicleInteriorID(index),
	kilometrage,
	fuelTank,
	health,
	maxHealth,
	colour1, colour2,
	Vehicle_GetVehiclePaintJob(index),
	Vehicle_GetVehicleType(index),
	Vehicle_GetVehicleSiren(index),
	Vehicle_GetVehicleMegaphone(index),
	Vehicle_GetVehicleGPSNavigator(index),

	Vehicle_GetVehicleSpoiler(index),
	Vehicle_GetVehicleHood(index),
	Vehicle_GetVehicleRoof(index),
	Vehicle_GetVehicleSideSkirt(index),
	Vehicle_GetVehicleLamps(index),
	Vehicle_GetVehicleNitrous(index),
	Vehicle_GetVehicleExhaust(index),
	Vehicle_GetVehicleWheels(index),
	Vehicle_GetVehicleStereo(index),
	Vehicle_GetVehicleHydraulics(index),
	Vehicle_GetVehicleFrontBumper(index),
	Vehicle_GetVehicleRearBumper(index),
	Vehicle_GetVehicleRightVent(index),
	Vehicle_GetVehicleLeftVent(index),
	gravity
	);

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Vehicle Info", outputBox, !"", !"X");
	return true;
}
