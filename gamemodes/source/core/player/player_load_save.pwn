forward AuthorizePlayer(playerid);
forward SavePlayerData(playerid);


enum _:E_CHARACTER_DATABASE_INDEXES // THIS IS TEMP INDEXING FOR DATABASE
{
	E_CHARACTER_DATABASE_NAME,
	E_CHARACTER_DATABASE_GENDER,
	E_CHARACTER_DATABASE_SKIN,
	E_CHARACTER_DATABASE_LEVEL,
	E_CHARACTER_DATABASE_LEVELEXP,
	E_CHARACTER_DATABASE_EXP_POINT,
	E_CHARACTER_DATABASE_DON_RANK,
	E_CHARACTER_DATABASE_CASH,
	E_CHARACTER_DATABASE_BANKCASH,
	E_CHARACTER_DATABASE_PAYCHECK,

	E_CHARACTER_DATABASE_PASS_LIC,
	E_CHARACTER_DATABASE_MOTOR_LIC,
	E_CHARACTER_DATABASE_PUBLC_LIC,
	E_CHARACTER_DATABASE_COMMR_LIC,
	E_CHARACTER_DATABASE_WATER_LIC,
	E_CHARACTER_DATABASE_PILOT_LIC,
	E_CHARACTER_DATABASE_GUN_LIC,
	E_CHARACTER_DATABASE_BZNS_LIC, //Business

	E_CHARACTER_DATABASE_PAYDAYTIME,

	E_CHARACTER_DATABASE_GUNSKILLPI, //Pistol
	E_CHARACTER_DATABASE_GUNSKILLSP, //Silenced Pistol
	E_CHARACTER_DATABASE_GUNSKILLDE, //Desert Eagle
	E_CHARACTER_DATABASE_GUNSKILLSG, //Shotgun
	E_CHARACTER_DATABASE_GUNSKILLSO, //Sawnoff
	E_CHARACTER_DATABASE_GUNSKILLSZ, //Spaz12
	E_CHARACTER_DATABASE_GUNSKILLMU, //MicroUzi
	E_CHARACTER_DATABASE_GUNSKILLM5, //MP5
	E_CHARACTER_DATABASE_GUNSKILL47, //AK47
	E_CHARACTER_DATABASE_GUNSKILLM4, //m4
	E_CHARACTER_DATABASE_GUNSKILLSR, //SniperRifle

	E_CHARACTER_DATABASE_SPAWNPOSX,
	E_CHARACTER_DATABASE_SPAWNPOSY,
	E_CHARACTER_DATABASE_SPAWNPOSZ,
	E_CHARACTER_DATABASE_SPAWNPOSAN,
	E_CHARACTER_DATABASE_VIRTWORLD,
	E_CHARACTER_DATABASE_INTERIORID,
};


