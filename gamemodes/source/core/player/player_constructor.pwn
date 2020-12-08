enum _:E_CONNECTION_STATES
{
	E_CONNECTION_STATUS_NONE,
	E_CONNECTION_STATE_CONNECTING,
	E_CONNECTION_STATE_REGISTERING,
	E_CONNECTION_STATE_AUTHORIZING,
	E_CONNECTION_STATE_REGISTERED, //Only assigned when player creates a new account
	E_CONNECTION_STATE_AUTHORIZED
};

enum _:E_DONATOR_RANKS
{
	E_DONATOR_RANK_NONE,
	E_DONATOR_RANK_BRONZE,
	E_DONATOR_RANK_SILVER,
	E_DONATOR_RANK_GOLD,
	E_DONATOR_RANK_PLATINUM,
	E_DONATOR_RANK_DIAMOND
};


static
		gPlayerConnectionState[MAX_PLAYERS],
		gPlayerName[MAX_PLAYERS][MAX_PLAYER_NAME],
		gPlayerGender[MAX_PLAYERS],
		gPlayerLevel[MAX_PLAYERS],
		gPlayerLevelExp[MAX_PLAYERS],
		gPlayerLevelExpPoint[MAX_PLAYERS],
		gPlayerDonatorRank[MAX_PLAYERS],
		gPlayerCash[MAX_PLAYERS],
		gPlayerBankCash[MAX_PLAYERS],
		gPlayerPayCheck[MAX_PLAYERS],
		gPlayerPassengerVehicleLicense[MAX_PLAYERS],
		gPlayerMotorcycleLicense[MAX_PLAYERS],
		gPlayerPublicServiceLicense[MAX_PLAYERS],
		gPlayerCommercialLicense[MAX_PLAYERS],
		gPlayerWaterTransportLicense[MAX_PLAYERS],
		gPlayerPilotLicense[MAX_PLAYERS],
		gPlayerGunLicense[MAX_PLAYERS],
		gPlayerBusinessLicense[MAX_PLAYERS],

		gPlayerPayDayTime[MAX_PLAYERS],

		gPlayerWeaponSkillPistol[MAX_PLAYERS],
		gPlayerWeaponSkillSilenced[MAX_PLAYERS],
		gPlayerWeaponSkillDesertEagle[MAX_PLAYERS],
		gPlayerWeaponSkillShotgun[MAX_PLAYERS],
		gPlayerWeaponSkillSawnOff[MAX_PLAYERS],
		gPlayerWeaponSkillSPAZ12[MAX_PLAYERS],
		gPlayerWeaponSkillMicroUzi[MAX_PLAYERS],
		gPlayerWeaponSkillMP5[MAX_PLAYERS],
		gPlayerWeaponSkillAK47[MAX_PLAYERS],
		gPlayerWeaponSkillM4[MAX_PLAYERS],
		gPlayerWeaponSkillSniperRifle[MAX_PLAYERS],


Float:	gPlayerSpawnInfoX[MAX_PLAYERS],
Float:	gPlayerSpawnInfoY[MAX_PLAYERS],
Float:	gPlayerSpawnInfoZ[MAX_PLAYERS],
Float:	gPlayerSpawnInfoAng[MAX_PLAYERS],
		gPlayerSpawnInfoSkinID[MAX_PLAYERS],
		gPlayerSpawnInfoVirtualWorld[MAX_PLAYERS],
		gPlayerSpawnInfoInteriorid[MAX_PLAYERS];


stock SetPlayerConnectionState(playerid, const status[])
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	if(!strcmp(status, "none", true))
	{
		gPlayerConnectionState[playerid] = E_CONNECTION_STATUS_NONE;
		return true;
	}
	else if(!strcmp(status, "connecting", true))
	{
		gPlayerConnectionState[playerid] = E_CONNECTION_STATE_CONNECTING;
		return true;
	}
	else if(!strcmp(status, "registering", true))
	{
		gPlayerConnectionState[playerid] = E_CONNECTION_STATE_REGISTERING;
		return true;
	}
	else if(!strcmp(status, "authorizing", true))
	{
		gPlayerConnectionState[playerid] = E_CONNECTION_STATE_AUTHORIZING;
		return true;
	}
	else if(!strcmp(status, "registered", true))
	{
		gPlayerConnectionState[playerid] = E_CONNECTION_STATE_REGISTERED;
		return true;
	}
	else if(!strcmp(status, "authorized", true))
	{
		gPlayerConnectionState[playerid] = E_CONNECTION_STATE_AUTHORIZED;
		return true;
	}

	return false;
}

