CMD:licenses(playerid, const params[])
{
	new text[256];
	SendClientMessage(playerid, COLOUR_INFORMATION, "------------[Licenziebi]------------");

	format(text, sizeof text, "Msubuqi avtomobilis tarebis ufleba - %s", GetPlayerPassengerLicense(playerid)? "Gaqvt":"Ar gaqvt");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	format(text, sizeof text, "Motocikletis tarebis ufleba - %s", GetPlayerMotorcycleLicense(playerid)? "Gaqvt":"Ar gaqvt");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	format(text, sizeof text, "Sazogadoebrivi transportis tarebis ufleba - %s", GetPlayerPublicServiceLicense(playerid)? "Gaqvt":"Ar gaqvt");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	format(text, sizeof text, "Komerciuli transportis tarebis ufleba - %s", GetPlayerCommercialLicense(playerid)? "Gaqvt":"Ar gaqvt");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	format(text, sizeof text, "Sazgvao transportis martvis ufleba - %s", GetPlayerWaterTransportLicense(playerid)? "Gaqvt":"Ar gaqvt");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	format(text, sizeof text, "Pilotis licenzia - %s", GetPlayerPilotLicense(playerid)? "Agebulia":"Ar aris agebuli");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	format(text, sizeof text, "Iaragis tarebis ufleba - %s", GetPlayerGunLicense(playerid)? "Gaqvt ":"Ar gaqvt");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	format(text, sizeof text, "Biznesis registraciis ufleba - %s", GetPlayerBusinessLicense(playerid)? "Gaqvt":"Ar gaqvt");
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	SendClientMessage(playerid, COLOUR_INFORMATION, "----------------------------------");
	return true;
}
