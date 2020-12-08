alias:adminserverinfo("serverinfo", "aserverinfo")
cmd:adminserverinfo(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, inputtext, listitem, playerID, response
	}

	new
		text[2048],
		playerAvailable = MAX_PLAYERS - Iter_Count(Player),
		vehiclesAvailable = MAX_VEHICLES - GetVehiclePoolSize(),
		Float:defaultGravity = GetGravity(),
		chatFlooderTime = (GetChatFlooderTime() / 1000),
		commandFlooderTime = (GetCommandFlooderTime() / 1000),
		netstats[400 + 1];
	GetNetworkStats(netstats, sizeof netstats);

	format(text, sizeof text, \
	"gamemode version:\t\t%s\n\
	max players:\t\t\t%d\n\
	player slot available:\t\t%d\n\
	max vehicle:\t\t\t%d\n\
	vehicle slot available:\t\t%d\n\
	server default gravity:\t\t%f\n\
	chat flooder time:\t\t%d wami\n\
	command flooder time:\t%d wami\n\
	\n\n\n\
	%s",
	GAMEMODE_VERSION, MAX_PLAYERS, playerAvailable, MAX_VEHICLES, vehiclesAvailable, defaultGravity, chatFlooderTime, commandFlooderTime, \
	netstats);
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_MSGBOX, !"{226db8} Server-Info", text, !"X", !"");
	return true;
}