stock GetPlayerConnectionStateID(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	return gPlayerConnectionState[playerid];
}

stock GetPlayerConnectionStateName(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	switch (gPlayerConnectionState[playerid])
	{
		case E_CONNECTION_STATUS_NONE:
		{
			return "None";
		}

		case E_CONNECTION_STATE_CONNECTING:
		{
			return "Connecting";
		}

		case E_CONNECTION_STATE_REGISTERING:
		{
			return "Registering";
		}

		case E_CONNECTION_STATE_AUTHORIZING:
		{
			return "Authorizing";
		}

		case E_CONNECTION_STATE_REGISTERED:
		{
			return "Registered";
		}

		case E_CONNECTION_STATE_AUTHORIZED:
		{
			return "Authorized";
		}
	}
}

stock IsPlayerAuthorized(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	if (gPlayerConnectionState[playerid] == E_CONNECTION_STATE_AUTHORIZED)
	{
		return true;
	}

	return false;
}

stock IsPlayerRegistering(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	if (gPlayerConnectionState[playerid] == E_CONNECTION_STATE_REGISTERING)
	{
		return true;
	}

	return false;
}

stock IsPlayerRegistered(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	if (gPlayerConnectionState[playerid] == E_CONNECTION_STATE_REGISTERED)
	{
		return true;
	}

	return false;
}

stock GetPlayerNameEx(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		new text[MAX_PLAYER_NAME];
		text = "Invalid Player ID";
		return text;
	}

	return gPlayerName[playerid];
}

stock SetPlayerNameEx(playerid, const name[])
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	SetPlayerName(playerid, "INVALID_NAME");

	gPlayerName[playerid][0] = EOS;
	strcat(gPlayerName[playerid], name, MAX_PLAYER_NAME);
	SetPlayerName(playerid, gPlayerName[playerid]);
	return true;
}

stock SetPlayerGender(playerid, gender, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerGender[playerid] = gender;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `gender` = '%d' WHERE `name` = '%e'", gPlayerGender[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerGender(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	return gPlayerGender[playerid];
}

stock GetPlayerGenderName(playerid)
{
	new genderName[32];
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		genderName = "INVALID_PLAYER_ID";
		return genderName;
	}

	new gender = GetPlayerGender(playerid);
	switch (gender)
	{
		case 0:
		{
			genderName = "Mamrobiti";
		}

		case 1:
		{
			genderName = "Mdedrobiti";
		}

		default:
		{
			genderName = "DAUDGENELI_SQESI";
		}
	}

	return genderName;
}

stock SetPlayerLevel(playerid, level, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerLevel[playerid] = level;
	SetPlayerScore(playerid, level);

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `level` = '%d' WHERE `name` = '%e'", level, GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerLevel(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	return gPlayerLevel[playerid];
}

stock SetPlayerLevelExp(playerid, exp, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	gPlayerLevelExp[playerid] = exp;
	UpdatePlayerLevelStatistics(playerid);

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `level_exp` = '%d' WHERE `name` = '%e'", gPlayerLevelExp[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}

	return true;
}

stock GetPlayerLevelExp(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	return gPlayerLevelExp[playerid];
}

stock SetPlayerLevelExpPoint(playerid, exp, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	gPlayerLevelExpPoint[playerid] = exp;
	UpdatePlayerLevelStatistics(playerid);

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `level_expPoint` = '%d' WHERE `name` = '%e'", gPlayerLevelExpPoint[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}

	return true;
}

stock GetPlayerLevelExpPoint(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	return gPlayerLevelExpPoint[playerid];
}

