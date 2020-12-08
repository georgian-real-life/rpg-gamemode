CMD:createlabel(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new labelIndex = Iter_Alloc(gLabels);

	if (!(-1 <= labelIndex <= MAX_LABELS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"label-i ver sheiqmna");
		return false;
	}

	mysql_query(DB_GetHandler(), "INSERT INTO `labels` (`text`) VALUES ('None')", false);

	new Cache:result;
	result = mysql_query(DB_GetHandler(), "SELECT MAX(`id`) FROM `labels`", true);

	new dbID;
	cache_get_value_index_int(0, 0, dbID);
	cache_delete(result);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	Label_SetLabelID(labelIndex, dbID);
	Label_SetLabelText(labelIndex, "None");
	Label_SetLabelColour(labelIndex, "0xFFFFFFFF");
	Label_SetLabelPos(labelIndex, x, y, z);
	Label_SetLabelDrawDistance(labelIndex, LABEL_DEFAULT_DRAW_DISTANCE);
	Label_SetLabelTestLOS(labelIndex, LABEL_DEFAULT_TEST_LOS);
	Label_SetLabelVirtualWorld(labelIndex, GetPlayerVirtualWorld(playerid));
	Label_SetLabelInteriorID(labelIndex, GetPlayerInterior(playerid));

	new query[512];
	mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `labels` SET `text` = 'None', `textColour` = '0xFFFFFFFF', `posX` = '%f', `posY` = '%f', `posZ` = '%f', `drawDistance` = '%f', \
		`testLOS` = '%d', `virtualworld` = '%d', `interiorid` = '%d' \
		WHERE `id` = '%d';", \
	x, y, z, LABEL_DEFAULT_DRAW_DISTANCE, LABEL_DEFAULT_TEST_LOS, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), dbID);

	mysql_tquery(DB_GetHandler(), query);

	Label_CreateLabel(labelIndex);
	return true;
}

CMD:deletelabel(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new label;

	if (sscanf(params, "i", label))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /deletelabel [label Index]");
		return false;
	}

	if (!(-1 <= label <= MAX_LABELS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Labels] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gLabels, label))
	{
		return false;
	}

	Iter_Remove(gLabels, label);

	Label_DeleteLabel(label);

	new query[64];
	mysql_format(DB_GetHandler(), query, sizeof query, "DELETE FROM `labels` WHERE `id` = '%d'", Label_GetLabelID(label));
	mysql_tquery(DB_GetHandler(), query);

	return true;
}

CMD:editlabel(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new labelIndex;

	if (sscanf(params, "i", labelIndex))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /editlabel [label Index]");
		return false;
	}

	if (!(-1 <= labelIndex <= MAX_LABELS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Labels] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gLabels, labelIndex))
	{
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, playerID, inputtext

		if (!response)
		{
			return false;
		}

		inline __response(playerIDD, dialogIDD, responsee, listitemm, string:inputtextt[])
		{
			#pragma unused dialogIDD, playerIDD, listitemm

			if (!responsee)
			{
				return false;
			}

			if (isnull(inputtextt))
			{
				return false;
			}

			switch (listitem)
			{
				case 0:
				{
					Label_SetLabelText(labelIndex, inputtextt);
				}

				case 1:
				{
					Label_SetLabelColour(labelIndex, inputtextt);
				}

				case 2:
				{
					new Float:px, Float:py, Float:pz;
					GetPlayerPos(playerid, px, py, pz);
					Label_SetLabelPos(labelIndex, px, py, pz);
				}

				case 3:
				{
					new x = strval(inputtextt);
					Label_SetLabelDrawDistance(labelIndex, float(x));
				}

				case 4:
				{
					new x = strval(inputtextt);
					Label_SetLabelTestLOS(labelIndex, x);
				}

				case 5:
				{
					new x = strval(inputtextt);
					Label_SetLabelVirtualWorld(labelIndex, x);
				}

				case 6:
				{
					new x = strval(inputtextt);
					Label_SetLabelInteriorID(labelIndex, x);
				}

				default:
				{
					return false;
				}
			}

			Label_UpdateLabel(labelIndex);
			Label_SaveLabel(labelIndex);
			return true;
		}
		Dialog_ShowCallback(playerid, using inline __response, DIALOG_STYLE_INPUT, !"{226db8} Labels", "{FFFFFF}Gtxovt sheiyvanot axali parametri", !">>", !"X");

	}

	new labelText[MAX_LABEL_TEXT_LENGTH], labelColour[MAX_LABEL_COLOUR_LENGTH];

	Label_GetLabelText(labelIndex, labelText, MAX_LABEL_COLOUR_LENGTH);
	Label_GetLabelColour(labelIndex, labelColour, MAX_LABEL_COLOUR_LENGTH);

	new Float:x, Float:y, Float:z, Float:drawDistance;
	Label_GetLabelPos(labelIndex, x, y, z);
	Label_GetLabelDrawDistance(labelIndex, drawDistance);

	new labelInfo[256];
	format(labelInfo, sizeof labelInfo, "\
		label text\t\t\t%s\n\
		label colour\t\t\t%s\n\
		label pos Pos\t\t\tx - %f y - %f z - %f\n\
		label draw distance\t\t%f\n\
		label testLOS\t\t\t%d\n\
		label virtualworld\t\t%d\n\
		label interiorid\t\t\t%d",
	labelText, labelColour, x, y, z, drawDistance, Label_GetLabelTestLos(labelIndex), Label_GetLabelVirtualWorld(labelIndex), Label_GetLabelInteriorID(labelIndex));

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Labels", labelInfo, !">>", !"X");
	return true;
}

CMD:gotolabel(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new label;

	if (sscanf(params, "i", label))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /gotolabel [label Index]");
		return false;
	}

	if (!(-1 <= label <= MAX_LABELS))
	{
		SendClientMessage(playerid, COLOUR_LIGHT_ERROR, !"[Labels] Invalid ID");
		return false;
	}

	if (!Iter_Contains(gLabels, label))
	{
		return false;
	}

	new Float:x, Float:y, Float:z;
	Label_GetLabelPos(label, x, y, z);
	AC_SetPlayerPos(playerid, x, y, z, true);
	AC_SetPlayerVirtualWorld(playerid, Label_GetLabelVirtualWorld(label), true);
	AC_SetPlayerInteriorID(playerid, Label_GetLabelInteriorID(label), true);
	return true;
}

CMD:reloadlabels(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new labelindex : gLabels)
	{
		Label_UpdateLabel(labelindex);
	}
	return true;
}

CMD:getalllabels(playerid)
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	foreach (new label : gLabels)
	{
		new text[144], labelText[MAX_LABEL_TEXT_LENGTH];

		Label_GetLabelText(label, labelText, MAX_PICKUP_LABEL_TEXT_LENGTH);

		format(text, sizeof text, "Index - %d | ID - %d | Text %s", label, Label_GetLabelID(label), labelText);
		SendClientMessage(playerid, COLOUR_INFORMATION, text);
		SendClientMessage(playerid, COLOUR_INFORMATION, !"~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	return true;
}
