//for the compiler
#define	YSI_NO_HEAP_MALLOC
#define	YSI_NO_VERSION_CHECK
#define	YSI_NO_OPTIMISATION_MESSAGE
#define	YSI_NO_MODE_CACHE
#pragma compress 0


//#define		ENABLE_PROFILER
#define		ENABLE_CRASHDETECT


#include	<a_samp>
#include	<a_mysql>
#include	<compat>
#include	<YSI_Visual\y_dialog>
#include	<YSI_Coding\y_inline>
#include	<YSI_Data\y_foreach>
#include	<streamer>
#include	<sscanf2>
#include	<Pawn.CMD>
#include	<Pawn.Regex>
#include	<Pawn.RakNet>
#include	<samp-precise-timers>
#include	<YSF>
#include	<SKY>
#include	<weapon-config>
#include	<samp_bcrypt>


#if defined	ENABLE_PROFILER
#include	<profiler>
#endif

#if defined ENABLE_CRASHDETECT
#include	<crashdetect>
#endif

const PLAYER_SYNC = 207;
const VEHICLE_SYNC = 200;
const PASSENGER_SYNC = 211;
const TRAILER_SYNC = 210;
const UNOCCUPIED_SYNC = 209;
const AIM_SYNC = 203;
const BULLET_SYNC = 206;
const SPECTATING_SYNC = 212;
const WEAPONS_UPDATE_SYNC = 204;

// IPacket:PLAYER_SYNC(playerid, BitStream:bs)
// {
// 	new onFootData[PR_OnFootSync];

// 	BS_IgnoreBits(bs, 8);
// 	BS_ReadOnFootSync(bs, onFootData);

// 	new text[144];
// 	format(text, sizeof text, \
// 		"PLAYER_SYNC[%d]:\nlrKey %d \nudKey %d \nkeys %d \nposition: %.2f %.2f %.2f \nquaternion %.2f %.2f %.2f %.2f",
// 		playerid,
// 		onFootData[PR_lrKey],
// 		onFootData[PR_udKey],
// 		onFootData[PR_keys],
// 		onFootData[PR_position][0],
// 		onFootData[PR_position][1],
// 		onFootData[PR_position][2],
// 		onFootData[PR_quaternion][0],
// 		onFootData[PR_quaternion][1],
// 		onFootData[PR_quaternion][2],
// 		onFootData[PR_quaternion][3]);
// 	SendClientMessage(playerid, -1, text);

// 	format(text, sizeof text, \
// 		"health %d armour %d additionalKey %d weaponId %d specialAction %d nvelocity %.2f %.2f %.2f",
// 		onFootData[PR_health],
// 		onFootData[PR_armour],
// 		onFootData[PR_additionalKey],
// 		onFootData[PR_weaponId],
// 		onFootData[PR_specialAction],
// 		onFootData[PR_velocity][0],
// 		onFootData[PR_velocity][1],
// 		onFootData[PR_velocity][2]);

// 	SendClientMessage(playerid, -1, text);
// 	format(text, sizeof text, \
// 		"\nsurfingOffsets %.2f %.2f %.2f \nsurfingVehicleId %d \nanimationId %d \nanimationFlags %d",
// 		onFootData[PR_surfingOffsets][0],
// 		onFootData[PR_surfingOffsets][1],
// 		onFootData[PR_surfingOffsets][2],
// 		onFootData[PR_surfingVehicleId],
// 		onFootData[PR_animationId],
// 		onFootData[PR_animationFlags]
// 	);

// 	SendClientMessage(playerid, -1, text);

// 	return 1;
// }

// IPacket:VEHICLE_SYNC(playerid, BitStream:bs)
// {
//     new inCarData[PR_InCarSync];

//     BS_IgnoreBits(bs, 8);
//     BS_ReadInCarSync(bs, inCarData);

// 	new text[144];
//     format(text, sizeof text, \
//         "VEHICLE_SYNC[%d]:\nvehicleId %d \nlrKey %d \nudKey %d \nkeys %d \nquaternion %.2f %.2f %.2f %.2f",
//         playerid,
//         inCarData[PR_vehicleId],
//         inCarData[PR_lrKey],
//         inCarData[PR_udKey],
//         inCarData[PR_keys],
//         inCarData[PR_quaternion][0],
//         inCarData[PR_quaternion][1],
//         inCarData[PR_quaternion][2],
//         inCarData[PR_quaternion][3]);
// 	SendClientMessage(playerid, -1, text);

// 	format(text, sizeof text, \
// 	"position %.2f %.2f %.2f \nvelocity %.2f %.2f %.2f \nvehicleHealth %.2f \nplayerHealth %d \narmour %d ",
//         inCarData[PR_position][0],
//         inCarData[PR_position][1],
//         inCarData[PR_position][2],
//         inCarData[PR_velocity][0],
//         inCarData[PR_velocity][1],
//         inCarData[PR_velocity][2],
//         inCarData[PR_vehicleHealth],
//         inCarData[PR_playerHealth],
//         inCarData[PR_armour]);
// 	SendClientMessage(playerid, -1, text);