stock SetPlayerDonatorRank(playerid, donatorRank, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	if (donatorRank > E_DONATOR_RANK_DIAMOND)
	{
		donatorRank = E_DONATOR_RANK_DIAMOND;
	}
	else if (donatorRank < E_DONATOR_RANK_NONE)
	{
		donatorRank = E_DONATOR_RANK_NONE;
	}

	gPlayerDonatorRank[playerid] = donatorRank;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `donatorRank` = '%d' WHERE `name` = '%e'", gPlayerDonatorRank[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}

	return true;
}

stock GetPlayerDonatorRank(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	return gPlayerDonatorRank[playerid];
}

stock GetPlayerDonatorRankName(playerid, donatorRankName[])
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	switch (gPlayerDonatorRank[playerid])
	{
		case E_DONATOR_RANK_NONE:
		{
			donatorRankName = "None";
		}
		case E_DONATOR_RANK_BRONZE:
		{
			donatorRankName = "Bronze";
		}
		case E_DONATOR_RANK_SILVER:
		{
			donatorRankName = "Silver";
		}
		case E_DONATOR_RANK_GOLD:
		{
			donatorRankName = "Gold";
		}
		case E_DONATOR_RANK_PLATINUM:
		{
			donatorRankName = "Platinum";
		}
		case E_DONATOR_RANK_DIAMOND:
		{
			donatorRankName = "Diamond";
		}
		default:
		{
			donatorRankName = "None";
		}
	}
	return true;
}

stock SetPlayerCash(playerid, amount, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerCash[playerid] = amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, gPlayerCash[playerid]);

	if (updateDatabase)
	{
		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `cash` = '%d' WHERE `name` = '%e'", gPlayerCash[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerCash(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerCash[playerid];
}

stock SetPlayerBankCash(playerid, amount, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerBankCash[playerid] = amount;

	if (updateDatabase)
	{
		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `bankCash` = '%d' WHERE `name` = '%e'", gPlayerBankCash[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerBankCash(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerBankCash[playerid];
}

stock SetPlayerPaycheck(playerid, amount, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerPayCheck[playerid] = amount;

	if (updateDatabase)
	{
		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `paycheck` = '%d' WHERE `name` = '%e'", gPlayerPayCheck[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerPaycheck(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerPayCheck[playerid];
}

stock SetPlayerPassengerLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerPassengerVehicleLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `passengerLicense` = '%d' WHERE `name` = '%e'", gPlayerPassengerVehicleLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerPassengerLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerPassengerVehicleLicense[playerid];
}

stock SetPlayerMotorcycleLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerMotorcycleLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `motorcycleLicense` = '%d' WHERE `name` = '%e'", gPlayerMotorcycleLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerMotorcycleLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerMotorcycleLicense[playerid];
}

stock SetPlayerPublicServiceLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerPublicServiceLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `publicServiceLicense` = '%d' WHERE `name` = '%e'", gPlayerPublicServiceLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerPublicServiceLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerPublicServiceLicense[playerid];
}

stock SetPlayerCommercialLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerCommercialLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `commercialLicense` = '%d' WHERE `name` = '%e'", gPlayerCommercialLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerCommercialLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerCommercialLicense[playerid];
}

stock SetPlayerWaterTransportLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerWaterTransportLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `waterLicense` = '%d' WHERE `name` = '%e'", gPlayerWaterTransportLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerWaterTransportLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerWaterTransportLicense[playerid];
}

stock SetPlayerPilotLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerPilotLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `pilotLicense` = '%d' WHERE `name` = '%e'", gPlayerPilotLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerPilotLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerPilotLicense[playerid];
}

stock SetPlayerGunLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerGunLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `gunLicense` = '%d' WHERE `name` = '%e'", gPlayerGunLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerGunLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerGunLicense[playerid];
}

stock SetPlayerBusinessLicense(playerid, value, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerBusinessLicense[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `businessLicense` = '%d' WHERE `name` = '%e'", gPlayerBusinessLicense[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerBusinessLicense(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerBusinessLicense[playerid];
}

stock SetPlayerPayDayTime(playerid, value, updateDatabase)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	gPlayerPayDayTime[playerid] = value;

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `paydayTime` = '%d' WHERE `name` = '%e'", gPlayerPayDayTime[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
	return true;
}

