CMD:setweather(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new weather;
	if (sscanf(params, "i", weather))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setweather [weather]");
		return false;
	}

	SetWeather(weather);
	return true;
}
