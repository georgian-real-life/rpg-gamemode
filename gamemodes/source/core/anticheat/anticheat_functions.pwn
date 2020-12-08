stock AC_KickPlayer(playerid, codeid)
{
	if (GetPlayerAdminLevel(playerid > 0))
	{
		return false;
	}

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage,"{DF1800}[ANTI-CHEAT] %s[%d] datova serveri cheatis gamoyenebis gamo. cheat code %d", GetPlayerNameEx(playerid), playerid, codeid);
	SendAdminMessage(adminMessage);

	new year, month, day, hour, minute, second, date[15];
	getdate(year,month,day);
	gettime(hour,minute,second);
	format(date, 15, "%02i/%02i/%02i", day, month, year);
	new text[512];
	format(text, sizeof text, \
	"{FFFFFF}Tqven Shegiwydat Servertan Kavshiri {DF1800}Cheat/Cleo {ffffff}Programebis Gamoyenebis Gamo\n\n\t\t\t\
	Gtoxvt daicvat serveris{F39C12} Wesebi {ffffff}\n\t\t\tGakikvis tarigi: {F39C12}%s - %d:%d:%d\n\t\t\t{FFFFFF}\
	Anticheat Code: {F39C12}%d\n\n\n{9e9e9a}Tu tqven tvlit rom araswori mizezis gamo shegiwydat servertan wvdoma - mimartet{F39C12} Administracias.",\
	date, hour, minute, second, codeid);

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused playerID, dialogID, response, listitem, inputtext
	}

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_MSGBOX, !"{DF1800} Anticheat", text, !"", !"X");
	KickPlayer(playerid);
	return 1;
}

stock AC_GetWeaponSlotByWeaponID(weaponID, &weaponslot)
{
	switch (weaponID)
	{
		case 0, 1:
		{
			weaponslot = 0;
		}

		case 2..9:
		{
			weaponslot = 1;
		}

		case 10..15:
		{
			weaponslot = 10;
		}

		case 16..18, 39:
		{
			weaponslot = 8;
		}

		case 22..24:
		{
			weaponslot = 2;
		}

		case 25..27:
		{
			weaponslot = 3;
		}

		case 28..30, 32:
		{
			weaponslot = 4;
		}

		case 31:
		{
			weaponslot = 5;
		}

		case 33..34:
		{
			weaponslot = 6;
		}

		case 35..38:
		{
			weaponslot = 7;
		}

		case 40:
		{
			weaponslot = 12;
		}

		case 41..43:
		{
			weaponslot = 9;
		}

		case 44..46:
		{
			weaponslot = 11;
		}

		default:
		{
			weaponslot = 0xFF;
		}

	}
	return;
}

stock AC_IsWeaponAllowed(weaponid)
{
	switch (weaponid)
	{
		case 10..13, 16, 18, 26..28, 32, 35, 36, 38, 39, 44, 45:
		{
			return false;
		}
		default:
		{
			return true;
		}
	}
	return true;
}
