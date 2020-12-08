#if defined MAX_FACTIONS
	#error MAX_FACTIONS is already defined
#endif
#define		MAX_FACTIONS					20

#if defined MAX_FACTION_NAME
	#error MAX_FACTION_NAME is already defined
#endif
#define		MAX_FACTION_NAME				32

#if defined MAX_FACTION_INITIALS_LENGTH
	#error MAX_FACTION_INITIALS_LENGTH is already defined
#endif
#define		MAX_FACTION_INITIALS_LENGTH			15

#if defined MAX_FACTION_COLOUR_LENGTH
	#error MAX_FACTION_COLOUR_LENGTH is already defined
#endif
#define		MAX_FACTION_COLOUR_LENGTH		11

#if defined MAX_FACTION_SKINS
	#error MAX_FACTION_SKINS is already defined
#endif
#define		MAX_FACTION_SKINS				25


enum _:E_FACTION_TYPES
{
	E_FACTION_TYPE_NONE,
	E_FACTION_TYPE_MILITARY,
	E_FACTION_TYPE_LAW_ENFORCEMENT,
	E_FACTION_TYPE_GOVERNMENTAL,
	E_FACTION_TYPE_MEDIA,
	E_FACTION_TYPE_GANG,
	E_FACTION_TYPE_MAFIA
};

static

		gFactionID[MAX_FACTIONS],
		gFactionName[MAX_FACTIONS][MAX_FACTION_NAME],
		gFactionLeaderID[MAX_FACTIONS],
		gFactionInitials[MAX_FACTIONS][MAX_FACTION_INITIALS_LENGTH],
		gFactionColour[MAX_FACTIONS][MAX_FACTION_COLOUR_LENGTH],
		gFactionType[MAX_FACTIONS],

Float:	gFactionSpawnPosX[MAX_FACTIONS],
Float:	gFactionSpawnPosY[MAX_FACTIONS],
Float:	gFactionSpawnPosZ[MAX_FACTIONS],
Float:	gFactionSpawnPosAngle[MAX_FACTIONS],
		gFactionSpawnVirtualworld[MAX_FACTIONS],
		gFactionSpawnInteriorID[MAX_FACTIONS],

		gFactionBank[MAX_FACTIONS],
		gFactionWarehouse[MAX_FACTIONS],
		gFactionMedicament[MAX_FACTIONS];


stock Faction_SetFactionID(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionID[index] = id;
	return true;
}

stock Faction_GetFactionID(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionID[index];
}

stock Faction_SetFactionName(index, const text[])
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionName[index][0] = EOS;
	strcat(gFactionName[index], text, MAX_FACTION_NAME);
	return true;
}

stock Faction_GetFactionName(index, output[], length = MAX_FACTION_NAME)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	strcat(output, gFactionName[index], length);
	return true;
}

stock Faction_SetFactionLeaderID(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionLeaderID[index] = id;
	return true;
}

stock Faction_GetFactionLeaderID(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionLeaderID[index];
}

stock Faction_SetFactionInitials(index, const text[])
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionInitials[index][0] = EOS;
	strcat(gFactionInitials[index], text, MAX_FACTION_INITIALS_LENGTH);
	return true;
}

stock Faction_GetFactionInitials(index, output[], length = MAX_FACTION_INITIALS_LENGTH)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	strcat(output, gFactionInitials[index], length);
	return true;
}

stock Faction_SetFactionColour(index, const text[])
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionColour[index][0] = EOS;
	strcat(gFactionColour[index], text, MAX_FACTION_COLOUR_LENGTH);
	return true;
}

stock Faction_GetFactionColour(index, output[], length = MAX_FACTION_COLOUR_LENGTH)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	strcat(output, gFactionColour[index], length);
	return true;
}

stock Faction_SetFactionType(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionType[index] = id;
	return true;
}

stock Faction_GetFactionType(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionType[index];
}

stock Faction_SetFactionSpawnPos(index, Float:x, Float:y, Float:z, Float:angle)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionSpawnPosX[index] = x;
	gFactionSpawnPosY[index] = y;
	gFactionSpawnPosZ[index] = z;
	gFactionSpawnPosAngle[index] = angle;
}

stock Faction_GetFactionSpawnPos(index, &Float:x, &Float:y, &Float:z, &Float:angle)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	x = gFactionSpawnPosX[index];
	y = gFactionSpawnPosY[index];
	z = gFactionSpawnPosZ[index];
	angle = gFactionSpawnPosAngle[index];
}

stock Faction_SetFactionVirtualworld(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionSpawnVirtualworld[index] = id;
	return true;
}

stock Faction_GetFactionVirtualworld(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionSpawnVirtualworld[index];
}

stock Faction_SetSpawnInteriorID(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionSpawnInteriorID[index] = id;
	return true;
}

stock Faction_GetSpawnInteriorID(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionSpawnInteriorID[index];
}

stock Faction_SetFactionBank(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionBank[index] = id;
	return true;
}

stock Faction_GetFactionBank(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionBank[index];
}

stock Faction_SetFactionWarehouse(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionWarehouse[index] = id;
	return true;
}

stock Faction_GetFactionWarehouse(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionWarehouse[index];
}

stock Faction_SetFactionMedicament(index, id)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	gFactionMedicament[index] = id;
	return true;
}

stock Faction_GetFactionMedicament(index)
{
	if (!(-1 <= index <= MAX_FACTIONS))
	{
		return false;
	}

	return gFactionMedicament[index];
}

stock Faction_GetFactionTypeName(factiontype)
{
	new type[24];

	switch (factiontype)
	{
		case E_FACTION_TYPE_MILITARY:
		{
			type = "Military";
		}
		case E_FACTION_TYPE_LAW_ENFORCEMENT:
		{
			type = "Law Enforcement"
		}
		case E_FACTION_TYPE_GOVERNMENTAL:
		{
			type = "Governmental";
		}
		case E_FACTION_TYPE_MEDIA:
		{
			type = "Media";
		}
		case E_FACTION_TYPE_GANG:
		{
			type = "Gang";
		}
		case E_FACTION_TYPE_MAFIA:
		{
			type = "Mafia";
		}
		default:
		{
			type = "None";
		}
	}

	return type;
}