//     format(text, sizeof text, "additionalKey %d \nweaponId %d \nsirenState %d \nlandingGearState %d \ntrailerId %d \ntrainSpeed %.2f",
//         inCarData[PR_additionalKey],
//         inCarData[PR_weaponId],
//         inCarData[PR_sirenState],
//         inCarData[PR_landingGearState],
//         inCarData[PR_trailerId],
//         inCarData[PR_trainSpeed]);

// 	SendClientMessage(playerid, -1, text);

//     return 1;
// }

new gangzone[85];
new Float:gangzones[85][4] =
{
	{2393.00, -1742.00, 2552.00, -1625.00},
	{2716.00, -2042.00, 2865.00, -1896.00},
	{1807.00, -1151.00, 2063.00, -1023.00},
	{2087.00, -1856.00, 2217.00, -1742.00},
	{2649.00, -1332.00, 2865.00, -1161.00},
	{1807.00, -2042.00, 1908.00, -1942.00},
	{1807.00, -1942.00, 1908.00, -1842.00},
	{1807.00, -1842.00, 1908.00, -1742.00},
	{1807.00, -1742.00, 1907.00, -1625.00},
	{1908.00, -1842.00, 2008.00, -1742.00},
	{2008.00, -1842.00, 2087.00, -1742.00},
	{2008.00, -1742.00, 2087.00, -1625.00},
	{1908.00, -1942.00, 2008.00, -1842.00},
	{1908.00, -2042.00, 2008.00, -1942.00},
	{2008.00, -2042.00, 2108.00, -1942.00},
	{2108.00, -2042.00, 2208.00, -1942.00},
	{2208.00, -2042.00, 2308.00, -1942.00},
	{2308.00, -2042.00, 2408.00, -1942.00},
	{2408.00, -2042.00, 2508.00, -1942.00},
	{2508.00, -2042.00, 2608.00, -1942.00},
	{2608.00, -2042.00, 2716.00, -1942.00},
	{2008.00, -1942.00, 2087.00, -1842.00},
	{2087.00, -1942.00, 2217.00, -1856.00},
	{1807.00, -1625.00, 1907.00, -1525.00},
	{1807.00, -1525.00, 1908.00, -1441.00},
	{1807.00, -1441.00, 1908.00, -1332.00},
	{1807.00, -1332.00, 1908.00, -1241.00},
	{1807.00, -1241.00, 2063.00, -1151.00},
	{2217.00, -1942.00, 2317.00, -1857.00},
	{2317.00, -1942.00, 2417.00, -1857.00},
	{2417.00, -1942.00, 2517.00, -1857.00},
	{2517.00, -1942.00, 2617.00, -1857.00},
	{2617.00, -1942.00, 2716.00, -1896.00},
	{2417.00, -1857.00, 2517.00, -1742.00},
	{2517.00, -1857.00, 2617.00, -1742.00},
	{2317.00, -1857.00, 2417.00, -1742.00},
	{2217.00, -1857.00, 2317.00, -1742.00},
	{2617.00, -1896.00, 2865.00, -1625.00},
	{2552.00, -1742.00, 2617.00, -1625.00},
	{2087.00, -1742.00, 2217.00, -1625.00},
	{2217.00, -1742.00, 2317.00, -1625.00},
	{2317.00, -1742.00, 2393.00, -1625.00},
	{1907.00, -1625.00, 2029.00, -1525.00},
	{2147.00, -1625.00, 2269.00, -1525.00},
	{2269.00, -1625.00, 2359.00, -1525.00},
	{2359.00, -1625.00, 2448.00, -1525.00},
	{2448.00, -1625.00, 2541.00, -1525.00},
	{2541.00, -1625.00, 2641.00, -1525.00},
	{2641.00, -1625.00, 2741.00, -1525.00},
	{2741.00, -1625.00, 2865.00, -1525.00},
	{1908.00, -1525.00, 2008.00, -1441.00},
	{2008.00, -1525.00, 2107.00, -1441.00},
	{2107.00, -1525.00, 2208.00, -1441.00},
	{2208.00, -1525.00, 2308.00, -1441.00},
	{2308.00, -1525.00, 2434.00, -1441.00},
	{2434.00, -1525.00, 2545.00, -1441.00},
	{2545.00, -1525.00, 2641.00, -1441.00},
	{2641.00, -1525.00, 2741.00, -1441.00},
	{2741.00, -1525.00, 2865.00, -1441.00},
	{2637.00, -1441.00, 2741.00, -1332.00},
	{2741.00, -1441.00, 2865.00, -1332.00},
	{2533.00, -1441.00, 2637.00, -1332.00},
	{2450.00, -1441.00, 2533.00, -1332.00},
	{2346.00, -1441.00, 2450.00, -1332.00},
	{2242.00, -1441.00, 2346.00, -1332.00},
	{2081.00, -1441.00, 2242.00, -1332.00},
	{1908.00, -1441.00, 1998.00, -1332.00},
	{1998.00, -1441.00, 2081.00, -1332.00},
	{1908.00, -1332.00, 2063.00, -1241.00},
	{2063.00, -1332.00, 2180.00, -1214.00},
	{2180.00, -1332.00, 2295.00, -1214.00},
	{2295.00, -1332.00, 2412.00, -1214.00},
	{2412.00, -1332.00, 2526.00, -1214.00},
	{2526.00, -1332.00, 2649.00, -1214.00},
	{2063.00, -1214.00, 2182.00, -1114.00},
	{2182.00, -1214.00, 2295.00, -1114.00},
	{2295.00, -1214.00, 2418.00, -1114.00},
	{2418.00, -1214.00, 2536.00, -1114.00},
	{2536.00, -1214.00, 2649.00, -1114.00},
	{2063.00, -1114.00, 2264.00, -1023.00},
	{2264.00, -1114.00, 2464.00, -1023.00},
	{2464.00, -1114.00, 2649.00, -1023.00},
	{2649.00, -1161.00, 2865.00, -1023.00},
	{2029.00, -1625.00, 2147.00, -1525.00},
	{1907.00, -1742.00, 2008.00, -1625.00}
};
new GangZoneColours[85][1]=
{
	{0x00FF0070},
	{0x0000FF70},
	{0x7F00FF70},
	{0x007FFF70},
	{0xFFFF0070},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x007FFF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x0000FF70},
	{0x00FF0070},
	{0x00FF0070},
	{0x00FF0070},
	{0x00FF0070},
	{0x0000FF70},
	{0x00FF0070},
	{0x007FFF70},
	{0x00FF0070},
	{0x00FF0070},
	{0x007FFF70},
	{0x00FF0070},
	{0x00FF0070},
	{0x00FF0070},
	{0x00FF0070},
	{0x00FF0070},
	{0x0000FF70},
	{0x0000FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x00FF0070},
	{0x00FF0070},
	{0x00FF0070},
	{0x00FF0070},
	{0x0000FF70},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0x7F00FF70},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0x7F00FF70},
	{0x7F00FF70},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0x7F00FF70},
	{0xFFFF0070},
	{0xFFFF0070},
	{0xFFFF0070},
	{0x007FFF70},
	{0x007FFF70}
};

