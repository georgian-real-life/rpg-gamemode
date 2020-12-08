#include	<YSI_Coding\y_hooks>


static
	gRegistrationTime,
	gAuthorizationTime,
	gRegistrationStartupLevel,
	gRegistrationStartupLevelExp,
	gRegistrationStartupCash,
	gMaxPasswordTriesAllowed,
	gPlayerConnectionTime[MAX_PLAYERS],
	gPlayerConnectionTimer[MAX_PLAYERS],
	gPlayerIncorrectPassword[MAX_PLAYERS],
	gPlayerCharacterCreationIndex[MAX_PLAYERS];

static gPlayerRegistrationSkinIDs[2][8] =
{
	{2, 3, 4, 5, 7, 15, 20, 66}, //male
	{12, 13, 41, 55, 56, 65, 90, 131}// female
};

static Float:sPlayerRegistrationSpawns[3][4] =
{
	{1685.7206, -2240.8130, 13.5469, 180.2944},
	{1689.6459, -2242.3328, 13.5396, 180.2944},
	{1640.2815, -2240.6340, 13.4974, 180.2944}
};


hook OnGameModeInit()
{
	AccSetup_SetAuthorizationTime(180);
	AccSetup_SetRegistrationTime(180);
	AccSetup_SetMaxPasswordTries(3);
	return 1;
}


stock AccSetup_SetRegistrationTime(timeInSeconds)
{
	gRegistrationTime = timeInSeconds;
	return;
}

stock AccSetup_GetRegistrationTime()
{
	return gRegistrationTime;
}

stock AccSetup_SetStartupLevel(startupLevel)
{
	return gRegistrationStartupLevel = startupLevel;
}

stock AccSetup_GetStartupLevel()
{
	return gRegistrationStartupLevel;
}

stock AccSetup_SetStartupLevelExp(startupLevelExp)
{
	gRegistrationStartupLevelExp = startupLevelExp;
}

stock AccSetup_GetStartupLevelExp()
{
	return gRegistrationStartupLevelExp;
}

stock AccSetup_SetStartupCash(startupCash)
{
	gRegistrationStartupCash = startupCash;
}

stock AccSetup_GetStartupCash()
{
	return gRegistrationStartupCash;
}

stock AccSetup_SetAuthorizationTime(timeInSeconds)
{
	gAuthorizationTime = timeInSeconds;
}

stock AccSetup_GetAuthorizationTime()
{
	return gAuthorizationTime;
}

stock AccSetup_SetMaxPasswordTries(passwordTries)
{
	gMaxPasswordTriesAllowed = passwordTries;
}

stock AccSetup_GetMaxPasswordTries()
{
	return gMaxPasswordTriesAllowed;
}

stock AccSetup_SetPlayerConnTime(playerid, timeInSeconds)
{
	gPlayerConnectionTime[playerid] = timeInSeconds;
}

stock AccSetup_GetPlayerConnTime(playerid)
{
	return gPlayerConnectionTime[playerid];
}

stock AccSetup_SetUpConnTimer(playerid)
{
	gPlayerConnectionTimer[playerid] = SetPreciseTimer("TimerUpdatePlayerConnectionTime", 1000, true, "i", playerid);
}

stock AccSetup_DeleteConnTimer(playerid)
{
	DeletePreciseTimer(gPlayerConnectionTimer[playerid]);
}

stock AccSetup_SetIncorrectPassCount(playerid, count)
{
	gPlayerIncorrectPassword[playerid] = count;
}

stock AccSetup_GetIncorrectPassCount(playerid)
{
	return gPlayerIncorrectPassword[playerid];
}

stock AccSetup_SetCharacterIndex(playerid, value)
{
	gPlayerCharacterCreationIndex[playerid] = value;
}

stock AccSetup_GetCharacterIndex(playerid)
{
	return gPlayerCharacterCreationIndex[playerid];
}

stock GetCharacterNextSkin(const playerid)
{
	gPlayerCharacterCreationIndex[playerid]++;
	if (gPlayerCharacterCreationIndex[playerid] > sizeof(gPlayerRegistrationSkinIDs[]) - 1)
	{
		gPlayerCharacterCreationIndex[playerid] = 0;
	}
	return gPlayerRegistrationSkinIDs[GetPlayerGender(playerid)][gPlayerCharacterCreationIndex[playerid]];
}

stock GetCharacterPrevSkin(const playerid)
{
	gPlayerCharacterCreationIndex[playerid]--;
	if (gPlayerCharacterCreationIndex[playerid] < 0)
	{
		gPlayerCharacterCreationIndex[playerid] = sizeof(gPlayerRegistrationSkinIDs[]) - 1;
	}
	return gPlayerRegistrationSkinIDs[GetPlayerGender(playerid)][gPlayerCharacterCreationIndex[playerid]];
}

stock GetRegistrationSpawnData(index, &Float:spawnX, &Float:spawnY, &Float:spawnZ, &Float:spawnAngle)
{
	spawnX = sPlayerRegistrationSpawns[index][0];
	spawnY = sPlayerRegistrationSpawns[index][1];
	spawnZ = sPlayerRegistrationSpawns[index][2];
	spawnAngle = sPlayerRegistrationSpawns[index][3];
}
