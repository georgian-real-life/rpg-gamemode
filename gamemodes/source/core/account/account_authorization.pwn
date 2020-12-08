forward AccountAuthorizationRequest(playerid);

forward AccountAuthorizationVerifyPass(playerid, bool:success);

forward CheckPlayerAuthPassword(playerid);

forward CheckCharacterAvailability(playerid);


static tempHash[MAX_PLAYERS][BCRYPT_HASH_LENGTH];


public AccountAuthorizationRequest(playerid)
{
	ShowPlayerAuthorizationDialog(playerid);

	new Cache:cache, rows, query[128];
	mysql_format(DB_GetHandler(), query, sizeof(query), "SELECT `password` FROM `accounts` WHERE `name` = '%e'", GetPlayerNameEx(playerid));
	cache = mysql_query(DB_GetHandler(), query, true);

	cache_get_row_count(rows);
	if (rows > 0)
	{
		cache_get_value_name(0, "password", tempHash[playerid], BCRYPT_HASH_LENGTH);
	}

	cache_delete(cache);

	return 1;
}

stock ShowPlayerAuthorizationDialog(playerid)
{
	new authorization_text[510];
	format(authorization_text, sizeof authorization_text, "{FFFFFF}Mogesalmebit chvens serverze\n\n{226db8}'%s' {FFFFFF}- Accounti am saxelit ukve registrirebulia\n \
	Tu tqven xart am accountis mflobeli, chaweret paroli qvemot mocemul grafashi\n\nSxva shemtxvevashi gtxovt datovot serveri an gaiarot avtorizacia tqveni angarishit \
	", GetPlayerNameEx(playerid));

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, listitem

		if (!response)
		{
			ShowPlayerAuthorizationDialog(playerID);
			return 1;
		}

		if (isnull(inputtext))
		{
			ShowPlayerAuthorizationDialog(playerID);
			SendClientMessage(playerID, COLOUR_LIGHT_ERROR, !"Parolis grafa carielia!");
			return 1;
		}

		bcrypt_verify(playerID, "AccountAuthorizationVerifyPass", inputtext, tempHash[playerID]);
	}

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_PASSWORD, !"{226db8} Authorization", authorization_text, !">>", !"Options");
	return 1;
}

public AccountAuthorizationVerifyPass(playerid, bool:success)
{
	if (!success)
	{
		new incorrectPasswordCount = AccSetup_GetIncorrectPassCount(playerid);
		if (incorrectPasswordCount >= AccSetup_GetMaxPasswordTries())
		{
			SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Paroli arasworia, gtxovt scadot xelaxla.");
			AccSetup_SetIncorrectPassCount(playerid, 0);
			KickPlayer(playerid);
			return false;
		}
		ShowPlayerAuthorizationDialog(playerid);
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Paroli arasworia, gtxovt scadot xelaxla.");
		AccSetup_SetIncorrectPassCount(playerid, (incorrectPasswordCount + 1));
		return false;
	}

	new query[128];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT * FROM `player_data` WHERE `name` = '%e'", GetPlayerNameEx(playerid));
	mysql_tquery(DB_GetHandler(), query, "CheckCharacterAvailability", "i", playerid);
	return true;
}

public CheckCharacterAvailability(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if (rows > 0)
	{
		CallRemoteFunction("AuthorizePlayer", "i", playerid);
		return 1;
	}

	SetPlayerConnectionState(playerid, "Registering");

	AccSetup_SetPlayerConnTime(playerid, AccSetup_GetRegistrationTime());
	CallRemoteFunction("CharacterRegistrationRequest", "i", playerid);
	SendClientMessage(playerid, COLOUR_INFORMATION, !"Tqven angarishze personaji ar fiqsirdeba, gtxovt sheqmnat personaji.");
	return 1;
}
