#include	<YSI_Coding\y_hooks>


static chatFlooderTime;
static commandFlooderTime;

static antiChatFlooder[MAX_PLAYERS];
static antiCommandFlooder[MAX_PLAYERS];


hook OnScriptInit()
{
	chatFlooderTime = 1_000;
	commandFlooderTime = 1_000;
	return true;
}


public OnPlayerText(playerid, text[])
{
	if (!IsPlayerAuthorized(playerid))
	{
		return false;
	}

	if (GetTickCount() < antiChatFlooder[playerid])
	{
		return false;
	}
	antiChatFlooder[playerid] = GetTickCount() + commandFlooderTime;

	if (GetPlayerMuteTime(playerid) > 0)
	{
		new message[128];
		format(message, sizeof message, "Tqven ar geqnebat chattan wvdoma shemdegi %s wuti.", ConvertSecondsToMinutes(GetPlayerMuteTime(playerid)));
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, message);
		return false;
	}

	new string[256+64];
	format(string,sizeof(string),"- %s{FFFFFF}: %s", GetPlayerNameEx(playerid), text);
	SendProxyMessageByPlayerZ(playerid, 20.0, COLOUR_WHITE, string);
	antiChatFlooder[playerid] = GetTickCount() + chatFlooderTime;
	return 0;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	return true;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if (GetTickCount() < antiCommandFlooder[playerid])
	{
		return false;
	}
	antiCommandFlooder[playerid] = GetTickCount() + commandFlooderTime;

	/*if (GetPlayerMuteTime(playerid) > 0)
	{
		new text[128];
		format(text, sizeof text, "Tqven ar geqnebat am brdzanebastan wvdoma shemdegi %s wuti.", ConvertSecondsToMinutes(GetPlayerMuteTime(playerid)));
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, text);
		return false;
	}*/
	return true;
}

stock SetChatFlooderTime(time_in_seconds)
{
	chatFlooderTime = time_in_seconds * 1000;
}

stock GetChatFlooderTime()
{
	return chatFlooderTime;
}

stock SetCommandFlooderTime(time_in_seconds)
{
	commandFlooderTime = time_in_seconds * 1000;
}

stock GetCommandFlooderTime()
{
	return commandFlooderTime;
}
