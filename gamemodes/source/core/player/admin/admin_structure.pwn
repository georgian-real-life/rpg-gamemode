/*									*/
#include	<YSI_Coding\y_hooks>


enum _:E_ADMIN_LEVELS
{
	E_ADMIN_LEVEL_NONE,
	E_ADMIN_LEVEL_TRIAL,
	E_ADMIN_LEVEL_JUNIOR,
	E_ADMIN_LEVEL_ADMINISTRATOR,
	E_ADMIN_LEVEL_SENIOR_ADMIN,
	E_ADMIN_LEVEL_SPECIAL_ADMIN,
	E_ADMIN_LEVEL_KOTE
};


static
	gPlayerAdminLevel[MAX_PLAYERS],
	gPlayerAdminAuthentication[MAX_PLAYERS];


new
	Iterator:gAdministrators<MAX_PLAYERS>;


stock GetPlayerAdminLevelName(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	new adminName[24];
	switch (GetPlayerAdminLevel(playerid))
	{
		case E_ADMIN_LEVEL_NONE:
		{
			adminName = "None";
		}
		case E_ADMIN_LEVEL_TRIAL:
		{
			adminName = "Trial administrator";
		}
		case E_ADMIN_LEVEL_JUNIOR:
		{
			adminName = "Junior administrator";
		}
		case E_ADMIN_LEVEL_ADMINISTRATOR:
		{
			adminName = "Administrator";
		}
		case E_ADMIN_LEVEL_SENIOR_ADMIN:
		{
			adminName = "Senior administrator";
		}
		case E_ADMIN_LEVEL_SPECIAL_ADMIN:
		{
			adminName = "Special admin";
		}
		case E_ADMIN_LEVEL_KOTE:
		{
			adminName = "Owner";
		}
		default:
		{
			adminName = "Unknown";
		}
	}

	return adminName;
}

stock GetPlayerAdminLevel(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	return gPlayerAdminLevel[playerid];
}

stock SetPlayerAdminAuthentication(playerid, value)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	gPlayerAdminAuthentication[playerid] = value;
	return true;
}

stock GetPlayerAdminAuthentication(playerid)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return -1;
	}

	return gPlayerAdminAuthentication[playerid];
}

stock SetPlayerAdminLevel(playerid, level)
{
	if (!(-1 <= playerid <= MAX_PLAYERS))
	{
		return false;
	}

	if (level > 0)
	{
		if (!Iter_Contains(gAdministrators, playerid))
		{
			Iter_Add(gAdministrators, playerid);
		}
	}
	else if (level <= 0)
	{
		Iter_Remove(gAdministrators, playerid);
	}

	gPlayerAdminLevel[playerid] = level;
	SetPlayerAdminAuthentication(playerid, 0);
	return true;
}

stock DB_CheckIsPlayerIsAdmin(playerid)
{
	new Cache:result, rows, query[128];

	mysql_format(DB_GetHandler(), query, sizeof query, "SELECT `adminLevel` FROM `administrators` WHERE `adminName` = '%e'", GetPlayerNameEx(playerid));
	result = mysql_query(DB_GetHandler(), query, true);

	cache_get_row_count(rows);

	if (rows > 0)
	{
		new tempAdminLevel;
		cache_get_value_index_int(0, 0, tempAdminLevel);
		SetPlayerAdminLevel(playerid, tempAdminLevel);
	}

	cache_delete(result);
	return true;
}


hook OnPlayerDisconnect(playerid, reason)
{
	if (Iter_Contains(gAdministrators, playerid))
	{
		SetPlayerAdminLevel(playerid, E_ADMIN_LEVEL_NONE);
	}

	return 1;
}
