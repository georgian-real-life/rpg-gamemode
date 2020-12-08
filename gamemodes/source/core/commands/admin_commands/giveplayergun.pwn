alias:giveplayergun("givegun", "gun")
CMD:giveplayergun(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, weaponid, ammo;

	if (sscanf(params, "iii", targetid, weaponid, ammo))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, !"Gamoiyenet brdzaneba /giveplayergun [targetid] [weaponid] [ammo]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Motamashes ar gauvlia avtorizacia");
		return false;
	}

	if (!IsValidWeaponID(weaponid))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Gtxovt miutitot swori iaragis ID");
		return false;
	}

	if (ammo > 2_000)
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"Tyviebis raodenoba ar unda iyos 2000 -sze meti");
		return false;
	}

	AC_GivePlayerWeapon(targetid, weaponid, ammo);
	return true;
}
