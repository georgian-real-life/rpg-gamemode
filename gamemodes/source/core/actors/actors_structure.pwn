#if defined MAX_ACTOR
	#error MAX_ACTOR Already defined
#endif
#define MAX_ACTOR		256

#if defined MAX_ACTOR_NAME
	#error MAX_ACTOR_NAME Already defined
#endif
#define MAX_ACTOR_NAME		32

#if defined MAX_ACTOR_ANIM_LIB_NAME
	#error MAX_ACTOR_ANIM_LIB_NAME Already defined
#endif
#define MAX_ACTOR_ANIM_LIB_NAME		32

#if defined MAX_ACTOR_ANIM_NAME
	#error MAX_ACTOR_ANIM_NAME Already defined
#endif
#define MAX_ACTOR_ANIM_NAME		32

#if defined ACTOR_DEFAULT_ACTOR_MODEL_ID
	#error ACTOR_DEFAULT_ACTOR_MODEL_ID Already defined
#endif
#define ACTOR_DEFAULT_ACTOR_MODEL_ID	22

#if defined ACTOR_DEFAULT_ACTOR_NAME
	#error ACTOR_DEFAULT_ACTOR_NAME Already defined
#endif
#define ACTOR_DEFAULT_ACTOR_NAME		"Konstantine"

#if defined ACTOR_DEFAULT_ANIM_LIB_NAME
	#error ACTOR_DEFAULT_ANIM_LIB_NAME Already defined
#endif
#define ACTOR_DEFAULT_ANIM_LIB_NAME		"NONE"

#if defined ACTOR_DEFAULT_ANIM_NAME
	#error ACTOR_DEFAULT_ANIM_NAME Already defined
#endif
#define ACTOR_DEFAULT_ANIM_NAME		"NONE"


static
		gActorID[MAX_ACTOR],
		gActorModelID[MAX_ACTOR],
		gActorName[MAX_ACTOR][MAX_ACTOR_NAME],
Float:	gActorPosX[MAX_ACTOR],
Float:	gActorPosY[MAX_ACTOR],
Float:	gActorPosZ[MAX_ACTOR],
Float:	gActorPosAngle[MAX_ACTOR],
Float:	gActorHealth[MAX_ACTOR],
		gActorInvulnerability[MAX_ACTOR],
		gActorVirtualWorld[MAX_ACTOR],
		gActorInteriorID[MAX_ACTOR],

		gActorAnimLibName[MAX_ACTOR][MAX_ACTOR_ANIM_LIB_NAME],
		gActorAnimName[MAX_ACTOR][MAX_ACTOR_ANIM_NAME],
Float:	gActorAnimDelta[MAX_ACTOR],
		gActorAnimLoop[MAX_ACTOR],
		gActorAnimLockX[MAX_ACTOR],
		gActorAnimLockY[MAX_ACTOR],
		gActorAnimFreeze[MAX_ACTOR],
		gActorAnimTime[MAX_ACTOR];

static gActorActor[MAX_ACTOR]; //Naming ♥

static Text3D:gActorNameLabel[MAX_ACTOR];

new Iterator:gActors<MAX_ACTOR>;


stock Actor_SetActorID(index, ID)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorID[index] = ID;
	return true;
}

stock Actor_GetActorID(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorID[index];
}

stock Actor_SetActorModelID(index, ID)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorModelID[index] = ID;
	return true;
}

stock Actor_GetActorModelID(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorModelID[index];
}

stock Actor_SetActorName(index, const actorName[])
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorName[index][0] = EOS;
	strcat(gActorName[index], actorName, MAX_ACTOR_NAME);
	return true;
}

stock Actor_GetActorName(index, output[], length = MAX_ACTOR_NAME)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	strcat(output, gActorName[index], length);
	return true;
}

stock Actor_SetActorPos(index, Float:x, Float:y, Float:z)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorPosX[index] = x;
	gActorPosY[index] = y;
	gActorPosZ[index] = z;
	return true;
}

stock Actor_GetActorPos(index, &Float:x, &Float:y, &Float:z)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	x = gActorPosX[index];
	y = gActorPosY[index];
	z = gActorPosZ[index];
	return true;
}

stock Actor_SetActorFacingAngle(index, Float:angle)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorPosAngle[index] = angle;
	return true;
}

stock Actor_GetActorFacingAngle(index, &Float:angle)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	angle = gActorPosAngle[index];
	return true;
}

stock Actor_SetActorHealth(index, Float:health)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorHealth[index] = health;
	return true;
}

stock Actor_GetActorHealth(index, &Float:health)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	health = gActorHealth[index];
	return true;
}

stock Actor_SetActorInvulnerability(index, invulnerability)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorInvulnerability[index] = invulnerability;
	return true;
}

stock Actor_GetActorInvulnerability(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorInvulnerability[index];
}

stock Actor_SetActorVirtualWorld(index, virtualworld)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorVirtualWorld[index] = virtualworld;
	return true;
}

