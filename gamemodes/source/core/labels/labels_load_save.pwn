#include	<YSI_Coding\y_hooks>


forward Label_LoadLabels();


hook OnScriptInit()
{
	mysql_tquery(DB_GetHandler(), "SELECT * FROM `labels`", "Label_LoadLabels");
	return true;
}


public Label_LoadLabels()
{
	new rows;
	cache_get_row_count(rows);

	if (!rows)
	{
		return false;
	}

	for (new i = 0; i < rows; i++)
	{
		new labelIndex = Iter_Alloc(gLabels);

		if (!(-1 <= labelIndex <= MAX_LABELS))
		{
			print("[Labels] Label buffer overflow");
			break;
		}

		new
				tempLabelID,
				tempLabelText[MAX_LABEL_TEXT_LENGTH],
				tempLabelColour[MAX_LABEL_COLOUR_LENGTH],
		Float:	tempLabelPosX,
		Float:	tempLabelPosY,
		Float:	tempLabelPosZ,
		Float:	tempDrawDistance,
				tempLabelTestLOS,
				tempLabelVirtualworld,
				tempLabelInteriorid;

		cache_get_value_index_int(i, 0, tempLabelID);
		cache_get_value_index(i, 1, tempLabelText, MAX_LABEL_TEXT_LENGTH);
		cache_get_value_index(i, 2, tempLabelColour, MAX_LABEL_COLOUR_LENGTH);
		cache_get_value_index_float(i, 3, tempLabelPosX);
		cache_get_value_index_float(i, 4, tempLabelPosY);
		cache_get_value_index_float(i, 5, tempLabelPosZ);
		cache_get_value_index_float(i, 6, tempDrawDistance);
		cache_get_value_index_int(i, 7, tempLabelTestLOS);
		cache_get_value_index_int(i, 8, tempLabelVirtualworld);
		cache_get_value_index_int(i, 9, tempLabelInteriorid);

		Label_SetLabelID(labelIndex, tempLabelID);
		Label_SetLabelText(labelIndex, tempLabelText);
		Label_SetLabelColour(labelIndex, tempLabelColour);
		Label_SetLabelPos(labelIndex, tempLabelPosX, tempLabelPosY, tempLabelPosZ);
		Label_SetLabelDrawDistance(labelIndex, tempDrawDistance);
		Label_SetLabelTestLOS(labelIndex, tempLabelTestLOS);
		Label_SetLabelVirtualWorld(labelIndex, tempLabelVirtualworld);
		Label_SetLabelInteriorID(labelIndex, tempLabelInteriorid);

		Label_CreateLabel(labelIndex);
	}

	printf("\n[Labels] Loaded %d", rows);
	return true;
}


stock Label_SaveLabel(labelIndex)
{
	if (!(-1 <= labelIndex <= MAX_LABELS))
	{
		return false;
	}

	new
				tempLabelID,
				tempLabelText[MAX_LABEL_TEXT_LENGTH],
				tempLabelColour[MAX_LABEL_COLOUR_LENGTH],
		Float:	tempLabelPosX,
		Float:	tempLabelPosY,
		Float:	tempLabelPosZ,
		Float:	tempDrawDistance,
				tempLabelTestLOS,
				tempLabelVirtualworld,
				tempLabelInteriorid;

	tempLabelID = Label_GetLabelID(labelIndex);
	Label_GetLabelText(labelIndex, tempLabelText, MAX_LABEL_COLOUR_LENGTH);
	Label_GetLabelColour(labelIndex, tempLabelColour, MAX_LABEL_COLOUR_LENGTH);
	Label_GetLabelPos(labelIndex, tempLabelPosX, tempLabelPosY, tempLabelPosZ);
	Label_GetLabelDrawDistance(labelIndex, tempDrawDistance);
	tempLabelTestLOS = Label_GetLabelTestLos(labelIndex);
	tempLabelVirtualworld = Label_GetLabelVirtualWorld(labelIndex);
	tempLabelInteriorid =Label_GetLabelInteriorID(labelIndex);

	new query[512];
	mysql_format(DB_GetHandler(), query, sizeof query, \
		"UPDATE `labels` SET `text` = '%s', `textColour` = '%s', `posX` = '%f', `posY` = '%f', `posZ` = '%f', `drawDistance` = '%f', \
		`testLOS` = '%d', `virtualworld` = '%d', `interiorid` = '%d' \
		WHERE `id` = '%d';", \
	tempLabelText, tempLabelColour, tempLabelPosX, tempLabelPosY, tempLabelPosZ, tempDrawDistance, tempLabelTestLOS, tempLabelVirtualworld, tempLabelInteriorid, tempLabelID);
	mysql_tquery(DB_GetHandler(), query);
	return true;
}
