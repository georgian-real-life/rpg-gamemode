CMD:createactor(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new actorIndex = Iter_Alloc(gActors);

	if (!(-1 <= actorIndex <= MAX_ACTOR))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"actor-is sheqmna ver moxerxda");
		return false;
	}

	mysql_query(DB_GetHandler(), "INSERT INTO `actors` (`modelid`) VALUES ('0')", false);

	new Cache:result;
	result = mysql_query(DB_GetHandler(), "SELECT MAX(`id`) FROM `actors`", true);

	new dbID;
	cache_get_value_index_int(0, 0, dbID);
	cache_delete(result);

	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	Actor_SetActorID(actorIndex, dbID);
	Actor_SetActorModelID(actorIndex, ACTOR_DEFAULT_ACTOR_MODEL_ID);
	Actor_SetActorName(actorIndex, ACTOR_DEFAULT_ACTOR_NAME);
	Actor_SetActorPos(actorIndex, x, y, z);
	Actor_SetActorFacingAngle(actorIndex, angle);
	Actor_SetActorHealth(actorIndex, 100.00);
	Actor_SetActorInvulnerability(actorIndex, 1);
	Actor_SetActorVirtualWorld(actorIndex, GetPlayerVirtualWorld(playerid));
	Actor_SetActorInteriorID(actorIndex, GetPlayerInterior(playerid));
	Actor_SetActorAnimLibName(actorIndex, ACTOR_DEFAULT_ANIM_LIB_NAME);
	Actor_SetActorAnimName(actorIndex, ACTOR_DEFAULT_ANIM_NAME);
	Actor_SetActorAnimDelta(actorIndex, 4.0);
	Actor_SetActorAnimLoop(actorIndex, 0);
	Actor_SetActorAnimLockX(actorIndex, 0);
	Actor_SetActorAnimLockY(actorIndex, 0);
	Actor_SetActorAnimFreeze(actorIndex, 0);
	Actor_SetActorAnimTime(actorIndex, 0);

	new query[512];
	mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `actors` SET `modelid` = '%d', `name` = '%s', `posX` = '%f', `posY` = '%f', `posZ` = '%f', `posAngle` = '%f', \
		`health` = '%f', `invulnerability` = '%d', `virtualworld` = '%d', `interiorid` = '%d', \
		`animLib` = '%s', `animName` = '%s', `animDelta` = '%d', `animLoop` = '%d', `animLockX` = '%d', `animLockY` = '%d', `animFreeze` = '%d', `animTime` = '%d' \
		WHERE `id` = '%d';", \
	ACTOR_DEFAULT_ACTOR_MODEL_ID, ACTOR_DEFAULT_ACTOR_NAME, x, y, z, angle, \
	100.00, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), \
	ACTOR_DEFAULT_ANIM_LIB_NAME, ACTOR_DEFAULT_ANIM_NAME, 0, 0, 0, 0, 0, 0, \
	dbID);

	mysql_tquery(DB_GetHandler(), query);

	Actor_CreateActor(actorIndex);
	return true;
}

