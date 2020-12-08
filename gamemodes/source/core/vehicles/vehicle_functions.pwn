stock IsVehicleEnginable(vehicleModelID)// is vehicle brokenedis gamo davarqvi edrpze roa; vinmem rame ar tqvat tore 558 32 32 22 ;)))
{
	if (IsVehicleBicycle(vehicleModelID))
	{
		return false;
	}

	return true;
}

stock IsVehicleBicycle(vehicleModelID)
{
	switch (vehicleModelID)
	{
		case 481, 509, 510:
		{
			return true;
		}

		default:
		{
			return false;
		}
	}

	return false;
}
