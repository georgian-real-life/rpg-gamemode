#include	<YSI_Coding\y_hooks>

forward CharacterRegistrationRequest(const playerid);
forward OnPlayerCreateCharacter(const playerid);

new Text:characterTextDraws[3];

static
	gRegStartupPlayerLevel,
	gRegStartupPlayerLevelExp,
	gRegStartupPlayerCash;

hook OnGameModeInit()
{
	CreateCharacterTextDraws();

	SetRegPlayerStartupLevel(1);
	SetRegPlayerStartupLevelExp(1);
	SetRegPlayerStartupCash(5_000);
	return 1;
}

public	CharacterRegistrationRequest(const playerid)
{
	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, inputtext

		if (!response)
		{
			CallLocalFunction("CharacterRegistrationRequest", "i", playerid);
			return 1;
		}

		SetPlayerGender(playerID, listitem);

		AccSetup_SetCharacterIndex(playerID, -1);

		SetPlayerSpawnSkin(playerID, GetCharacterNextSkin(playerID), true);

		SetPlayerSpawnCoords(playerID, 215.3013, -127.6407, 1003.5078, 146.6923);

		TogglePlayerSpectating(playerID, 0);

		SetPlayerSpawnVirtualWorld(playerid, playerid+1, true);
		SetPlayerSpawnInteriorID(playerID, 3, true);

		SetPlayerCameraPos(playerID, 211.6167, -134.3078, 1005.0136);
		SetPlayerCameraLookAt(playerID, 212.0948, -133.4310, 1004.8007);

		ShowPlayerCharacterCreationTDs(playerID);
		SelectTextDraw(playerID, 0x00FF00FF);

		//TogglePlayerControllable(playerID, 0);
		return 1;
	}

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Sqesi", \
		!"Mamrobiti\nMdedrobiti", !"Shemdeg", !"");
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if (IsPlayerRegistering(playerid))
	{
		if (clickedid == characterTextDraws[0])
		{
			AccSetup_DeleteConnTimer(playerid);

			new spawnRandom = random(2);
			new Float:spawnPositions[4];
			GetRegistrationSpawnData(spawnRandom, spawnPositions[0], spawnPositions[1], spawnPositions[2], spawnPositions[3]);

			SetPlayerSpawnSkin(playerid, GetPlayerSkin(playerid), true);

			SetPlayerSpawnCoords(playerid, spawnPositions[0], spawnPositions[1], spawnPositions[2], spawnPositions[3]);
			SetPlayerSpawnVirtualWorld(playerid, 0);
			SetPlayerSpawnInteriorID(playerid, 0);

			SetPlayerConnectionState(playerid, "Registered");

			new query[512];
			mysql_format(DB_GetHandler(), query, sizeof query, \
			"INSERT INTO `player_data`(`name`, `gender`, `skin`, `level`, `level_exp`, `cash`, `spawn_pos_x`, `spawn_pos_y`, `spawn_pos_z`, `spawn_pos_angle`, `spawn_virtualworld`, `spawn_interiorid`) \
				VALUES ('%s', '%d', '%d', '%d', '%d', '%d', '%f', '%f', '%f', '%f', '%d', '%d')", \
				GetPlayerNameEx(playerid), GetPlayerGender(playerid), GetPlayerSpawnSkin(playerid), GetRegPlayerStartupLevel(), GetRegPlayerStartupLevelExp(), GetRegPlayerStartupCash(), \
				spawnPositions[0], spawnPositions[1], \
				spawnPositions[2], spawnPositions[3], GetPlayerSpawnVirtualWorld(playerid), GetPlayerSpawnInteriorID(playerid));
			mysql_tquery(DB_GetHandler(), query, "OnPlayerCreateCharacter", "i", playerid);

			mysql_format(DB_GetHandler(), query, sizeof query,\
			"INSERT INTO `player_restrictions` (`playerName`, `muteTime`, `jailTime`)\
			VALUES ('%s', '%d', '%d')", GetPlayerNameEx(playerid), 0, 0);
			mysql_tquery(DB_GetHandler(), query);

			HidePlayerCharacterCreationTDs(playerid);
			CancelSelectTextDraw(playerid);

			TogglePlayerSpectating(playerid, 1);
			GameTextForPlayer(playerid, "Loading...", 3000, 6);
		}
		else if (clickedid == characterTextDraws[1])
		{
			SetPlayerSkin(playerid, GetCharacterNextSkin(playerid));
		}

		else if (clickedid == characterTextDraws[2])
		{
			SetPlayerSkin(playerid, GetCharacterPrevSkin(playerid));
		}
		return 1;
	}
	return 1;
}

