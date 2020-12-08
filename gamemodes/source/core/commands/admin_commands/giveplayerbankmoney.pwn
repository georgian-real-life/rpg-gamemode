alias:giveplayerbankmoney("givebankmoney", "giveplayerbankcash")
CMD:giveplayerbankmoney(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, cash;
	if (sscanf(params, "ii", targetid, cash))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /giveplayerbankmoney [targetid] [cash]");
		return false;
	}

	if (cash == 0)
	{
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	SetPlayerBankCash(targetid, (GetPlayerBankCash(targetid) + cash), true);

	new adminMessage[144];
	format(adminMessage, sizeof adminMessage, "%s[AdminCMD] %s[%d] - misca fuli bankshi %s[%d]-s. raodenoba:[$%d]", \
	FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, \
	GetPlayerNameEx(targetid), targetid, cash);
	SendAdminMessage(adminMessage);

	new query[256];
	mysql_format(DB_GetHandler(), query, sizeof query, \
	"INSERT INTO `administrator_bankcash_log` \
	(`issuerName`, `playerName`, `date`, `amount`) \
	VALUES \
	('%s', '%s', NOW(),'%d')",
	GetPlayerNameEx(playerid), GetPlayerNameEx(targetid), cash);
	mysql_tquery(DB_GetHandler(), query);
	return true;
}
