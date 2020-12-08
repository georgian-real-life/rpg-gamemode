CMD:alogin(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0)
	{
		return false;
	}

	if (GetPlayerAdminAuthentication(playerid) == 1)
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Tqven agar gaqvt wvdoma administratoris brdzanebebtan.");
		SetPlayerAdminAuthentication(playerid, 0);
		return false;
	}

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT * FROM `administrators` WHERE `adminName` = '%e'", GetPlayerNameEx(playerid));
	new Cache:result = mysql_query(DB_GetHandler(), query, true);

	new tempPassword[33];
	cache_get_value_name(0, "adminPassword", tempPassword, 32);

	if (strlen(tempPassword) <= 5)
	{
		inline _response(playerID, dialogID, response, listitem, string:inputtext[])
		{
			#pragma unused dialogID, listitem, playerID

			if (!response || isnull(inputtext) || !(8 <= strlen(inputtext) <= 32))
			{
				return true;
			}
			mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `administrators` SET `adminPassword`= MD5('%s') WHERE `adminName` = '%s'", inputtext, GetPlayerNameEx(playerid));
			mysql_tquery(DB_GetHandler(), query);
		}
		new admin_login[256];
		format(admin_login, sizeof admin_login, "{FFFFFF} Gtxovt sheiyvanot tqventvis sasurveli administratoris paroli\n\
		- Paroli ar unda iyos {e64326}8 {ffffff}simboloze naklebi da ar unda agematebodes {e64326}24{ffffff}-s");
		Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_INPUT, !"{226db8} Administrator Password", admin_login, !">>", !"X");
		return true;
	}

	new bool:status;
	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, listitem, playerID

		if (!response || isnull(inputtext))
		{
			status = false;
			return true;
		}

		mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `adminPassword` FROM `administrators` WHERE `adminName` = '%s' AND `adminPassword` = MD5('%s')", GetPlayerNameEx(playerid), inputtext);
		new Cache:result2 = mysql_query(DB_GetHandler(), query, true);
		new rows;
		cache_get_row_count(rows);
		switch (rows)
		{
			case 0:		{ status = false; }
			default:	{ status = true; }
		}
		cache_delete(result2);

		new playerIP[16], lastQuery[256];
		GetPlayerIp(playerID, playerIP, 16);

		mysql_format(DB_GetHandler(), lastQuery, sizeof lastQuery, "INSERT INTO `administrator_logins`(`adminName`, `ip`, `status`, `date`) VALUES \
		('%s', '%s', '%s', NOW())", GetPlayerNameEx(playerID), playerIP, (status)? ("Successful") : ("Failure"));
		mysql_tquery(DB_GetHandler(), lastQuery);
		SetPlayerAdminAuthentication(playerID, status);

		if (status) { SendClientMessage(playerID, COLOUR_GREEN, "Tqven gaiaret administratoris avtorizacia"); }
		return true;
	}
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_PASSWORD, !"{226db8} Administrator Password", !"{FFFFFF} Gtxovt sheiyvanot administratoris paroli", !">>", !"X");

	cache_delete(result);
	return true;
}
