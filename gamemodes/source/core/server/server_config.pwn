#if defined MAX_PLAYERS
	#undef MAX_PLAYERS
#endif
#define MAX_PLAYERS		350

#if defined MAX_VEHICLES
	#undef MAX_VEHICLES
#endif
#define MAX_VEHICLES	1500

#if !defined KEY_AIM
	#define KEY_AIM		128
#endif

#if !defined gpci
	native gpci(playerid, serial[], len);
#endif

#if !defined GetGravity
	native Float:GetGravity();
#endif

#if !defined IsValidVehicle
	native bool:IsValidVehicle(vehicleid);
#endif


#if defined SERVER_NAME
	#undef SERVER_NAME
#endif
#define SERVER_NAME	"- Melbourne-RP | Client 0.3.7 | Alpha"

#if defined SERVER_MODE_TEXT
	#undef SERVER_MODE_TEXT
#endif
#define SERVER_MODE_TEXT	"RP/GF"

#if defined SREVER_LANGUAGE
	#undef SREVER_LANGUAGE
#endif
#define SREVER_LANGUAGE	"Georgian"

#if !defined GAMEMODE_VERSION
	#define	GAMEMODE_VERSION	"v0.001"
#endif

#include	<YSI_Coding\y_hooks>


hook OnScriptInit()
{
	SendRconCommand("hostname "SERVER_NAME"");
	SetGameModeText(""SERVER_MODE_TEXT"");
	SendRconCommand("language "SREVER_LANGUAGE"");

	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
	SetNameTagDrawDistance(25.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	AllowInteriorWeapons(1);

	SetDisableSyncBugs(false);
	SetRespawnTime(3_500);

	SetGravity(0.008);

	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 1000);
	Streamer_SetTickRate(60);

	CallRemoteFunction("LoadCustomMaps", "");

	CallRemoteFunction("DB_InitializeServerInfo", "");
	ManualVehicleEngineAndLights();
	return 1;
}
