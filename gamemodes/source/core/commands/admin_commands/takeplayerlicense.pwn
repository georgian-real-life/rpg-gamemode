alias:takeplayerlicense("takelic")
CMD:takeplayerlicense(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}
	new targetid;

	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /takeplayerlicense [targetid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, inputtext, playerID

		new adminMessage[144], playerText[144], licenseName[64];
		if (response)
		{
			switch (listitem)
			{
				case 0://passenger license
				{
					SetPlayerPassengerLicense(targetid, 0, true);
					licenseName = "msubuqi avtomobilis martvis mowmoba";
				}
				case 1:
				{
					SetPlayerMotorcycleLicense(targetid, 0, true);
					licenseName = "motocikletis martvis mowmoba";
				}
				case 2:
				{
					SetPlayerPublicServiceLicense(targetid, 0, true);
					licenseName = "sazogadoebrivi transportis martvis mowmoba";
				}
				case 3:
				{
					SetPlayerCommercialLicense(targetid, 0, true);
					licenseName = "komerciuli transportis martvis mowmoba";
				}
				case 4:
				{
					SetPlayerWaterTransportLicense(targetid, 0, true);
					licenseName = "sazgvao transportis martvis mowmoba";
				}
				case 5://pilots license
				{
					SetPlayerPilotLicense(targetid, 0, true);
					licenseName = "pilotis licenzia";
				}
				case 6://gun license
				{
					SetPlayerGunLicense(targetid, 0, true);
					licenseName = "iaragis licenzia";
				}
				case 7://businesis license
				{
					SetPlayerBusinessLicense(targetid, 0, true);
					licenseName = "biznesis licenzia";
				}
				default://all of the above
				{
					SetPlayerPassengerLicense(targetid, 0, false);
					SetPlayerMotorcycleLicense(targetid, 0, false);
					SetPlayerPublicServiceLicense(targetid, 0, false);
					SetPlayerCommercialLicense(targetid, 0, false);
					SetPlayerWaterTransportLicense(targetid, 0, false);
					SetPlayerPilotLicense(targetid, 0, false);
					SetPlayerGunLicense(targetid, 0, false);
					SetPlayerBusinessLicense(targetid, 0, false);
					licenseName = "yvela licenzia";

					new query[512];
					mysql_format(DB_GetHandler(), query, sizeof query, "\
					UPDATE `player_data` SET `passengerLicense` = '0', `pilotLicense` = '0', `gunLicense` = '0', `businessLicense` = '0', \
					`motorcycleLicense` = '0', `publicServiceLicense' = '0', `commercialLicense` = '0', `waterLicense` = '0' \
					WHERE `name` = '%e'", GetPlayerNameEx(targetid));
					mysql_tquery(DB_GetHandler(), query);
				}
			}
			format(playerText, sizeof playerText, "%s Administratorma %s wagartvat %s", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), licenseName);
			SendClientMessage(targetid, COLOUR_WHITE, playerText);

			format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] waartva %s %s[%d]-s.",\
				FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
				licenseName, GetPlayerNameEx(targetid), targetid);
			SendAdminMessage(adminMessage);
			return true;
		}
		return false;
	}
	new text[512];
	format(text, sizeof text, \
	"[1] Msubuqi avtomobilis martvis mowmoba \n\
	[2] Motocikletis martvis mowmoba \n\
	[3] Sazogadoebrivi transportis martvis mowmoba \n\
	[4] Komerciuli transportis martvis mowmoba \n\
	[5] Sazgvao transportis martvis mowmoba \n\
	[6] Pilotis Licenzia \n\
	[7] Iaragis licenzia \n\
	[8] Biznesis licenzia \n\
	[9] Yvela licenziis gacema \n\
	");
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Licenses", text, !">>", !"X");
	return true;
}