stock GetPlayerPayDayTime(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	return gPlayerPayDayTime[playerid];
}

stock SetPlayerSpawnCoords(playerid, Float:posX, Float:posY, Float:posZ, Float:posAngle, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerSpawnInfoX[playerid] = posX;
	gPlayerSpawnInfoY[playerid] = posY;
	gPlayerSpawnInfoZ[playerid] = posZ;
	gPlayerSpawnInfoAng[playerid] = posAngle;
	UpdatePlayerSpawnInfo(playerid);

	if (updateDatabase)
	{
		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `player_data` SET `spawn_pos_x` = '%f', `spawn_pos_y` = '%f', `spawn_pos_z` = '%f', `spawn_pos_angle` = '%f' WHERE `name` = '%e'",\
		gPlayerSpawnInfoX[playerid], gPlayerSpawnInfoY[playerid], gPlayerSpawnInfoZ[playerid], gPlayerSpawnInfoAng[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock UpdatePlayerSpawnInfo(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	SetSpawnInfo(playerid, NO_TEAM, GetPlayerSpawnSkin(playerid), gPlayerSpawnInfoX[playerid], gPlayerSpawnInfoY[playerid], gPlayerSpawnInfoZ[playerid], gPlayerSpawnInfoAng[playerid], 0, 0, 0, 0, 0, 0);
}

stock GetPlayerSpawnInfo(playerid, &playerSkin, &Float:spawnX, &Float:spawnY, &Float:spawnZ, &Float:spawnAngle)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	&playerSkin = gPlayerSpawnInfoSkinID[playerid];
	&spawnX = gPlayerSpawnInfoX[playerid];
	&spawnY = gPlayerSpawnInfoY[playerid];
	&spawnZ = gPlayerSpawnInfoZ[playerid];
	&spawnAngle = gPlayerSpawnInfoAng[playerid];
}

stock GetPlayerSpawnFacingAngle(playerid, &Float:angle)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	angle = gPlayerSpawnInfoAng[playerid];
}

stock SetPlayerSpawnSkin(playerid, skinid, setSkin = false, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}
	gPlayerSpawnInfoSkinID[playerid] = skinid;

	if (setSkin)
	{
		SetPlayerSkin(playerid, gPlayerSpawnInfoSkinID[playerid]);
	}

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `skin` = '%d' WHERE `name` = '%e'", gPlayerSpawnInfoSkinID[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerSpawnSkin(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	return gPlayerSpawnInfoSkinID[playerid];
}

stock SetPlayerSpawnVirtualWorld(playerid, worldid, bool:setWorld = false, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}
	gPlayerSpawnInfoVirtualWorld[playerid] = worldid;

	if (setWorld)
	{
		AC_SetPlayerVirtualWorld(playerid, gPlayerSpawnInfoVirtualWorld[playerid], setWorld);
	}

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `spawn_virtualworld` = '%d' WHERE `name` = '%e'", gPlayerSpawnInfoVirtualWorld[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerSpawnVirtualWorld(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	return gPlayerSpawnInfoVirtualWorld[playerid];
}

stock SetPlayerSpawnInteriorID(playerid, interiorid, bool:setInterior = false, updateDatabase = false)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	gPlayerSpawnInfoInteriorid[playerid] = interiorid;

	if (setInterior)
	{
		AC_SetPlayerInteriorID(playerid, gPlayerSpawnInfoInteriorid[playerid], setInterior);
	}

	if (updateDatabase)
	{
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `player_data` SET `spawn_interiorid` = '%d' WHERE `name` = '%e'", gPlayerSpawnInfoInteriorid[playerid], GetPlayerNameEx(playerid));
		mysql_query(DB_GetHandler(), query, false);
	}
}

stock GetPlayerSpawnInteriorID(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerSpawnInfoInteriorid[playerid];
}

stock SetPlayerWeaponSkillPistol(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillPistol[playerid] = amount;
}

stock GetPlayerWeaponSkillPistol(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillPistol[playerid];
}

