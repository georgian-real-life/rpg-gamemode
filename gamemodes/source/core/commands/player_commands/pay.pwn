CMD:pay(playerid, const params[])
{
	new targetid, money;
	if (sscanf(params, "ii", targetid, money))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /pay [targetid] [money]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid) || playerid == targetid)
	{
		return false;
	}

	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);


	if (!(0 <= money <= 1_500))
	{
		return false;
	}

	if ((GetPlayerMoney(playerid) - money) < 0)
	{
		return false;
	}

	if (!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
	{
		return false;
	}

	new messageText[128];
	format(messageText, sizeof messageText, "Tqven gadaecit %s[%d] -s $%d", GetPlayerNameEx(targetid), targetid, money);
	SendClientMessage(playerid, COLOUR_LIGHT_ERROR, messageText);

	format(messageText, sizeof messageText, "%s[%d] mogcat $%d", GetPlayerNameEx(playerid), playerid, money);
	SendClientMessage(playerid, COLOUR_LIGHT_ERROR, messageText);

	SetPlayerCash(playerid, (GetPlayerCash(playerid) - money), false);
	SetPlayerCash(targetid, (GetPlayerCash(targetid) + money), false);

	printf("[Money_Log] %s Gadasca %s -s $%d", GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), money);
	return true;
}
