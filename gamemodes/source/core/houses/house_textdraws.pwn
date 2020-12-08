#include	<YSI_Coding\y_hooks>


new
	Text:hGTDBox,
	Text:hGTDWannaBuy,
	Text:hGTDYes,
	Text:hGTDNo;

new
	PlayerText:hPTDPrice[MAX_PLAYERS],
	PlayerText:hPTDClass[MAX_PLAYERS],
	PlayerText:hPTDElectricity[MAX_PLAYERS],
	PlayerText:hPTDMaintenanceFee[MAX_PLAYERS],
	PlayerText:hPTDLandFee[MAX_PLAYERS];



hook OnGameModeInit()
{
	hGTDBox = TextDrawCreate(541.000000, 189.000000, "_");
	TextDrawFont(hGTDBox, 1);
	TextDrawLetterSize(hGTDBox, 0.687499, 15.800020);
	TextDrawTextSize(hGTDBox, 377.000000, 182.000000);
	TextDrawSetOutline(hGTDBox, 3);
	TextDrawSetShadow(hGTDBox, 0);
	TextDrawAlignment(hGTDBox, 2);
	TextDrawColor(hGTDBox, 1687547391);
	TextDrawBackgroundColor(hGTDBox, 255);
	TextDrawBoxColor(hGTDBox, 1296911716);
	TextDrawUseBox(hGTDBox, 1);
	TextDrawSetProportional(hGTDBox, 1);
	TextDrawSetSelectable(hGTDBox, 0);

	hGTDWannaBuy = TextDrawCreate(508.000000, 275.000000, "Gsurt_saxlis_shedzena?");
	TextDrawFont(hGTDWannaBuy, 1);
	TextDrawLetterSize(hGTDWannaBuy, 0.187500, 2.049999);
	TextDrawTextSize(hGTDWannaBuy, 585.500000, 113.500000);
	TextDrawSetOutline(hGTDWannaBuy, 1);
	TextDrawSetShadow(hGTDWannaBuy, 0);
	TextDrawAlignment(hGTDWannaBuy, 1);
	TextDrawColor(hGTDWannaBuy, -1);
	TextDrawBackgroundColor(hGTDWannaBuy, 255);
	TextDrawBoxColor(hGTDWannaBuy, 0);
	TextDrawUseBox(hGTDWannaBuy, 1);
	TextDrawSetProportional(hGTDWannaBuy, 1);
	TextDrawSetSelectable(hGTDWannaBuy, 0);

	hGTDYes = TextDrawCreate(496.000000, 312.000000, "Ki");
	TextDrawFont(hGTDYes, 1);
	TextDrawLetterSize(hGTDYes, 0.295832, 1.750000);
	TextDrawTextSize(hGTDYes, 16.500000, 18.000000);
	TextDrawSetOutline(hGTDYes, 1);
	TextDrawSetShadow(hGTDYes, 0);
	TextDrawAlignment(hGTDYes, 2);
	TextDrawColor(hGTDYes, -1);
	TextDrawBackgroundColor(hGTDYes, 255);
	TextDrawBoxColor(hGTDYes, 0);
	TextDrawUseBox(hGTDYes, 1);
	TextDrawSetProportional(hGTDYes, 1);
	TextDrawSetSelectable(hGTDYes, 1);

	hGTDNo = TextDrawCreate(595.000000, 312.000000, "Ara");
	TextDrawFont(hGTDNo, 1);
	TextDrawLetterSize(hGTDNo, 0.295832, 1.750000);
	TextDrawTextSize(hGTDNo, 20.000000, 19.000000);
	TextDrawSetOutline(hGTDNo, 1);
	TextDrawSetShadow(hGTDNo, 0);
	TextDrawAlignment(hGTDNo, 2);
	TextDrawColor(hGTDNo, -1);
	TextDrawBackgroundColor(hGTDNo, 255);
	TextDrawBoxColor(hGTDNo, 0);
	TextDrawUseBox(hGTDNo, 1);
	TextDrawSetProportional(hGTDNo, 1);
	TextDrawSetSelectable(hGTDNo, 1);

	return true;
}

