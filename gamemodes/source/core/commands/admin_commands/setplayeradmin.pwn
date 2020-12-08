CMD:setplayeradmin(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid, level;
	if (sscanf(params, "ii", targetid, level))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayeradmin [targetid] [level]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || targetid == playerid)
	{
		return false;
	}

	if (GetPlayerAdminLevel(playerid) < E_ADMIN_LEVEL_SPECIAL_ADMIN)
	{
		return false;
	}

	if (GetPlayerAdminLevel(playerid) <= level)
	{
		return false;
	}

	new text[128];
	format(text, sizeof text, "Tqven sheucvalet administratoris level-i %s-s, %d -ze", GetPlayerNameEx(targetid), level);
	SendClientMessage(playerid, COLOUR_INFORMATION, text);

	if (level == 0)
	{
		format(text, sizeof text, "%s wagartvat administratoris wodeba", GetPlayerNameEx(playerid));
		SendClientMessage(targetid, COLOUR_LIGHT_ERROR, text);

		new query[256];
		mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrator_suspension`(`adminName`, `suspendedBy`, `date`) VALUES ('%s','%s', NOW())",
		GetPlayerNameEx(targetid), GetPlayerNameEx(playerid));
		mysql_tquery(DB_GetHandler(), query);

		mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `administrators` WHERE `adminName` = '%s'", GetPlayerNameEx(targetid));
		mysql_tquery(DB_GetHandler(), query);
	}

	else if (level >= 1)
	{
		switch(GetPlayerAdminLevel(targetid))
		{
			case E_ADMIN_LEVEL_NONE:
			{
				new ip[16];
				GetPlayerIp(playerid, ip, 16);
				new query[256];
				mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrators` \
					(`adminName`, `adminPassword`, `adminIP`, `adminLevel`, `issueDate`, `issueTime`, `issuedBy`) VALUES \
					('%s','%s','%s','%d',NOW(),NOW(),'%s')", \
				GetPlayerNameEx(targetid), "", ip, level, GetPlayerNameEx(playerid));
				mysql_query(DB_GetHandler(), query, false);

				format(text, sizeof text, "%s dagnishnat administratorad, administratoris done %d", GetPlayerNameEx(playerid), level);
				SendClientMessage(targetid, COLOUR_LIGHT_ERROR, text);
			}
			default:
			{
				new query[256];
				mysql_format(DB_GetHandler(), query, sizeof query, "UPDATE `administrators` SET `adminLevel`='%d' WHERE `adminName` = '%s'", \
				level, GetPlayerNameEx(targetid));
				mysql_tquery(DB_GetHandler(), query);

				format(text, sizeof text, "%s shegicvalat Administratoris Level-i %d -ze", GetPlayerNameEx(playerid), level);
				SendClientMessage(targetid, COLOUR_INFORMATION, text);
			}
		}
		new query[128];
		mysql_format(DB_GetHandler(), query, sizeof query, "INSERT INTO `administrator_recruitment`(`name`, `level`, `recruitedBy`, `date`) VALUES \
		('%s','%d','%s',NOW())", \
		GetPlayerNameEx(targetid), level, GetPlayerNameEx(playerid));
		mysql_tquery(DB_GetHandler(), query);

		SendClientMessage(targetid, COLOUR_LIGHT_ERROR, !"Gtxovt xelaxla gaiarot administratoris avtorizacia brdzanebit /alogin");
	}
	SetPlayerAdminLevel(targetid, level);
	return true;
}
