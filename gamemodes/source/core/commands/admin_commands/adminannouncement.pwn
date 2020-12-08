alias:adminannouncement("aa")
CMD:adminannouncement(playerid, params[])
{
	new announcementText[100];
	if (sscanf(params, "s[100]", announcementText))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /adminannouncement [text]");
		return false;
	}

	new adminMessage[144 + 1];
	format(adminMessage, sizeof (adminMessage), "{F1641E}[Announcement] %s: %s", GetPlayerNameEx(playerid), announcementText);
	SendAdminMessageToAll(adminMessage);
	return true;
}
