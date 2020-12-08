/*#include <YSI_Coding\y_hooks>


forward Job_LSConstruction_ActorFix();


static ls_construction_actor;
static Text3D:ls_construction_label;
#pragma unused ls_construction_label

static
		job_ls_construction_bagpickup,
		job_ls_construction_startpickup;


static
		job_ls_construction_bag_count[MAX_PLAYERS] = {0, ...},
bool:	job_ls_construction_carry[MAX_PLAYERS] = {false, ...},
		job_ls_construction_dyn_cp[MAX_PLAYERS],
bool:	job_ls_construction_gzstatus[MAX_PLAYERS] = {false, ...}; //greenzone status

static	ls_construction_gangzone;
static	ls_construction_rectangle;

static const JOB_PAYOUT = 30;
static const LEVEL_EXPERIENCE_INCREMENTAL = 10;

#pragma unused	job_ls_construction_bagpickup


hook OnScriptInit()
{
	Job_LSConstruction_ActorFix();
	SetTimer("Job_LSConstruction_ActorFix", 600000, 1);
	ls_construction_label = Create3DTextLabel("Steven", 0xFFFFFFFF, 2175.9248, -2258.6177, 14.6000, 8, 0, 1);

	Job_LSConstruction_CreateMap();

	job_ls_construction_bagpickup = CreateDynamicPickup(2060, 23, 2225.2063, -2276.5874, 14.7647);
	job_ls_construction_startpickup = CreateDynamicPickup(1314, 23, 2176.3794, -2259.1509, 14.7734);
	ls_construction_gangzone = GangZoneCreate(2108.33349609375, -2351.83349609375, 2259.33349609375, -2180.83349609375);
	ls_construction_rectangle = CreateDynamicRectangle(2108.33349609375, -2351.83349609375, 2259.33349609375, -2180.83349609375);
	return true;
}

hook OnPlayerConnect(playerid)
{
	Job_LSConstruction_RemoveMap(playerid);
	GangZoneShowForPlayer(playerid, ls_construction_gangzone, 0xF6060680);

	SetLSConstructionBagCount(playerid, 0);
	SetPlayerSackCarryingStatus(playerid, false);
	return true;
}

hook OnPlayerSpawn(playerid)
{
	if (GetPlayerSideJobID(playerid) == E_SIDE_JOB_CONSTRUCTOR)
	{
		LSConstruction_FinishJob(playerid);
	}
	return true;
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	if (areaid == ls_construction_rectangle)
	{
		job_ls_construction_gzstatus[playerid] = true;
		return true;
	}
	return true;
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	if (areaid == ls_construction_rectangle)
	{
		job_ls_construction_gzstatus[playerid] = false;
		return true;
	}
	return true;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	if (pickupid == job_ls_construction_startpickup)
	{
		if (GetPlayerSideJobID(playerid) == E_SIDE_JOB_NONE)
		{
			inline _response(playerID, dialogID, response, listitem, string:inputtext[])
			{
				#pragma unused dialogID, listitem, inputtext

				if (!response)
				{
					return false;
				}
				SetPlayerSkin(playerID, 260);
				SetPlayerSideJobID(playerID, E_SIDE_JOB_CONSTRUCTOR);
				SetPlayerSideJobStartStatus(playerID, true);
				SetPlayerSackCarryingStatus(playerID, false);
				UpdateConstructionCheckPoint(playerID);
				return 1;
			}
			Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_MSGBOX, !"{226db8} Los Santos Construction", \
				"Gsurt tu ara samushao saatis dawyeba?", !"Diax", !"Ara");
			return true;
		}
		else if (GetPlayerSideJobID(playerid) == E_SIDE_JOB_CONSTRUCTOR)
		{
			inline _response(PlayerID, dialogID, response, listitem, string:inputtext[])
			{
				#pragma unused dialogID, listitem, inputtext

				if (!response)
				{
					return false;
				}

				LSConstruction_FinishJob(PlayerID);
				return true;
			}
			Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_MSGBOX, !"{226db8} Los Santos Construction", \
				"Gsurt tu ara samushao saatis dasruleba?", !"Diax", !"Ara");
			return true;
		}
		return true;
	}
	return true;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if (checkpointid == job_ls_construction_dyn_cp[playerid])
	{
		if (GetPlayerSideJobID(playerid) == E_SIDE_JOB_CONSTRUCTOR)
		{
			if (GetPlayerState(playerid != PLAYER_STATE_ONFOOT))
			{
				return false;
			}

			if (!IsPlayerCarryingSack(playerid))
			{
				SetPlayerAttachedObject(playerid, 1 , 2060, 1,0.11,0.36,0.0,0.0,90.0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

				SetPlayerSackCarryingStatus(playerid, true);
				UpdateConstructionCheckPoint(playerid);
			}
			else
			{
				SetPlayerSackCarryingStatus(playerid, false);
				UpdateConstructionCheckPoint(playerid);

				RemovePlayerAttachedObject(playerid, 1);
				SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
				ClearAnimations(playerid, 1);

				SetLSConstructionBagCount(playerid, GetLSConstructionBagCount(playerid) + 1);
			}
			return true;
		}
	}
	return true;
}


public Job_LSConstruction_ActorFix()
{
	CreateLSConstruction_Actors();
	return true;
}


static CreateLSConstruction_Actors()
{
	DestroyActor(ls_construction_actor);
	ls_construction_actor = CreateActor(27, 2175.9248, -2258.6177, 14.7734, 223.5431);
	ApplyActorAnimation(ls_construction_actor, "GANGS", "LEANIDLE", 4.1, true, false, false, true, 0);
}

static UpdateConstructionCheckPoint(playerid)
{
	DestroyDynamicCP(job_ls_construction_dyn_cp[playerid]);

	if (!IsPlayerCarryingSack(playerid))
	{
		job_ls_construction_dyn_cp[playerid] = CreateDynamicCP(2225.2063, -2276.5874, 14.7647, 2.0);
		return;
	}

	job_ls_construction_dyn_cp[playerid] = CreateDynamicCP(2164.7844, -2237.6157, 13.2863, 2.0);
	return;
}

static LSConstruction_FinishJob(playerid)
{
	SetPlayerCash(playerid, (GetPlayerCash(playerid) + GetLSConstructionBagCount(playerid) * JOB_PAYOUT), false);
	SetPlayerLevelExpPoint(playerid, (GetPlayerLevelExpPoint(playerid) + GetLSConstructionBagCount(playerid) * LEVEL_EXPERIENCE_INCREMENTAL));
	PlayerExpPointIncrementText(playerid, GetLSConstructionBagCount(playerid) * LEVEL_EXPERIENCE_INCREMENTAL);

	DisablePlayerCheckpoint(playerid);
	SetPlayerSpawnSkin(playerid, GetPlayerSpawnSkin(playerid), true, false);

	SetLSConstructionBagCount(playerid, 0);
	SetPlayerSackCarryingStatus(playerid, false);

	SetPlayerSideJobID(playerid, E_SIDE_JOB_NONE);
	SetPlayerSideJobStartStatus(playerid, false);

	SendClientMessage(playerid, COLOUR_INFORMATION, !"[Server]: Tqveni samushao saati dasrulebulia");
	return;
}

static SetLSConstructionBagCount(playerid, value)
{
	job_ls_construction_bag_count[playerid] = value;
	return;
}

static GetLSConstructionBagCount(playerid)
{
	return job_ls_construction_bag_count[playerid];
}

static SetPlayerSackCarryingStatus(playerid, bool:value)
{
	job_ls_construction_carry[playerid] = value;
	return;
}

static IsPlayerCarryingSack(playerid)
{
	return job_ls_construction_carry[playerid]? true : false;
}

static Job_LSConstruction_CreateMap()
{
	CreateObject(5261, 2150.58374, -2240.90234, 14.50000,   0.00000, 0.00000, 44.65630);
	CreateObject(5259, 2158.60205, -2236.18018, 14.01750,   0.00000, 0.00000, 46.63620);
	CreateObject(3633, 2149.40747, -2245.75562, 12.76560,   0.00000, 0.00000, -27.25620);
	CreateObject(3632, 2150.05640, -2247.24097, 12.76563,   3.14159, 0.00000, 2.35619);
	CreateObject(5269, 2147.63184, -2246.98608, 14.61720,   180.00000, 0.00000, 46.23620);
	CreateObject(3632, 2149.81323, -2251.69849, 12.76563,   3.14159, 0.00000, 2.35619);
	CreateObject(3633, 2151.12598, -2247.74219, 12.76560,   0.00000, 0.00000, -24.91619);
	CreateObject(1438, 2155.26807, -2240.44434, 12.28560,   0.00000, 0.00000, 0.00000);
	CreateObject(3578, 2191.19165, -2261.69116, 13.27780,   3.14160, 0.00000, -45.95460);
	CreateObject(1237, 2195.60400, -2266.54565, 12.54900,   0.00000, 0.00000, 2.70000);
	CreateObject(1237, 2196.93628, -2267.95215, 12.54900,   0.00000, 0.00000, 2.70000);
	CreateObject(1554, 2160.05151, -2305.05298, 12.53810,   -0.10000, 0.00000, 0.00000);
	CreateObject(1348, 2191.11377, -2336.90820, 13.25130,   -0.06000, 0.00000, -134.93996);
	CreateObject(11400, 2178.13599, -2306.58765, 24.78690,   0.00000, 0.00000, 45.00000);
	CreateObject(2669, 2159.57788, -2301.36182, 13.89610,   0.00000, 0.00000, 135.00000);
	CreateObject(944, 2159.55371, -2302.28906, 12.67538,   0.00000, 0.00000, 42.06005);
	CreateObject(3134, 2157.96265, -2302.00342, 12.67643,   0.00000, 0.00000, -7.50000);
	CreateObject(2060, 2164.55737, -2236.42944, 12.41960,   0.00000, 0.00000, 0.00000);
	CreateObject(2060, 2164.18408, -2236.99316, 12.41960,   0.00000, 0.00000, 0.00000);
	CreateObject(2060, 2165.23706, -2236.99609, 12.41960,   0.00000, 0.00000, 0.00000);
	CreateObject(2060, 2164.50537, -2236.31104, 12.67960,   0.00000, 0.00000, 3.54000);
	CreateObject(2060, 2165.15381, -2236.66016, 12.59960,   17.98000, 11.00000, 16.00000);
	CreateObject(2060, 2164.10962, -2236.76978, 12.59960,   11.00000, 4.00000, 2.00000);
	CreateObject(2060, 2164.51147, -2236.61230, 12.85960,   0.00000, 0.00000, 3.54000);
	CreateObject(2060, 2224.61646, -2274.48608, 13.82240,   0.00000, 0.00000, -20.15999);
	CreateObject(2060, 2225.35010, -2275.03662, 13.82240,   0.00000, 0.00000, -42.54004);
	CreateObject(2060, 2224.77026, -2275.04370, 13.82240,   0.00000, 0.00000, -37.32000);
	CreateObject(2060, 2225.61060, -2275.69702, 13.82240,   0.00000, 0.00000, -42.60007);
	CreateObject(2060, 2225.58838, -2275.47437, 14.00240,   0.00000, 4.00000, 123.00000);
	CreateObject(2060, 2224.85669, -2274.57251, 14.00240,   4.00000, 0.00000, -65.00000);
}

static Job_LSConstruction_RemoveMap(playerid)
{
	RemoveBuildingForPlayer(playerid, 3744, 2193.2578, -2286.2891, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2202.8047, -2290.1016, 17.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2193.2578, -2286.2891, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3630, 2217.5859, -2284.6641, 15.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 5260, 2161.3438, -2264.9141, 14.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 3631, 2161.8516, -2264.0938, 16.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 3631, 2163.3750, -2262.6875, 16.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 5262, 2152.7109, -2256.7813, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2158.0078, -2257.2656, 16.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2167.6641, -2256.7813, 12.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2167.6641, -2256.7813, 13.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2167.6641, -2256.7813, 14.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2167.8047, -2257.3516, 16.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2167.1719, -2257.1250, 16.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3577, 2170.0781, -2257.6641, 16.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2169.3516, -2258.0703, 17.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2168.8281, -2257.5234, 17.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2150.2813, -2250.8516, 12.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2150.6953, -2252.9141, 16.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2149.8125, -2253.3672, 16.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 5261, 2152.2578, -2239.4609, 14.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2153.7734, -2253.0859, 14.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3633, 2154.5078, -2254.4766, 14.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2158.5703, -2251.0156, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3632, 2158.0469, -2250.5078, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 5132, 2163.2891, -2251.6094, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 5259, 2168.8438, -2246.7813, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3577, 2160.5625, -2234.8047, 14.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 3577, 2160.5781, -2234.8203, 13.0234, 0.25);
}
*/