stock Actor_GetActorVirtualWorld(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorVirtualWorld[index];
}

stock Actor_SetActorInteriorID(index, interiorid)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorInteriorID[index] = interiorid;
	return true;
}

stock Actor_GetActorInteriorID(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorInteriorID[index];
}

stock Actor_SetActorAnimLibName(index, const animLib[])
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimLibName[index][0] = EOS;
	strcat(gActorAnimLibName[index], animLib, MAX_ACTOR_ANIM_LIB_NAME);
	return true;
}

stock Actor_GetActorAnimLibName(index, output[], length = MAX_ACTOR_ANIM_LIB_NAME)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	strcat(output, gActorAnimLibName[index], length);
	return true;
}

stock Actor_SetActorAnimName(index, const animName[])
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimName[index][0] = EOS;
	strcat(gActorAnimName[index], animName, MAX_ACTOR_ANIM_LIB_NAME);
	return true;
}

stock Actor_GetActorAnimName(index, output[], length = MAX_ACTOR_ANIM_NAME)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	strcat(output, gActorAnimName[index], length);
	return true;
}

stock Actor_SetActorAnimDelta(index, Float:delta)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimDelta[index] = delta;
	return true;
}

stock Actor_GetActorAnimDelta(index, &Float:delta)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	delta = gActorAnimDelta[index];
	return true;
}

stock Actor_SetActorAnimLoop(index, loop)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimLoop[index] = loop;
	return true;
}

stock Actor_GetActorAnimLoop(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorAnimLoop[index];
}

stock Actor_SetActorAnimLockX(index, lockX)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimLockX[index] = lockX;
	return true;
}

stock Actor_GetActorAnimLockX(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorAnimLockX[index];
}

stock Actor_SetActorAnimLockY(index, lockY)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimLockY[index] = lockY;
	return true;
}

stock Actor_GetActorAnimLockY(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorAnimLockY[index];
}

stock Actor_SetActorAnimFreeze(index, freeze)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimFreeze[index] = freeze;
	return true;
}

stock Actor_GetActorAnimFreeze(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorAnimFreeze[index];
}

stock Actor_SetActorAnimTime(index, time)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	gActorAnimTime[index] = time;
	return true;
}

stock Actor_GetActorAnimTime(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	return gActorAnimTime[index];
}

stock Actor_CreateActor(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	new modelid = Actor_GetActorModelID(index);
	new name[MAX_ACTOR_NAME]; Actor_GetActorName(index, name);
	new invulnerability = Actor_GetActorInvulnerability(index);
	new virtualworld = Actor_GetActorVirtualWorld(index);
	new interiorid = Actor_GetActorInteriorID(index);
	new Float:health; Actor_GetActorHealth(index, health);

	new Float:x, Float:y, Float:z; Actor_GetActorPos(index, x, y, z);
	new Float:angle; Actor_GetActorFacingAngle(index, angle);

	gActorActor[index] = CreateDynamicActor(modelid, x, y, z, angle, invulnerability, health, virtualworld, interiorid);
	gActorNameLabel[index] = CreateDynamic3DTextLabel(name, COLOUR_WHITE, x, y, z, LABEL_DEFAULT_DRAW_DISTANCE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, virtualworld, interiorid);

	new animLib[MAX_ACTOR_ANIM_LIB_NAME]; Actor_GetActorAnimLibName(index, animLib, MAX_ACTOR_ANIM_LIB_NAME);

	if (isnull(animLib) || !strcmp(animLib, ACTOR_DEFAULT_ANIM_LIB_NAME, true))
	{
		return true;
	}

	new animName[MAX_ACTOR_ANIM_NAME]; Actor_GetActorAnimName(index, animName, MAX_ACTOR_ANIM_NAME);

	if (isnull(animName) || !strcmp(animName, ACTOR_DEFAULT_ANIM_NAME, true))
	{
		return true;
	}

	new Float:delta; Actor_GetActorAnimDelta(index, delta);
	new loop = Actor_GetActorAnimLoop(index);
	new lockX = Actor_GetActorAnimLockX(index);
	new lockY = Actor_GetActorAnimLockY(index);
	new freeze = Actor_GetActorAnimFreeze(index);
	new time = Actor_GetActorAnimTime(index);

	ApplyDynamicActorAnimation(gActorActor[index], animLib, animName, delta, loop, lockX, lockY, freeze, time);
	return true;
}

stock Actor_DestroyActor(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	DestroyDynamicActor(gActorActor[index]);
	DestroyDynamic3DTextLabel(gActorNameLabel[index]);
	return true;
}

stock Actor_UpdateActor(index)
{
	if (!(-1 <= index <= MAX_ACTOR))
	{
		return false;
	}

	Actor_DestroyActor(index);
	Actor_CreateActor(index);
	return true;
}

stock Actor_IsActorVulnerable(index)
{
	return gActorInvulnerability[index] ? true : false;
}
