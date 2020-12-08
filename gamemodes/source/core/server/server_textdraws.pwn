#include	<YSI_Coding\y_hooks>


static
	Text:gServerNameTextDraw;


hook OnScriptInit()
{
	CreateServerTextDraws();
	return 1;
}


stock CreateServerTextDraws()
{
	//Textdraws
	gServerNameTextDraw = TextDrawCreate(581.000000, 434.000000, "melbourne-rp.com");
	TextDrawFont(gServerNameTextDraw, 3);
	TextDrawLetterSize(gServerNameTextDraw, 0.266665, 1.299998);
	TextDrawTextSize(gServerNameTextDraw, 400.000000, 17.000000);
	TextDrawSetOutline(gServerNameTextDraw, 0);
	TextDrawSetShadow(gServerNameTextDraw, 2);
	TextDrawAlignment(gServerNameTextDraw, 2);
	TextDrawColor(gServerNameTextDraw, -1);
	TextDrawBackgroundColor(gServerNameTextDraw, 255);
	TextDrawBoxColor(gServerNameTextDraw, 50);
	TextDrawUseBox(gServerNameTextDraw, 0);
	TextDrawSetProportional(gServerNameTextDraw, 1);
	TextDrawSetSelectable(gServerNameTextDraw, 0);

	return true;
}

stock ShowServerNameTextDraw(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	TextDrawShowForPlayer(playerid, gServerNameTextDraw);
	return true;
}

stock HideServerNameTextDraw(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}
	TextDrawHideForPlayer(playerid, gServerNameTextDraw);
	return true;
}
