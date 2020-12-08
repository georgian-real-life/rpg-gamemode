CMD:getmypos(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return true;
	}

	new Float:x, Float:y, Float:z, Float:angle, virtualworld, interiorid;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
	virtualworld = GetPlayerVirtualWorld(playerid);
	interiorid = GetPlayerInterior(playerid);

	new text[144];
	format(text, sizeof text, "X - %f | Y - %f | Z - %f | Angle - %f | Virtualworld - %d | Interiorid - %d |", x, y, z, angle, virtualworld, interiorid);
	SendClientMessage(playerid, COLOUR_WHITE, text);
	return true;
}
