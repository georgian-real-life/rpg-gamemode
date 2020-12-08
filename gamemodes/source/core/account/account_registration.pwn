forward AccountRegistrationRequest(playerid);
forward AccountRegistrationPasswordHash(playerid);


static playerTempPassword[MAX_PLAYERS][BCRYPT_HASH_LENGTH];


public AccountRegistrationRequest(playerid)
{
	ShowPlayerRegistrationDialog(playerid);
	return 1;
}

stock ShowPlayerRegistrationDialog(playerid)
{
	new registration_text[510];
	format(registration_text, sizeof registration_text, "{226db8}%s {ffffff}mogesalmebit chvens serverze.\nMocemuli accounti ar aris registrirebuli.\n\
	Serverze satamashod aucilebelia registraciis gavla.\n\n\
	{e64326}Gaitvaliswinet shemdegi wesebi accountis sheqmnastan dakavshirebit:{ffffff}\n\n\
	- Paroli aucileblad unda shedgebodes {e64326}latinuri {ffffff}simboloebisgan an/da {e64326}cifrebisgan{ffffff}\n\
	- Paroli ar unda iyos {e64326}8 {ffffff}simboloze naklebi da ar unda agematebodes {e64326}32{ffffff}-s", GetPlayerNameEx(playerid));

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, listitem

		if (!response)
		{
			ShowPlayerRegistrationDialog(playerID);
			return 1;
		}

		if (isnull(inputtext))
		{
			ShowPlayerRegistrationDialog(playerID);
			SendClientMessage(playerID, COLOUR_LIGHT_ERROR, !"Parolis grafa carielia, gtxovt gadaikitxot wesebi.");
			return 1;
		}

		if (!(8 <= strlen(inputtext) <= 32))
		{
			ShowPlayerRegistrationDialog(playerID);
			SendClientMessage(playerID, COLOUR_LIGHT_ERROR, !"Gtxovt gadaikitxot parolis sheyvanis wesebi");
			return 1;
		}

		new Regex:rg_passwordcheck = Regex_New("^[a-zA-Z0-9]{1,}$");

		if (!Regex_Check(inputtext, rg_passwordcheck))
		{
			ShowPlayerRegistrationDialog(playerID);
			Regex_Delete(rg_passwordcheck);
			return 1;
		}

		Regex_Delete(rg_passwordcheck);

		playerTempPassword[playerID][0] = EOS;

		strcat(playerTempPassword[playerID], inputtext);
		ShowPlayerPasswordRepeatDialog(playerID);
	}
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_PASSWORD, !"{226db8} Registration [Password table]", registration_text, !">>", !"Options");
	return 1;
}

stock ShowPlayerPasswordRepeatDialog(playerid)
{
	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, listitem

		if (!response)
		{
			ShowPlayerRegistrationDialog(playerID);
			return false;
		}

		if (isnull(inputtext))
		{
			ShowPlayerPasswordRepeatDialog(playerID);
			SendClientMessage(playerID, COLOUR_LIGHT_ERROR, !"Grafa carielia");
			return false;
		}

		if (strcmp(inputtext, playerTempPassword[playerID], false))
		{
			ShowPlayerPasswordRepeatDialog(playerID);
			SendClientMessage(playerID, COLOUR_LIGHT_ERROR, !"Parolebi ar emtxveva ertmanets");
			return false;
		}

		bcrypt_hash(playerID, "AccountRegistrationPasswordHash", inputtext, BCRYPT_HASH_COST);
		return true;
	}
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_PASSWORD, !"{226db8} Registration [Password table]",\
		!"Gtxovt gaimeorot paroli\nSxva parolis misatiteblad daachiret gilak '<<'-s", !">>", !"<<");
	return true;
}

public AccountRegistrationPasswordHash(playerid)
{
	new dest[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(dest);

	playerTempPassword[playerid][0] = EOS;
	strcat(playerTempPassword[playerid], dest, BCRYPT_HASH_LENGTH);

	PlayerFinishedAccountReg(playerid);
	return true;
}

stock PlayerFinishedAccountReg(playerid)
{
	new playerip[16], reg_db_query[1024];
	GetPlayerIp(playerid, playerip, sizeof (playerip));

	new szSerial[41];
	gpci(playerid, szSerial, sizeof(szSerial));

	mysql_format(DB_GetHandler(), reg_db_query, sizeof(reg_db_query), "INSERT INTO `accounts` \
	(`name`, `password`, `gpci`, `regip`, `regdate`, `regtime`) VALUES \
	('%s', '%s', '%s', '%s', NOW(), NOW())",
	GetPlayerNameEx(playerid), playerTempPassword[playerid], szSerial, playerip);
	mysql_tquery(DB_GetHandler(), reg_db_query, "CharacterRegistrationRequest", "i", playerid);
	return 1;
}
