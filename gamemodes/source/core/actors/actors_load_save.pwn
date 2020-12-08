#include	<YSI_Coding\y_hooks>


forward Actors_LoadActors();


hook OnScriptInit()
{
	mysql_tquery(DB_GetHandler(), "SELECT * FROM `actors`", "Actors_LoadActors");
	return true;
}


public Actors_LoadActors()
{
	new rows;
	cache_get_row_count(rows);

	if (!rows)
	{
		return false;
	}

	for (new i = 0; i < rows; i++)
	{
		new actorIndex = Iter_Alloc(gActors);

		if (!(-1 <= actorIndex <= MAX_ACTOR))
		{
			print("[Actors] Actor buffer overflow");
			break;
		}

		new
			tempActorID,
			tempActorModelID,
			tempActorName[MAX_ACTOR_NAME],
	Float:	tempActorPosX,
	Float:	tempActorPosY,
	Float:	tempActorPosZ,
	Float:	tempActorPosAngle,
	Float:	tempActorHealth,
			tempActorInvulnerability,
			tempActorVirtualworld,
			tempActorInteriorID,
			tempActorAnimLib[MAX_ACTOR_ANIM_LIB_NAME],
			tempActorAnimName[MAX_ACTOR_ANIM_NAME],
	Float:	tempActorAnimDelta,
			tempActorAnimLoop,
			tempActorAnimLockX,
			tempActorAnimLockY,
			tempActorAnimFreeze,
			tempActorAnimTime;

		cache_get_value_index_int(i, 0, tempActorID);
		cache_get_value_index_int(i, 1, tempActorModelID);
		cache_get_value_index(i, 2, tempActorName, MAX_ACTOR_NAME);
		cache_get_value_index_float(i, 3, tempActorPosX);
		cache_get_value_index_float(i, 4, tempActorPosY);
		cache_get_value_index_float(i, 5, tempActorPosZ);
		cache_get_value_index_float(i, 6, tempActorPosAngle);
		cache_get_value_index_float(i, 7, tempActorHealth);
		cache_get_value_index_int(i, 8, tempActorInvulnerability);
		cache_get_value_index_int(i, 9, tempActorVirtualworld);
		cache_get_value_index_int(i, 10, tempActorInteriorID);
		cache_get_value_index(i, 11, tempActorAnimLib, MAX_ACTOR_ANIM_LIB_NAME);
		cache_get_value_index(i, 12, tempActorAnimName, MAX_ACTOR_ANIM_NAME);
		cache_get_value_index_float(i, 13, tempActorAnimDelta);
		cache_get_value_index_int(i, 14, tempActorAnimLoop);
		cache_get_value_index_int(i, 15, tempActorAnimLockX);
		cache_get_value_index_int(i, 16, tempActorAnimLockY);
		cache_get_value_index_int(i, 17, tempActorAnimFreeze);
		cache_get_value_index_int(i, 18, tempActorAnimTime);

		Actor_SetActorID(actorIndex, tempActorID);
		Actor_SetActorModelID(actorIndex, tempActorModelID);
		Actor_SetActorName(actorIndex, tempActorName);
		Actor_SetActorPos(actorIndex, tempActorPosX, tempActorPosY, tempActorPosZ);
		Actor_SetActorFacingAngle(actorIndex, tempActorPosAngle);
		Actor_SetActorHealth(actorIndex, tempActorHealth);
		Actor_SetActorInvulnerability(actorIndex, tempActorInvulnerability);
		Actor_SetActorVirtualWorld(actorIndex, tempActorVirtualworld);
		Actor_SetActorInteriorID(actorIndex, tempActorInteriorID);
		Actor_SetActorAnimLibName(actorIndex, tempActorAnimLib);
		Actor_SetActorAnimName(actorIndex, tempActorAnimName);
		Actor_SetActorAnimDelta(actorIndex, tempActorAnimDelta);
		Actor_SetActorAnimLoop(actorIndex, tempActorAnimLoop);
		Actor_SetActorAnimLockX(actorIndex, tempActorAnimLockX);
		Actor_SetActorAnimLockY(actorIndex, tempActorAnimLockY);
		Actor_SetActorAnimFreeze(actorIndex, tempActorAnimFreeze);
		Actor_SetActorAnimTime(actorIndex, tempActorAnimTime);

		Actor_CreateActor(actorIndex);
	}

	printf("\n[Actors] Loaded %d", rows);
	return true;
}


stock Actor_SaveActor(actorIndex)
{
	if (!(-1 <= actorIndex <= MAX_LABELS))
	{
		return false;
	}

	new tempActorID = Actor_GetActorID(actorIndex);
	new tempActorModelID = Actor_GetActorModelID(actorIndex);
	new tempActorName[MAX_ACTOR_NAME]; Actor_GetActorName(actorIndex, tempActorName);
	new Float:tempActorPosX, Float:tempActorPosY, Float:tempActorPosZ; Actor_GetActorPos(actorIndex, tempActorPosX, tempActorPosY, tempActorPosZ);
	new Float:tempActorPosAngle; Actor_GetActorFacingAngle(actorIndex, tempActorPosAngle);
	new Float:tempActorHealth; Actor_GetActorHealth(actorIndex, tempActorHealth);
	new tempActorInvulnerability = Actor_GetActorInvulnerability(actorIndex);
	new tempActorVirtualworld = Actor_GetActorVirtualWorld(actorIndex);
	new tempActorInteriorID = Actor_GetActorInteriorID(actorIndex);
	new tempActorAnimLib[MAX_ACTOR_ANIM_LIB_NAME]; Actor_GetActorAnimLibName(actorIndex, tempActorAnimLib, MAX_ACTOR_ANIM_LIB_NAME);
	new tempActorAnimName[MAX_ACTOR_ANIM_NAME]; Actor_GetActorAnimName(actorIndex, tempActorAnimName, MAX_ACTOR_ANIM_NAME);
	new Float:tempActorAnimDelta; Actor_GetActorAnimDelta(actorIndex, tempActorAnimDelta);
	new tempActorAnimLoop = Actor_GetActorAnimLoop(actorIndex);
	new tempActorAnimLockX = Actor_GetActorAnimLockX(actorIndex);
	new tempActorAnimLockY = Actor_GetActorAnimLockY(actorIndex);
	new tempActorAnimFreeze = Actor_GetActorAnimFreeze(actorIndex);
	new tempActorAnimTime = Actor_GetActorAnimTime(actorIndex);

	new query[640];
	mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `actors` SET `modelid` = '%d', `name` = '%s', `posX` = '%f', `posY` = '%f', `posZ` = '%f', `posAngle` = '%f', \
		`health` = '%f', `invulnerability` = '%d', `virtualworld` = '%d', `interiorid` = '%d', \
		`animLib` = '%s', `animName` = '%s', `animDelta` = '%f', `animLoop` = '%d', `animLockX` = '%d', `animLockY` = '%d', `animFreeze` = '%d', `animTime` = '%d' \
		WHERE `id` = '%d';", \
	tempActorModelID, tempActorName, tempActorPosX, tempActorPosY, tempActorPosZ, tempActorPosAngle, \
	tempActorHealth, tempActorInvulnerability, tempActorVirtualworld, tempActorInteriorID, \
	tempActorAnimLib, tempActorAnimName, tempActorAnimDelta, tempActorAnimLoop, tempActorAnimLockX, tempActorAnimLockY, tempActorAnimFreeze, tempActorAnimTime, \
	tempActorID);
	mysql_tquery(DB_GetHandler(), query);
	return true;
}