public OnPlayerCreateCharacter(const playerid)
{
	CallRemoteFunction("AuthorizePlayer", "i", playerid);
	return 1;
}

stock CreateCharacterTextDraws()
{
	characterTextDraws[0] = TextDrawCreate(295.000000, 370.000000, "SELECT");
	TextDrawFont(characterTextDraws[0], 1);
	TextDrawLetterSize(characterTextDraws[0], 0.600000, 2.000000);
	TextDrawTextSize(characterTextDraws[0], 362.500000, 17.000000);
	TextDrawSetOutline(characterTextDraws[0], 1);
	TextDrawSetShadow(characterTextDraws[0], 0);
	TextDrawAlignment(characterTextDraws[0], 1);
	TextDrawColor(characterTextDraws[0], -1);
	TextDrawBackgroundColor(characterTextDraws[0], 255);
	TextDrawBoxColor(characterTextDraws[0], 0);
	TextDrawUseBox(characterTextDraws[0], 1);
	TextDrawSetProportional(characterTextDraws[0], 1);
	TextDrawSetSelectable(characterTextDraws[0], 1);

	characterTextDraws[1] = TextDrawCreate(274.000000, 370.000000, "<");
	TextDrawFont(characterTextDraws[1], 1);
	TextDrawLetterSize(characterTextDraws[1], 0.600000, 2.000000);
	TextDrawTextSize(characterTextDraws[1], 287.500000, 17.000000);
	TextDrawSetOutline(characterTextDraws[1], 1);
	TextDrawSetShadow(characterTextDraws[1], 0);
	TextDrawAlignment(characterTextDraws[1], 1);
	TextDrawColor(characterTextDraws[1], -1);
	TextDrawBackgroundColor(characterTextDraws[1], 255);
	TextDrawBoxColor(characterTextDraws[1], 0);
	TextDrawUseBox(characterTextDraws[1], 1);
	TextDrawSetProportional(characterTextDraws[1], 1);
	TextDrawSetSelectable(characterTextDraws[1], 1);

	characterTextDraws[2] = TextDrawCreate(370.000000, 370.000000, ">");
	TextDrawFont(characterTextDraws[2], 3);
	TextDrawLetterSize(characterTextDraws[2], 0.600000, 2.000000);
	TextDrawTextSize(characterTextDraws[2], 381.500000, 17.000000);
	TextDrawSetOutline(characterTextDraws[2], 1);
	TextDrawSetShadow(characterTextDraws[2], 0);
	TextDrawAlignment(characterTextDraws[2], 1);
	TextDrawColor(characterTextDraws[2], -1);
	TextDrawBackgroundColor(characterTextDraws[2], 255);
	TextDrawBoxColor(characterTextDraws[2], 0);
	TextDrawUseBox(characterTextDraws[2], 1);
	TextDrawSetProportional(characterTextDraws[2], 1);
	TextDrawSetSelectable(characterTextDraws[2], 1);

	return 1;
}

stock SetRegPlayerStartupLevel(startupLevel)
{
	gRegStartupPlayerLevel = startupLevel;
	return true;
}

stock GetRegPlayerStartupLevel()
{
	return gRegStartupPlayerLevel;
}

stock SetRegPlayerStartupLevelExp(startupExp)
{
	gRegStartupPlayerLevelExp = startupExp;
	return true;
}

stock GetRegPlayerStartupLevelExp()
{
	return gRegStartupPlayerLevelExp;
}

stock SetRegPlayerStartupCash(startupCash)
{
	gRegStartupPlayerCash = startupCash;
}

stock GetRegPlayerStartupCash()
{
	return gRegStartupPlayerCash;
}

stock ShowPlayerCharacterCreationTDs(const playerid)
{
	for (new x = 0; x < sizeof characterTextDraws; x++)
	{
		TextDrawShowForPlayer(playerid, characterTextDraws[x]);
	}
	return 1;
}

stock HidePlayerCharacterCreationTDs(const playerid)
{
	for (new x = 0; x < sizeof characterTextDraws; x++)
	{
		TextDrawHideForPlayer(playerid, characterTextDraws[x]);
	}
	return 1;
}
