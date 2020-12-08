stock IncreasePlayerLevel(playerid)
{
	new playerLevel = GetPlayerLevel(playerid);

	SetPlayerLevel(playerid, (playerLevel + 1), false);
	SetPlayerLevelExp(playerid, 0, false);

	SetPlayerScore(playerid, playerLevel);

	SendClientMessage(playerid, COLOUR_GREEN, "Tqveni level-i gaizarda!");
	return true;
}

stock UpdatePlayerLevelStatistics(playerid)
{
	new
		playerLevel = GetPlayerLevel(playerid),
		playerLevelExp = GetPlayerLevelExp(playerid),
		playerLevelExpPoint = GetPlayerLevelExpPoint(playerid);

	if (playerLevelExpPoint >= MAX_PLAYER_LEVEL_EXP_POINT)
	{
		PlayerExpPointIncrementText(playerid, MAX_PLAYER_LEVEL_EXP_POINT);
		SetPlayerLevelExpPoint(playerid, (playerLevelExpPoint - MAX_PLAYER_LEVEL_EXP_POINT), false);
		SetPlayerLevelExp(playerid, (playerLevelExp + 1), false);
	}

	if (++playerLevelExp >= playerLevel * 6)
	{
		IncreasePlayerLevel(playerid);
	}
	return true;
}

stock PlayerExpPointIncrementText(playerid, exp)
{
	new text[32];
	format(text, sizeof text, "~g~+exp point %d", exp);
	GameTextForPlayer(playerid, text, 5_000, 1);
}

stock PreloadPlayerAnimations(playerid)
{
	ApplyAnimation(playerid, "AIRPORT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ATTRACTORS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BASEBALL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BD_FIRE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BEACH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BENCHPRESS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BF_INJECTION", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKED", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKEH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKELEAP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKEV", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKE_DBZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BMX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BOMBER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BOX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BSKTBALL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BUDDY", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BUS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAMERA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CARRY", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAR_CHAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CASINO", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CHAINSAW", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CHOPPA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CLOTHES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COACH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COLT45", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COP_AMBIENT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COP_DVBYZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CRACK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CRIB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DAM_JUMP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DANCING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DEALER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DILDO", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DODGE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DOZER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DRIVEBYS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_B", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_C", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_D", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_E", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FINALE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FINALE2", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FLAME", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FLOWERS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FOOD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FREEWEIGHTS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GANGS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GHANDS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GHETTO_DB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GOGGLES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRAFFITI", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRAVEYARD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRENADE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GYMNASIUM", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "HAIRCUTS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "HEIST9", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_HOUSE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_OFFICE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "JST_BUISNESS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KART", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KISSING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KNIFE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN1", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN2", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN3", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LOWRIDER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MD_CHASE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MD_END", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MEDIC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MISC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MTB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MUSCULAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "NEVADA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ON_LOOKERS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "OTB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PARACHUTE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PARK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PAULNMAC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PED", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PLAYER_DVBYS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PLAYIDLES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POLICE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POOL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POOR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PYTHON", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "QUAD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "QUAD_DBZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RAPPING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RIFLE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RIOT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ROB_BANK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ROCKET", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RUSTLER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RYDER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SCRATCHING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHAMAL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHOTGUN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SILENCED", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SKATE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SMOKING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SNIPER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SPRAYCAN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "STRIP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SUNBATHE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWEET", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWIM", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWORD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TANK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TATTOOS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TEC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TRAIN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TRUCK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "UZI", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VAN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VENDING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VORTEX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WAYFARER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WEAPONS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WUZI", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WOP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GFUNK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RUNNINGMAN", "null", 0.0, 0, 0, 0, 0, 0);
}