hook OnPlayerConnect(playerid)
{
	hPTDPrice[playerid] = CreatePlayerTextDraw(playerid, 456.000000, 192.000000, "Fasi:_$20.000.000");
	PlayerTextDrawFont(playerid, hPTDPrice[playerid], 1);
	PlayerTextDrawLetterSize(playerid, hPTDPrice[playerid], 0.420833, 1.300000);
	PlayerTextDrawTextSize(playerid, hPTDPrice[playerid], 579.000000, 48.000000);
	PlayerTextDrawSetOutline(playerid, hPTDPrice[playerid], 0);
	PlayerTextDrawSetShadow(playerid, hPTDPrice[playerid], 1);
	PlayerTextDrawAlignment(playerid, hPTDPrice[playerid], 1);
	PlayerTextDrawColor(playerid, hPTDPrice[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, hPTDPrice[playerid], 255);
	PlayerTextDrawBoxColor(playerid, hPTDPrice[playerid], 0);
	PlayerTextDrawUseBox(playerid, hPTDPrice[playerid], 1);
	PlayerTextDrawSetProportional(playerid, hPTDPrice[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, hPTDPrice[playerid], 0);

	hPTDClass[playerid] = CreatePlayerTextDraw(playerid, 456.000000, 208.000000, "Klasi:_A");
	PlayerTextDrawFont(playerid, hPTDClass[playerid], 1);
	PlayerTextDrawLetterSize(playerid, hPTDClass[playerid], 0.420833, 1.300000);
	PlayerTextDrawTextSize(playerid, hPTDClass[playerid], 573.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, hPTDClass[playerid], 1);
	PlayerTextDrawSetShadow(playerid, hPTDClass[playerid], 0);
	PlayerTextDrawAlignment(playerid, hPTDClass[playerid], 1);
	PlayerTextDrawColor(playerid, hPTDClass[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, hPTDClass[playerid], 255);
	PlayerTextDrawBoxColor(playerid, hPTDClass[playerid], 0);
	PlayerTextDrawUseBox(playerid, hPTDClass[playerid], 1);
	PlayerTextDrawSetProportional(playerid, hPTDClass[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, hPTDClass[playerid], 0);

	hPTDElectricity[playerid] = CreatePlayerTextDraw(playerid, 456.000000, 224.000000, "Denis_Gadasaxadi:_$10.000");
	PlayerTextDrawFont(playerid, hPTDElectricity[playerid], 1);
	PlayerTextDrawLetterSize(playerid, hPTDElectricity[playerid], 0.320833, 1.300000);
	PlayerTextDrawTextSize(playerid, hPTDElectricity[playerid], 581.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, hPTDElectricity[playerid], 1);
	PlayerTextDrawSetShadow(playerid, hPTDElectricity[playerid], 0);
	PlayerTextDrawAlignment(playerid, hPTDElectricity[playerid], 1);
	PlayerTextDrawColor(playerid, hPTDElectricity[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, hPTDElectricity[playerid], 255);
	PlayerTextDrawBoxColor(playerid, hPTDElectricity[playerid], 0);
	PlayerTextDrawUseBox(playerid, hPTDElectricity[playerid], 1);
	PlayerTextDrawSetProportional(playerid, hPTDElectricity[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, hPTDElectricity[playerid], 0);

	hPTDMaintenanceFee[playerid] = CreatePlayerTextDraw(playerid, 456.000000, 240.000000, "Saeqspluatacio_Xarjebi:_$5.000");
	PlayerTextDrawFont(playerid, hPTDMaintenanceFee[playerid], 1);
	PlayerTextDrawLetterSize(playerid, hPTDMaintenanceFee[playerid], 0.320833, 1.300000);
	PlayerTextDrawTextSize(playerid, hPTDMaintenanceFee[playerid], 581.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, hPTDMaintenanceFee[playerid], 1);
	PlayerTextDrawSetShadow(playerid, hPTDMaintenanceFee[playerid], 0);
	PlayerTextDrawAlignment(playerid, hPTDMaintenanceFee[playerid], 1);
	PlayerTextDrawColor(playerid, hPTDMaintenanceFee[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, hPTDMaintenanceFee[playerid], 255);
	PlayerTextDrawBoxColor(playerid, hPTDMaintenanceFee[playerid], 0);
	PlayerTextDrawUseBox(playerid, hPTDMaintenanceFee[playerid], 1);
	PlayerTextDrawSetProportional(playerid, hPTDMaintenanceFee[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, hPTDMaintenanceFee[playerid], 0);

	hPTDLandFee[playerid] = CreatePlayerTextDraw(playerid, 456.000000, 256.000000, "Miwis_Gadasaxadi:_$15.000");
	PlayerTextDrawFont(playerid, hPTDLandFee[playerid], 1);
	PlayerTextDrawLetterSize(playerid, hPTDLandFee[playerid], 0.320833, 1.300000);
	PlayerTextDrawTextSize(playerid, hPTDLandFee[playerid], 581.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, hPTDLandFee[playerid], 1);
	PlayerTextDrawSetShadow(playerid, hPTDLandFee[playerid], 0);
	PlayerTextDrawAlignment(playerid, hPTDLandFee[playerid], 1);
	PlayerTextDrawColor(playerid, hPTDLandFee[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, hPTDLandFee[playerid], 255);
	PlayerTextDrawBoxColor(playerid, hPTDLandFee[playerid], 0);
	PlayerTextDrawUseBox(playerid, hPTDLandFee[playerid], 1);
	PlayerTextDrawSetProportional(playerid, hPTDLandFee[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, hPTDLandFee[playerid], 0);


	return true;
}


CMD:test(playerid)
{
	TextDrawShowForPlayer(playerid, hGTDBox);
	TextDrawShowForPlayer(playerid, hGTDWannaBuy);
	TextDrawShowForPlayer(playerid, hGTDYes);
	TextDrawShowForPlayer(playerid, hGTDNo);

	PlayerTextDrawShow(playerid, hPTDPrice[playerid]);
	PlayerTextDrawShow(playerid, hPTDClass[playerid]);
	PlayerTextDrawShow(playerid, hPTDElectricity[playerid]);
	PlayerTextDrawShow(playerid, hPTDMaintenanceFee[playerid]);
	PlayerTextDrawShow(playerid, hPTDLandFee[playerid]);

	SelectTextDraw(playerid, 0xFF0000FF);
	return true;
}
