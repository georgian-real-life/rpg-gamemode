CMD:slap(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid = INVALID_PLAYER_ID, zCoord = 3;
	sscanf(params, "ii", targetid, zCoord);

	if (targetid == INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /slap [targetid] [z pos (default 3.0)]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, "Motamashes ar gauvlia avtorizacia");
		return false;
	}

	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	AC_SetPlayerPos(targetid, x, y, z + float(zCoord), true);
	return true;
}