CMD:editactor(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new actorIndex;

	if (sscanf(params, "i", actorIndex))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /editactor [actor Index]");
		return false;
	}

	if (!(-1 <= actorIndex <= MAX_ACTOR))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Actors] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gActors, actorIndex))
	{
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, playerID, inputtext

		if (!response)
		{
			return false;
		}

		inline __response(playerIDD, dialogIDD, responsee, listitemm, string:inputtextt[])
		{
			#pragma unused dialogIDD, playerIDD, listitemm

			if (!responsee)
			{
				return false;
			}

			if (isnull(inputtextt))
			{
				return false;
			}

			new x = strval(inputtextt);
			switch (listitem)
			{
				case 0:
				{
					if (IsValidSkin(x))
					{
						Actor_SetActorModelID(actorIndex, x);
					}
				}

				case 1:
				{
					Actor_SetActorName(actorIndex, inputtextt);
				}

				case 2:
				{
					new Float:px, Float:py, Float:pz, Float:pAngle;

					GetPlayerPos(playerid, px, py, pz);
					GetPlayerFacingAngle(playerid, pAngle);

					Actor_SetActorPos(actorIndex, px, py, pz);
					Actor_SetActorFacingAngle(actorIndex, pAngle);
				}

				case 3:
				{
					if (x < 0)
					{
						x = 0;
					}

					else if (x >= 1)
					{
						x = 1;
					}

					Actor_SetActorInvulnerability(actorIndex, x);
				}

				case 4:
				{
					Actor_SetActorVirtualWorld(actorIndex, x);
				}

				case 5:
				{
					Actor_SetActorInteriorID(actorIndex, x);
				}

				case 6:
				{
					Actor_SetActorAnimLibName(actorIndex, inputtextt);
				}

				case 7:
				{
					Actor_SetActorAnimName(actorIndex, inputtextt);
				}

				case 8:
				{
					Actor_SetActorAnimDelta(actorIndex, x);
				}

				case 9:
				{
					Actor_SetActorAnimLoop(actorIndex, x);
				}

				case 10:
				{
					Actor_SetActorAnimLockX(actorIndex, x);
				}

				case 11:
				{
					Actor_SetActorAnimLockY(actorIndex, x);
				}

				case 12:
				{
					Actor_SetActorAnimFreeze(actorIndex, x);
				}

				case 13:
				{
					Actor_SetActorAnimTime(actorIndex, x);
				}

				default:
				{
					return false;
				}
			}

			Actor_UpdateActor(actorIndex);
			Actor_SaveActor(actorIndex);
			return true;
		}
		Dialog_ShowCallback(playerid, using inline __response, DIALOG_STYLE_INPUT, !"{226db8} Actors", "{FFFFFF}Gtxovt sheiyvanot axali parametri", !">>", !"X");

	}

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

	new actorInfo[512];
	format(actorInfo, sizeof actorInfo, "\
		modelid\t\t%d\n\
		name\t\t\t%s\n\
		pos\t\t\tx - %f y - %f z - %f angl - %f\n\
		invulnerability\t\t%d\n\
		virtualworld\t\t%d\n\
		interiorid\t\t%d\n\
		anim library\t\t%s\n\
		anim name\t\t%s\n\
		anim delta\t\t%f\n\
		anim loop\t\t%d\n\
		anim lock x\t\t%d\n\
		anim lock y\t\t%d\n\
		anim freeze\t\t%d\n\
		anim time\t\t%d",\
	tempActorModelID, tempActorName, tempActorPosX, tempActorPosY, tempActorPosZ, tempActorPosAngle,\
	tempActorInvulnerability, tempActorVirtualworld, tempActorInteriorID, tempActorAnimLib, tempActorAnimName, \
	tempActorAnimDelta, tempActorAnimLoop, tempActorAnimLockX, tempActorAnimLockY, tempActorAnimFreeze, tempActorAnimTime);
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Actors", actorInfo, !">>", !"X");
	return true;
}

CMD:deleteactor(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new actorid;

	if (sscanf(params, "i", actorid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /deleteactor [actorIndex]");
		return false;
	}

	if (!(-1 <= actorid <= MAX_ACTOR))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Actors] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gActors, actorid))
	{
		return false;
	}

	Iter_Remove(gActors, actorid);

	Actor_DestroyActor(actorid);

	new query[64];
	mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `actors` WHERE `id` = '%d'", Actor_GetActorID(actorid));
	mysql_tquery(DB_GetHandler(), query);

	return true;
}

CMD:gotoactor(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new actorid;

	if (sscanf(params, "i", actorid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /gotoactor [actorIndex]");
		return false;
	}

	if (!(-1 <= actorid <= MAX_ACTOR))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Actors] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gActors, actorid))
	{
		return false;
	}

	new Float:x, Float:y, Float:z;
	Actor_GetActorPos(actorid, x, y, z);
	AC_SetPlayerPos(playerid, x, y, z, true);
	AC_SetPlayerVirtualWorld(playerid, Actor_GetActorVirtualWorld(actorid), true);
	AC_SetPlayerInteriorID(playerid, Actor_GetActorInteriorID(actorid), true);
	return true;
}

CMD:reloadactors(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new actorIndex : gActors)
	{
		Actor_UpdateActor(actorIndex);
	}

	return true;
}

CMD:getallactors(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new actorIndex : gActors)
	{
		new text[144], actorName[MAX_LABEL_TEXT_LENGTH];

		Actor_GetActorName(actorIndex, actorName);

		format(text, sizeof text, "Index - %d | ID - %d | Name %s", actorIndex, Actor_GetActorID(actorIndex), actorName);
		SendClientMessage(playerid, COLOUR_INFORMATION, text);
		SendClientMessage(playerid, COLOUR_INFORMATION, !"~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	return true;
}
