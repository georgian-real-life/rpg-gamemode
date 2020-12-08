forward DB_InitializeServerInfo();
forward DB_ServerWeaponMultiplierData();
forward DB_PlayerNameExists(const name[]);


public DB_InitializeServerInfo()
{
	mysql_tquery(DB_GetHandler(), "SELECT * FROM `server_weapon_multiplier_data`", "DB_ServerWeaponMultiplierData");
	return true;
}

public DB_ServerWeaponMultiplierData()
{
	new
	temp_9mm_multiplier[2],
	temp_silenced_pistol[2],
	temp_desert_eagle[2],
	temp_shotgun[2],
	temp_sawn_off[2],
	temp_microuzi[2],
	temp_mp5[2],
	temp_ak47[2],
	temp_m4[2],
	temp_sniper_rifle[2];

	cache_get_value_index_int(0, 0, temp_9mm_multiplier[0]);
	cache_get_value_index_int(0, 1, temp_9mm_multiplier[1]);
	cache_get_value_index_int(0, 2, temp_silenced_pistol[0]);
	cache_get_value_index_int(0, 3, temp_silenced_pistol[1]);
	cache_get_value_index_int(0, 4, temp_desert_eagle[0]);
	cache_get_value_index_int(0, 5, temp_desert_eagle[1]);
	cache_get_value_index_int(0, 6, temp_shotgun[0]);
	cache_get_value_index_int(0, 7, temp_shotgun[1]);
	cache_get_value_index_int(0, 8, temp_sawn_off[0]);
	cache_get_value_index_int(0, 9, temp_sawn_off[1]);
	cache_get_value_index_int(0, 10, temp_microuzi[0]);
	cache_get_value_index_int(0, 11, temp_microuzi[1]);
	cache_get_value_index_int(0, 12, temp_mp5[0]);
	cache_get_value_index_int(0, 13, temp_mp5[1]);
	cache_get_value_index_int(0, 14, temp_ak47[0]);
	cache_get_value_index_int(0, 15, temp_ak47[1]);
	cache_get_value_index_int(0, 16, temp_m4[0]);
	cache_get_value_index_int(0, 17, temp_m4[1]);
	cache_get_value_index_int(0, 18, temp_sniper_rifle[0]);
	cache_get_value_index_int(0, 19, temp_sniper_rifle[1]);

	SetColtSkillMultiplierAmmo(temp_9mm_multiplier[0]);
	SetColtSkillMultiplierPoint(temp_9mm_multiplier[1]);

	SetSilencedSkillMultiplierAmmo(temp_silenced_pistol[0]);
	SetSilencedSkillMultiplierPoint(temp_silenced_pistol[1]);

	SetDeagleSkillMultiplierAmmo(temp_desert_eagle[0]);
	SetDeagleSkillMultiplierPoint(temp_desert_eagle[1]);

	SetShotgunSkillMultiplierAmmo(temp_shotgun[0]);
	SetShotgunSkillMultiplierPoint(temp_shotgun[1]);

	SetSawnOffSkillMultiplierAmmo(temp_sawn_off[0]);
	SetSawnOffSkillMultiplierPoint(temp_sawn_off[1]);

	SetUziSkillMultiplierAmmo(temp_microuzi[0]);
	SetUziSkillMultiplierPoint(temp_microuzi[1]);

	SetMP5SkillMultiplierAmmo(temp_mp5[0]);
	SetMP5SkillMultiplierPoint(temp_mp5[1]);

	SetAK47SkillMultiplierAmmo(temp_ak47[0]);
	SetAK47SkillMultiplierPoint(temp_ak47[1]);

	SetM4SkillMultiplierAmmo(temp_m4[0]);
	SetM4SkillMultiplierPoint(temp_m4[1]);

	SetSniperSkillMultiplierAmmo(temp_sniper_rifle[0]);
	SetSniperSkillMultiplierPoint(temp_sniper_rifle[1]);

	return true;
}

public DB_PlayerNameExists(const name[])
{
	new query[128], rows;
	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `name` FROM `player_data` WHERE `name` = '%e'", name);
	new Cache:result = mysql_query(DB_GetHandler(), query, true);

	cache_get_row_count(rows);
	cache_delete(result);

	if (rows > 0)
	{
		return true;
	}

	return false;
}