public AuthorizePlayer(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	AccSetup_DeleteConnTimer(playerid);

	new query[128];
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT * FROM `player_data` WHERE `name` = '%e'", GetPlayerNameEx(playerid));
	new Cache:result = mysql_query(DB_GetHandler(), query, true);

	new
		tempPlayerGender,
		tempPlayerSpawnSkin,
		tempPlayerLevel,
		tempPlayerLevelExp,
		tempPlayerLevelExpPoint,
		tempPlayerDonatorRank,
		tempPlayerCash,
		tempPlayerBankCash,
		tempPlayerPayCheck,

		tempPlayerPassengerLicense,
		tempPlayerMotorcycleLicense,
		tempPlayerPublcTransportLicense,
		tempPlayerCommercialLicense,
		tempPlayerWaterTranspLicense,
		tempPlayerPilotLicense,
		tempPlayerGunLicense,
		tempPlayerBusinessLicense,

		tempPlayerPayDayTime,

		tempWeaponSkillPistol,
		tempWeaponSkillSilencedPistol,
		tempWeaponSkillDesertEagle,
		tempWeaponSkillShotgun,
		tempWeaponSkillSawnOff,
		tempWeaponSkillSpaz12,
		tempWeaponSkillMicroUzi,
		tempWeaponSkillMP5,
		tempWeaponSkillAK47,
		tempWeaponSkillM4,
		tempWeaponSkillSniperRifle,

		Float:tempPlayerSpawnX,
		Float:tempPlayerSpawnY,
		Float:tempPlayerSpawnZ,
		Float:tempPlayerSpawnAng,
		tempPlayerVirtualWorld,
		tempPlayerInteriorID;

	//cache_get_value_index(0, E_CHARACTER_DATABASE_NAME, gPlayerName[playerid], MAX_PLAYER_NAME);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GENDER, tempPlayerGender);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_SKIN, tempPlayerSpawnSkin);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_LEVEL, tempPlayerLevel);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_LEVELEXP, tempPlayerLevelExp);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_EXP_POINT, tempPlayerLevelExpPoint);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_DON_RANK, tempPlayerDonatorRank);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_CASH, tempPlayerCash);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_BANKCASH, tempPlayerBankCash);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_PAYCHECK, tempPlayerPayCheck);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_PASS_LIC, tempPlayerPassengerLicense);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_MOTOR_LIC, tempPlayerMotorcycleLicense);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_PUBLC_LIC, tempPlayerPublcTransportLicense);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_COMMR_LIC, tempPlayerCommercialLicense);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_WATER_LIC, tempPlayerWaterTranspLicense);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_PILOT_LIC, tempPlayerPilotLicense);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUN_LIC, tempPlayerGunLicense);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_BZNS_LIC, tempPlayerBusinessLicense);

	cache_get_value_index_int(0, E_CHARACTER_DATABASE_PAYDAYTIME, tempPlayerPayDayTime);

	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLPI, tempWeaponSkillPistol);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLSP, tempWeaponSkillSilencedPistol);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLDE, tempWeaponSkillDesertEagle);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLSG, tempWeaponSkillShotgun);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLSO, tempWeaponSkillSawnOff);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLSZ, tempWeaponSkillSpaz12);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLMU, tempWeaponSkillMicroUzi);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLM5, tempWeaponSkillMP5);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILL47, tempWeaponSkillAK47);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLM4, tempWeaponSkillM4);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_GUNSKILLSR, tempWeaponSkillSniperRifle);

	cache_get_value_index_float(0, E_CHARACTER_DATABASE_SPAWNPOSX, tempPlayerSpawnX);
	cache_get_value_index_float(0, E_CHARACTER_DATABASE_SPAWNPOSY, tempPlayerSpawnY);
	cache_get_value_index_float(0, E_CHARACTER_DATABASE_SPAWNPOSZ, tempPlayerSpawnZ);
	cache_get_value_index_float(0, E_CHARACTER_DATABASE_SPAWNPOSAN, tempPlayerSpawnAng);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_VIRTWORLD, tempPlayerVirtualWorld);
	cache_get_value_index_int(0, E_CHARACTER_DATABASE_INTERIORID, tempPlayerInteriorID);

	cache_delete(result);

	SetPlayerGender(playerid, tempPlayerGender);
	SetPlayerSpawnSkin(playerid, tempPlayerSpawnSkin);
	SetPlayerLevel(playerid, tempPlayerLevel, false);
	SetPlayerLevelExp(playerid, tempPlayerLevelExp, false);
	SetPlayerLevelExpPoint(playerid, tempPlayerLevelExpPoint, false);
	SetPlayerDonatorRank(playerid, tempPlayerDonatorRank, false);
	SetPlayerCash(playerid, tempPlayerCash, false);
	SetPlayerBankCash(playerid, tempPlayerBankCash, false);
	SetPlayerPaycheck(playerid, tempPlayerPayCheck, false);

	SetPlayerPassengerLicense(playerid, tempPlayerPassengerLicense, false);
	SetPlayerMotorcycleLicense(playerid, tempPlayerMotorcycleLicense, false);
	SetPlayerPublicServiceLicense(playerid, tempPlayerPublcTransportLicense, false);
	SetPlayerCommercialLicense(playerid, tempPlayerCommercialLicense, false);
	SetPlayerWaterTransportLicense(playerid, tempPlayerWaterTranspLicense, false);
	SetPlayerPilotLicense(playerid, tempPlayerPilotLicense, false);
	SetPlayerGunLicense(playerid, tempPlayerGunLicense, false);
	SetPlayerBusinessLicense(playerid, tempPlayerBusinessLicense, false);

	Pickup_EnablePickupDebugger(playerid, false);

	SetPlayerPayDayTime(playerid, tempPlayerPayDayTime, false);
	Timer_TriggerPayDayTimer(playerid);

	SetPlayerWeaponSkillPistol(playerid, tempWeaponSkillPistol);
	SetPlayerWeaponSkillSilencedPi(playerid, tempWeaponSkillSilencedPistol);
	SetPlayerWeaponSkillDesertEagle(playerid, tempWeaponSkillDesertEagle);
	SetPlayerWeaponSkillShotGun(playerid, tempWeaponSkillShotgun);
	SetPlayerWeaponSkillSawnOff(playerid, tempWeaponSkillSawnOff);
	SetPlayerWeaponSkillSpaz12(playerid, tempWeaponSkillSpaz12);
	SetPlayerWeaponSkillMicroUzi(playerid, tempWeaponSkillMicroUzi);
	SetPlayerWeaponSkillMP5(playerid, tempWeaponSkillMP5);
	SetPlayerWeaponSkillAK47(playerid, tempWeaponSkillAK47);
	SetPlayerWeaponSkillM4(playerid, tempWeaponSkillM4);
	SetPlayerWeaponSkillSniperRifle(playerid, tempWeaponSkillSniperRifle);

	UpdatePlayerWeaponSkills(playerid);

	AC_SetPlayerPos(playerid, tempPlayerSpawnX, tempPlayerSpawnY, tempPlayerSpawnZ, true);
	SetPlayerFacingAngle(playerid, tempPlayerSpawnAng);

	SetPlayerSpawnCoords(playerid, tempPlayerSpawnX, tempPlayerSpawnY, tempPlayerSpawnZ, tempPlayerSpawnAng);
	SetPlayerSpawnVirtualWorld(playerid, tempPlayerVirtualWorld, true);
	SetPlayerSpawnInteriorID(playerid, tempPlayerInteriorID, true);

	SetPlayerScore(playerid, GetPlayerLevel(playerid));

	ClearChatForPlayer(playerid);

	if (IsPlayerRegistered(playerid))
	{
		SendClientMessage(playerid, COLOUR_GREEN, "Tqven warmatebit daasrulet registracia.");
		SendClientMessage(playerid, COLOUR_GREEN, "");
		new text[128];
		format(text, sizeof text, "Sawyis etapze tqven gadmogecat %d Leveli, %d LevelEXP da $%d", GetPlayerLevel(playerid), GetPlayerLevelExp(playerid), GetPlayerCash(playerid));
		SendClientMessage(playerid, COLOUR_GREEN, text);
		SendClientMessage(playerid, COLOUR_GREEN, "");
	}

	DB_CheckIsPlayerIsAdmin(playerid);

	DB_CheckPlayerRestrictions(playerid);

	SetPlayerConnectionState(playerid, "Authorized");

	Timer_TriggerAntiCheatTimer(playerid);

	EnableHealthBarForPlayer(playerid, false);

	TogglePlayerSpectating(playerid, 0);

	PreloadPlayerAnimations(playerid);

	new ipCheckQuery[128];
	mysql_format(DB_GetHandler(), ipCheckQuery, sizeof ipCheckQuery, "SELECT * FROM `account_login_logs` WHERE `name` = '%e' ORDER BY `date`", GetPlayerNameEx(playerid));
	new Cache:ipCheckResult = mysql_query(DB_GetHandler(), ipCheckQuery, true);

	new ipRowCount;
	cache_get_row_count(ipRowCount);

	new playerIP[16];
	GetPlayerIp(playerid, playerIP, sizeof playerIP);

	if (ipRowCount > 0)
	{
		new
			tempPlayerIP[16],
			lastConnectionDate[20],

			playerMessage[144];

		cache_get_value_index(0, 1, tempPlayerIP, 16);
		cache_get_value_index(0, 2, lastConnectionDate, 20);

		SendClientMessage(playerid, COLOUR_LIGHT_BLUE, !"~~~~~~~~~~~~~~~~~~~~~~~~~~");

		format(playerMessage, sizeof playerMessage, "[Account Info]: Bolo avtorizacia tqvens accountze: %s", lastConnectionDate);
		SendClientMessage(playerid, COLOUR_LIGHT_BLUE, playerMessage);

		format(playerMessage, sizeof playerMessage, "[Account Info]: Amjamindeli IP misamarti bolos avtorizirebul IP-s %s", strcmp(tempPlayerIP, playerIP, true) ? "Ar Emtxveva" : "Emtxveva");
		SendClientMessage(playerid, COLOUR_LIGHT_BLUE, playerMessage);

		SendClientMessage(playerid, COLOUR_LIGHT_BLUE, !"~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}

	new loginQuery[256];

	mysql_format(DB_GetHandler(), loginQuery, sizeof loginQuery, "INSERT INTO `account_login_logs` \
		(`name`, `ip`, `date`) VALUES ('%s', '%s', NOW())",
		GetPlayerNameEx(playerid), playerIP);
	mysql_query(DB_GetHandler(), loginQuery, false);

	cache_delete(ipCheckResult);
	return true;
}

public SavePlayerData(playerid)
{
	new playerData[2056], playerRestrictions[1024];
	mysql_format(DB_GetHandler(), playerData, sizeof playerData, \
		"UPDATE `player_data` SET \
		`level` = '%d', \
		`level_exp` = '%d', \
		`level_expPoint` = '%d', \
		`donatorRank` = '%d', \
		`cash` = '%d', \
		`bankCash` = '%d', \
		`paycheck` = '%d', \
	\
		`passengerLicense` = '%d',\
		`pilotLicense` = '%d', \
		`gunLicense` = '%d', \
		`businessLicense` = '%d',\
	\
		`paydayTime` = '%d', \
	\
		`pistolSkill` = '%d',\
		`silencedPistolSkill` = '%d',\
		`desertEagleSkill` = '%d',\
		`shotgunSkill` = '%d',\
		`sawnOffSkill` = '%d',\
		`Spaz12Skill` = '%d',\
		`microUziSkill` = '%d',\
		`mp5Skill` = '%d',\
		`ak47Skill` = '%d',\
		`m4Skill` = '%d',\
		`sniperRifleSkill` = '%d' \
	\
		WHERE `name` = '%s'",

	GetPlayerLevel(playerid),
	GetPlayerLevelExp(playerid),
	GetPlayerLevelExpPoint(playerid),
	GetPlayerDonatorRank(playerid),
	GetPlayerCash(playerid),
	GetPlayerBankCash(playerid),
	GetPlayerPaycheck(playerid),

	GetPlayerPassengerLicense(playerid),
	GetPlayerPilotLicense(playerid),
	GetPlayerGunLicense(playerid),
	GetPlayerBusinessLicense(playerid),

	GetPlayerPayDayTime(playerid),

	GetPlayerWeaponSkillPistol(playerid),
	GetPlayerWeaponSkillSilencedPi(playerid),
	GetPlayerWeaponSkillDesertEagle(playerid),
	GetPlayerWeaponSkillShotGun(playerid),
	GetPlayerWeaponSkillSawnOff(playerid),
	GetPlayerWeaponSkillSpaz12(playerid),
	GetPlayerWeaponSkillMicroUzi(playerid),
	GetPlayerWeaponSkillMP5(playerid),
	GetPlayerWeaponSkillAK47(playerid),
	GetPlayerWeaponSkillM4(playerid),
	GetPlayerWeaponSkillSniperRifle(playerid),

	GetPlayerNameEx(playerid));

	mysql_query(DB_GetHandler(), playerData, false);

	mysql_format(DB_GetHandler(), playerRestrictions, sizeof playerRestrictions, \
		"UPDATE `player_restrictions` SET \
		`muteTime` = '%d', \
		`jailTime` = '%d' \
		WHERE `playerName` = '%s'",
	GetPlayerMuteTime(playerid),
	GetPlayerJailTime(playerid),
	GetPlayerNameEx(playerid));

	mysql_tquery(DB_GetHandler(), playerRestrictions);
	return true;
}
