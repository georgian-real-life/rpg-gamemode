#if defined MAX_LABELS
	#error MAX_LABELS Already defined
#endif
#define MAX_LABELS		256

#if defined MAX_LABEL_TEXT_LENGTH
	#error MAX_LABEL_TEXT_LENGTH Already defined
#endif
#define MAX_LABEL_TEXT_LENGTH		128

#if defined MAX_LABEL_COLOUR_LENGTH
	#error MAX_LABEL_COLOUR_LENGTH Already defined
#endif
#define MAX_LABEL_COLOUR_LENGTH		11

#if defined LABEL_DEFAULT_DRAW_DISTANCE
	#error LABEL_DEFAULT_DRAW_DISTANCE Already defined
#endif
#define LABEL_DEFAULT_DRAW_DISTANCE		10.0

#if defined LABEL_DEFAULT_TEST_LOS
	#error LABEL_DEFAULT_TEST_LOS Already defined
#endif
#define LABEL_DEFAULT_TEST_LOS		0


static
		gLabelID[MAX_LABELS],
		gLabelText[MAX_LABELS][MAX_LABEL_TEXT_LENGTH],
		gLabelColour[MAX_LABELS][MAX_LABEL_COLOUR_LENGTH],
Float:	gLabelPosX[MAX_LABELS],
Float:	gLabelPosY[MAX_LABELS],
Float:	gLabelPosZ[MAX_LABELS],
Float:	gLabelDrawDistance[MAX_LABELS],
		gLabelTestLos[MAX_LABELS],
		gLabelVirtualWorld[MAX_LABELS],
		gLabelInteriorID[MAX_LABELS],
Text3D:	gLabelLabel[MAX_LABELS];

new Iterator:gLabels<MAX_LABELS>;


stock Label_SetLabelID(index, id)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	gLabelID[index] = id;
	return true;
}

stock Label_GetLabelID(index)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	return gLabelID[index];
}

stock Label_SetLabelText(index, const text[])
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	gLabelText[index][0] = EOS;
	strcat(gLabelText[index], text, MAX_LABEL_TEXT_LENGTH);
	return true;
}

stock Label_GetLabelText(index, output[], length)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	strcat(output, gLabelText[index], length);
	return true;
}

stock Label_SetLabelColour(index, const text[])
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	gLabelColour[index][0] = EOS;
	strcat(gLabelColour[index], text, 11);
	return true;
}

stock Label_GetLabelColour(index, output[], length)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	strcat(output, gLabelColour[index], length);
	return true;
}

stock Label_SetLabelPos(index, Float:x, Float:y, Float:z)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	gLabelPosX[index] = x;
	gLabelPosY[index] = y;
	gLabelPosZ[index] = z;
	return true;
}

stock Label_GetLabelPos(index, &Float:x, &Float:y, &Float:z)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	x = gLabelPosX[index];
	y = gLabelPosY[index];
	z = gLabelPosZ[index];
	return true;
}

stock Label_SetLabelDrawDistance(index, Float:drawDistance)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	gLabelDrawDistance[index] = drawDistance;
	return true;
}

stock Label_GetLabelDrawDistance(index, &Float:drawDistance)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	drawDistance = gLabelDrawDistance[index];
	return true;
}

stock Label_SetLabelTestLOS(index, value)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	if (value > 1)
	{
		value = 1;
	}

	gLabelTestLos[index] = value;
	return true;
}

stock Label_GetLabelTestLos(index)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	return gLabelTestLos[index];
}

stock Label_SetLabelVirtualWorld(index, virtualworld)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	gLabelVirtualWorld[index] = virtualworld;
	return true;
}

stock Label_GetLabelVirtualWorld(index)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	return gLabelVirtualWorld[index];
}

stock Label_SetLabelInteriorID(index, interiorid)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	gLabelInteriorID[index] = interiorid;
	return true;
}

stock Label_GetLabelInteriorID(index)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	return gLabelInteriorID[index];
}

stock Label_CreateLabel(index)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	new tempLabelText[MAX_LABEL_TEXT_LENGTH], tempLabelColour[MAX_LABEL_COLOUR_LENGTH];
	new Float:x, Float:y, Float:z, Float:drawDistance;

	Label_GetLabelText(index, tempLabelText, MAX_LABEL_TEXT_LENGTH);
	Label_GetLabelColour(index, tempLabelColour, MAX_LABEL_COLOUR_LENGTH);
	Label_GetLabelPos(index, x, y, z);
	Label_GetLabelDrawDistance(index, drawDistance);

	new testLOS = Label_GetLabelTestLos(index);
	new virtualworld = Label_GetLabelVirtualWorld(index);
	new interiorid = Label_GetLabelInteriorID(index);
	new hex = HexToInt(tempLabelColour);

	gLabelLabel[index] = CreateDynamic3DTextLabel(tempLabelText, hex, x, y, z, drawDistance, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, testLOS, virtualworld, interiorid);
	return true;
}

stock Label_DeleteLabel(index)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	DestroyDynamic3DTextLabel(gLabelLabel[index]);
	return true;
}

stock Label_UpdateLabel(index)
{
	if (!(-1 <= index <= MAX_LABELS))
	{
		return false;
	}

	Label_DeleteLabel(index);
	Label_CreateLabel(index);
	return true;
}