stock SetPlayerWeaponSkillSilencedPi(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillSilenced[playerid] = amount;
}

stock GetPlayerWeaponSkillSilencedPi(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillSilenced[playerid];
}

stock SetPlayerWeaponSkillDesertEagle(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillDesertEagle[playerid] = amount;
}

stock GetPlayerWeaponSkillDesertEagle(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillDesertEagle[playerid];
}

stock SetPlayerWeaponSkillShotGun(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillShotgun[playerid] = amount;
}

stock GetPlayerWeaponSkillShotGun(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillShotgun[playerid];
}

stock SetPlayerWeaponSkillSawnOff(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillSawnOff[playerid] = amount;
}

stock GetPlayerWeaponSkillSawnOff(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillSawnOff[playerid];
}

stock SetPlayerWeaponSkillSpaz12(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillSPAZ12[playerid] = amount;
}

stock GetPlayerWeaponSkillSpaz12(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillSPAZ12[playerid];
}

stock SetPlayerWeaponSkillMicroUzi(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillMicroUzi[playerid] = amount;
}

stock GetPlayerWeaponSkillMicroUzi(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillMicroUzi[playerid];
}

stock SetPlayerWeaponSkillMP5(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillMP5[playerid] = amount;
}

stock GetPlayerWeaponSkillMP5(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillMP5[playerid];
}

stock SetPlayerWeaponSkillAK47(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillAK47[playerid] = amount;
}

stock GetPlayerWeaponSkillAK47(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillAK47[playerid];
}

stock SetPlayerWeaponSkillM4(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillM4[playerid] = amount;
}

stock GetPlayerWeaponSkillM4(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillM4[playerid];
}

stock SetPlayerWeaponSkillSniperRifle(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillSniperRifle[playerid] = amount;
}

stock GetPlayerWeaponSkillSniperRifle(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return INVALID_PLAYER_ID;
	}

	return gPlayerWeaponSkillSniperRifle[playerid];
}

stock SetPlayerAllWeaponSkills(playerid, amount)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	if (amount < 0)
	{
		amount = 0;
	}
	else if (amount > 999)
	{
		amount = 999;
	}

	gPlayerWeaponSkillPistol[playerid] =
	gPlayerWeaponSkillSilenced[playerid] =
	gPlayerWeaponSkillDesertEagle[playerid] =
	gPlayerWeaponSkillShotgun[playerid] =
	gPlayerWeaponSkillSawnOff[playerid] =
	gPlayerWeaponSkillSPAZ12[playerid] =
	gPlayerWeaponSkillMicroUzi[playerid] =
	gPlayerWeaponSkillMP5[playerid] =
	gPlayerWeaponSkillAK47[playerid] =
	gPlayerWeaponSkillM4[playerid] =
	gPlayerWeaponSkillSniperRifle[playerid] = amount;
}

stock UpdatePlayerWeaponSkills(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return;
	}

	SetPlayerSkillLevel(playerid, 0, gPlayerWeaponSkillPistol[playerid]);
	SetPlayerSkillLevel(playerid, 1, gPlayerWeaponSkillSilenced[playerid]);
	SetPlayerSkillLevel(playerid, 2, gPlayerWeaponSkillDesertEagle[playerid]);
	SetPlayerSkillLevel(playerid, 3, gPlayerWeaponSkillShotgun[playerid]);
	SetPlayerSkillLevel(playerid, 4, gPlayerWeaponSkillSawnOff[playerid]);
	SetPlayerSkillLevel(playerid, 5, gPlayerWeaponSkillSPAZ12[playerid]);
	SetPlayerSkillLevel(playerid, 6, gPlayerWeaponSkillMicroUzi[playerid]);
	SetPlayerSkillLevel(playerid, 7, gPlayerWeaponSkillMP5[playerid]);
	SetPlayerSkillLevel(playerid, 8, gPlayerWeaponSkillAK47[playerid]);
	SetPlayerSkillLevel(playerid, 9, gPlayerWeaponSkillM4[playerid]);
	SetPlayerSkillLevel(playerid, 10, gPlayerWeaponSkillSniperRifle[playerid]);
}
