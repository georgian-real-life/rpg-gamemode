alias:setplayergender("setgender", "setpgender")
CMD:setplayergender(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid;
	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayergender [targetid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused playerID, dialogID, response, inputtext

		if (!response)
		{
			return false;
		}

		SetPlayerGender(playerID, listitem, true);

		new text[144];
		format(text, sizeof text, "%s [AdminCMD] %s[%d] sheucvala motamashe [%s][%d] sqesi", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(targetid), targetid);
		SendAdminMessage(text);

	}

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Player Gender", !"Mamrobiti\nMdedrobiti", !">>", !"X");

	return true;
}
