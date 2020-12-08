#if defined MAX_MAPICONS
	#error MAX_MAPICONS Already defined
#endif
#define MAX_MAPICONS		128

#if defined MAX_MAPICONS_COLOUR_LENGTH
	#error MAX_MAPICONS_COLOUR_LENGTH Already defined
#endif
#define MAX_MAPICONS_COLOUR_LENGTH		11

#if defined MAPICON_DEFAULT_COLOUR
	#error MAPICON_DEFAULT_COLOUR Already defined
#endif
#define MAPICON_DEFAULT_COLOUR		0xFFFFFFFF


static
		gMapIconID[MAX_MAPICONS],
Float:	gMapIconPosX[MAX_MAPICONS],
Float:	gMapIconPosY[MAX_MAPICONS],
Float:	gMapIconPosZ[MAX_MAPICONS],
		gMapIconType[MAX_MAPICONS],
		gMapIconColour[MAX_MAPICONS][MAX_MAPICONS_COLOUR_LENGTH],
		gMapIconVirtualWorld[MAX_MAPICONS],
		gMapIconInteriorID[MAX_MAPICONS],
		gMapIcon_MapIcon[MAX_MAPICONS];

new Iterator:gMapIcons<MAX_MAPICONS>;


stock MapIcon_SetMapIconID(index, id)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	gMapIconID[index] = id;
	return true;
}

stock MapIcon_GetMapIconID(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	return gMapIconID[index];
}

stock MapIcon_SetMapIconPos(index, Float:x, Float:y, Float:z)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	gMapIconPosX[index] = x;
	gMapIconPosY[index] = y;
	gMapIconPosZ[index] = z;
	return true;
}

stock MapIcon_GetMapIconPos(index, &Float:x, &Float:y, &Float:z)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	x = gMapIconPosX[index];
	y = gMapIconPosY[index];
	z = gMapIconPosZ[index];
	return true;
}

stock MapIcon_SetMapIconType(index, type)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	return gMapIconType[index] = type;
}

stock MapIcon_GetMapIconType(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	return gMapIconType[index];
}

stock MapIcon_SetMapIconColour(index, const text[], length = MAX_MAPICONS_COLOUR_LENGTH)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	gMapIconColour[index][0] = EOS;
	strcat(gMapIconColour[index], text, length);
	return true;
}

stock MapIcon_GetMapIconColour(index, output[], length = MAX_MAPICONS_COLOUR_LENGTH)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	strcat(output, gMapIconColour[index], length);
	return true;
}

stock MapIcon_SetMapIconVirtualWorld(index, virtualworld)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	gMapIconVirtualWorld[index] = virtualworld;
	return true;
}

stock MapIcon_GetMapIconVirtualWorld(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	return gMapIconVirtualWorld[index];
}
stock MapIcon_SetMapIconInteriorID(index, interiorid)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	gMapIconInteriorID[index] = interiorid;
	return true;
}

stock MapIcon_GetMapIconInteriorID(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	return gMapIconInteriorID[index];
}

stock MapIcon_CreateMapIcon(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	new Float:x, Float:y, Float:z; MapIcon_GetMapIconPos(index, x, y, z);
	new type = MapIcon_GetMapIconType(index);
	new colour[MAX_MAPICONS_COLOUR_LENGTH]; MapIcon_GetMapIconColour(index, colour, MAX_MAPICONS_COLOUR_LENGTH);
	new virtualworld = MapIcon_GetMapIconVirtualWorld(index);
	new interiorid = MapIcon_GetMapIconInteriorID(index);

	new hex = HexToInt(colour);

	gMapIcon_MapIcon[index] = CreateDynamicMapIcon(x, y, z, type, hex, virtualworld, interiorid);
	return true;
}

stock MapIcon_DeleteMapIcon(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	DestroyDynamicMapIcon(gMapIcon_MapIcon[index]);
	return true;
}

stock MapIcon_UpdateMapIcon(index)
{
	if (!(-1 <= index <= MAX_MAPICONS))
	{
		return false;
	}

	MapIcon_DeleteMapIcon(index);
	MapIcon_CreateMapIcon(index);
	return true;
}
