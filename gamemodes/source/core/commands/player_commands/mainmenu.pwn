alias:mainmenu("menu", "mm", "mn", "help")
CMD:mainmenu(playerid)
{
	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, inputtext, playerID

		if (!response)
		{
			return false;
		}
		switch (listitem)
		{
			case 0:
			{
				callcmd::statistic(playerid);
			}
			case 1:
			{
				MainMenuParameters(playerid);
			}
			case 2:
			{
				MainMenuSecurity(playerid);
			}
			case 3:
			{
				MainMenuReport(playerid);
			}
			case 4:
			{
				MainMenuCommands(playerid);
			}
			default:
			{
				return true;
			}

		}
	}
	new text[256];
	format(text, sizeof text, \
	"[1] Statistika \n\
	[2] Parametrebi \n\
	[3] Angarishis Usafrtxoeba \n\
	[4] Administratortan kontakti \n\
	[5] Serveris brdzanebebi\n\
	");
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Mainmenu", text, !">>", !"X");
	return true;
}

stock MainMenuStatistics(const playerid)
{
	return playerid;
}

stock MainMenuParameters(const playerid)
{
	return playerid;
}

stock MainMenuSecurity(const playerid)
{
	return playerid;
}

stock MainMenuReport(const playerid)
{
	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, playerID, listitem

		if (!response)
		{
			callcmd::mainmenu(playerid);
			return true;
		}

		if (!(5 <= strlen(inputtext) <= 80))
		{
			SendClientMessage(playerID, COLOUR_LIGHT_ERROR, !"Tqveni sachivari ar iqna gagzavnili. mizezi: * teqstis sigrdze cotaa an agemateba 80 simbolos");
			return 1;
		}
		new adminMessage[144];
		format(adminMessage, sizeof adminMessage, "{E79D25}- Report: %s[%d]:%s", GetPlayerNameEx(playerid), playerid, inputtext);
		SendAdminMessage(adminMessage);
	}

	new text[256];
	format(text, sizeof text, "\t\t\tGtxovt dawerot tqveni sachivari mocemul grafashi\n\n\
		Araadekvaturi sachivris shemtxvevashi, tqven shegicherdebat chattan wvdoma garkveuli droit\n");
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_INPUT, !"{226db8} Administratortan Kontakti", text, !">>", !"<<");
	return playerid;
}

stock MainMenuCommands(const playerid)
{
	return playerid;
}
