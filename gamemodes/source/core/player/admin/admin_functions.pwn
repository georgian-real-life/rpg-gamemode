
stock SendAdminMessage(const message[])
{
	foreach (new admin : gAdministrators)
	{
		SendClientMessage(admin, COLOUR_WHITE, message);
	}
	return;
}

stock SendAdminMessageToAll(const message[])
{
	for (new i = GetPlayerPoolSize(); i >= 0; --i)
	{
		if (!IsPlayerAuthorized(i))
		{
			continue;
		}

		SendClientMessage(i, COLOUR_WHITE, message);
	}
	return;
}
