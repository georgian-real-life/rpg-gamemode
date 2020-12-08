#if !defined isnull
	#define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif


forward	DelayPlayerKick(playerid);


public	DelayPlayerKick(playerid)
{
	Kick(playerid);
	return 1;
}


stock KickPlayer(playerid, time_in_ms = 500)
{
	SetTimerEx("DelayPlayerKick", time_in_ms, false, "i", playerid);
	return 1;
}

stock ClearChatForPlayer(playerid)
{
	for	(new i = 0; i < 20; i++)
	{
		SendClientMessage(playerid, COLOUR_WHITE, "");
	}
}

stock ClearChatForAll()
{
	foreach (new player : Player)
	{
		ClearChatForPlayer(player);
	}
}

stock ConvertSecondsToMinutes(seconds)
{
	new Min, Sec;
	new string[6];

	Min = seconds / 60 ;
	Sec = seconds % 60 ;
	Min = Min % 60 ;

	format(string, sizeof (string), "%02d:%02d", Min, Sec);
	return string;
}

stock FormatHex(hex)
{
	new string[9];
	format(string, sizeof(string), "{%06x}", hex >>> 8);
	return string;
}

stock SendProxyMessageByPlayerZ(playerid, Float:distance, COLOUR, const text[])
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	new vw = GetPlayerVirtualWorld(playerid);
	for (new i = GetPlayerPoolSize(); i >= 0; --i)
	{
		if (playerid == i)
		{
			goto check_distance;
		}

		if (!IsPlayerStreamedIn(playerid, i))
		{
			continue;
		}
		check_distance:
		if(IsPlayerInRangeOfPoint(i, distance, x, y, z))
		{
			if(GetPlayerVirtualWorld(i) == vw)
			{
				new Float:xx, Float:yy, Float:zz;
				GetPlayerPos(i, xx, yy, zz);
				if(z <= zz - 10 || z <= zz + 10) SendClientMessage(i, COLOUR, text);
			}
		}
	}
}

stock HexToInt(const string[])
{
	if (isnull(string))
	{
		return false;
	}

	new cur = 1;
	new res = 0;

	for (new i = strlen(string); i > 0; i--)
	{
		if (string[i-1] < 58)
		{
			res = res + cur * (string[i-1] - 48);
		}

		else
		{
			res = res + cur * (string[i-1] -65 + 10);
		}

		cur = cur * 16;
	}
	return res;
}

stock IsValidSkin(skinID)
{
	if (!(-1 <= skinID <= 311))
	{
		return false;
	}
	return true;
}

stock ConvertToARGB(const gColor[], bool:ARGB = true, alpha = 0xFF)
{
	new color[11],color_int;
	color = "0x";
	strcat(color, gColor);
	sscanf(color, "x", color_int);
	color_int = (color_int * 256) + alpha;
	return ARGB ? RGBAtoARGB(color_int) : color_int;
}

stock StringContainsIP(const szStr[], bool:fixedSeparation = false, bool:ignoreNegatives = false, bool:ranges = true)
{
	new
		i = 0, ch, lastCh, len = strlen(szStr), trueIPInts = 0, bool:isNumNegative = false, bool:numIsValid = true,
		numberFound = -1, numLen = 0, numStr[5], numSize = sizeof(numStr),
		lastSpacingPos = -1, numSpacingDiff, numLastSpacingDiff, numSpacingDiffCount; // -225\0 (4 len)

	while(i <= len)
	{
		lastCh = ch;
		ch = szStr[i];
		if(ch >= '0' && ch <= '9' || (ranges == true && ch == '*'))
		{
			if(numIsValid && numLen < numSize)
			{
				if(lastCh == '-')
				{
					if(numLen == 0 && ignoreNegatives == false)
					{
						isNumNegative = true;
					}

					else if(numLen > 0)
					{
						numIsValid = false;
					}
				}

				numberFound = strval(numStr);
				if(numLen == (3 + _:isNumNegative) && !(numberFound >= -255 && numberFound <= 255))
				{
					for(numLen = 3; numLen > 0; numLen--)
					{
						numStr[numLen] = EOS;
					}
				}

				else if(lastCh == '-' && ignoreNegatives)
				{
					i++;
					continue;
				}

				else
				{
					if(numLen == 0 && numIsValid == true && isNumNegative == true && lastCh == '-')
					{
						numStr[numLen++] = lastCh;
					}
					numStr[numLen++] = ch;
				}
			}
		}

		else
		{
			if(numLen && numIsValid)
			{
				numberFound = strval(numStr);
				if(numberFound >= -255 && numberFound <= 255)
				{
					if(fixedSeparation)
					{
						if(lastSpacingPos != -1)
						{
							numLastSpacingDiff = numSpacingDiff;
							numSpacingDiff = i - lastSpacingPos - numLen;
							if(trueIPInts == 1 || numSpacingDiff == numLastSpacingDiff)
							{
								++numSpacingDiffCount;
							}
						}
						lastSpacingPos = i;
					}

					if(++trueIPInts >= 4)
					{
						break;
					}
				}

				for(numLen = 3; numLen > 0; numLen--)
				{
					numStr[numLen] = EOS;
				}
				isNumNegative = false;
			}

			else
			{
				numIsValid = true;
			}
		}
		i++;
	}

	if(fixedSeparation == true && numSpacingDiffCount < 3)
	{
		return 0;
	}

	return (trueIPInts >= 4);
}

stock IsValidWeaponID(weaponID)
{
	if (weaponID >= 1 && weaponID <= 46)
	{
		return true;
	}

	return false;
}

stock GetPlayerSpeed(playerid, &Float:speed)
{
	new Float:vX, Float:vY, Float:vZ;
	GetPlayerVelocity(playerid, vX, vY, vZ);

	speed = floatround(floatsqroot(floatpower(floatabs(vX), 2.0) + floatpower(floatabs(vY), 2.0) + floatpower(floatabs(vZ), 2.0)) * 100.3);
}

stock GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
	return floatround(floatsqroot(((x1 - x2) * (x1 - x2 )) + ((y1 - y2) * (y1- y2)) + ((z1 - z2) * (z1 - z2))));
}

stock SafeSpawnPlayer(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		RemovePlayerFromVehicle(playerid);
	}
	SpawnPlayer(playerid);
}

/* Function created by Y_Less */
stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock GetXYBehindPlayer(playerid, &Float:q, &Float:w, Float:distance)
{
	new Float:a;
	GetPlayerFacingAngle(playerid, a);
	q += (distance * -floatsin(-a, degrees));
	w += (distance * -floatcos(-a, degrees));
}

stock IsPlayerInGangzone(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	if (x >= MinX && x <= MaxX && y >= MinY && y <= MaxY)
	{
		return true;
	}

	return false;
}