new gangzoneBorders[85][4];

#include	"source\utils\utils_header.inc"

#include	"source\core\server\server_header.inc"

#include	"source\core\account\account_header.inc"

#include	"source\core\factions\faction_header.inc"

#include	"source\core\pickups\pickups_header.inc"

#include	"source\core\labels\labels_header.inc"

#include	"source\core\actors\actors_header.inc"

#include	"source\core\mapicons\mapicons_header.inc"

#include	"source\core\player\player_header.inc"

#include	"source\core\vehicles\vehicles_header.inc"

#include	"source\core\side-jobs\side-jobs_header.inc"

#include	"source\core\houses\houses_header.inc"

#include	"source\core\commands\commands_header.inc"

#include	"source\core\anticheat\anticheat_header.inc"


main()
{
	assert (MAX_PLAYERS == GetMaxPlayers());
}

public OnGameModeInit()
{
	#if defined ENABLE_PROFILER
	Profiler_Start();
	#endif

	new Float:BORDER_SIZE = 1.5;
	for (new i = 0; i < 85; i++)
	{
		new Float:gzMinX = gangzones[i][0];
		new Float:gzMinY = gangzones[i][1];
		new Float:gzMaxX = gangzones[i][2];
		new Float:gzMaxY = gangzones[i][3];
		gangzone[i] = GangZoneCreate(gzMinX, gzMinY, gzMaxX, gzMaxY);

		gangzoneBorders[i][0] = GangZoneCreate(gzMinX-BORDER_SIZE, gzMinY+BORDER_SIZE, gzMinX+BORDER_SIZE, gzMaxY-BORDER_SIZE); // Left
		gangzoneBorders[i][1] = GangZoneCreate(gzMinX-BORDER_SIZE, gzMaxY-BORDER_SIZE, gzMaxX+BORDER_SIZE, gzMaxY+BORDER_SIZE); // Bottom
		gangzoneBorders[i][2] = GangZoneCreate(gzMaxX-BORDER_SIZE, gzMinY+BORDER_SIZE, gzMaxX+BORDER_SIZE, gzMaxY-BORDER_SIZE); // Right
		gangzoneBorders[i][3] = GangZoneCreate(gzMinX-BORDER_SIZE, gzMinY-BORDER_SIZE, gzMaxX+BORDER_SIZE, gzMinY+BORDER_SIZE); // Top
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnGameModeExit()
{
	#if defined ENABLE_PROFILER
	Profiler_Stop();
	#endif
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
