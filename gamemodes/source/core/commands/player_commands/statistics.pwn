alias:statistic("stats", "stat", "statistics")
CMD:statistic(playerid)
{
	new text[144];

	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, "--------------------------------------------------------------------");

	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, "Dziritati statistika");
	format(text, sizeof text, " Saxeli: %s		| Sqesi: %s",\
		GetPlayerNameEx(playerid), GetPlayerGenderName(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	format(text, sizeof text, " Level: %d	| LevelExp: (%d / %d)| LevelExp Qulebi (%d / %d) | Donator Rank: %d",\
		GetPlayerLevel(playerid), GetPlayerLevelExp(playerid), (GetPlayerLevel(playerid) * 6),
		GetPlayerLevelExpPoint(playerid), MAX_PLAYER_LEVEL_EXP_POINT, GetPlayerDonatorRank(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	format(text, sizeof text, " SkinID: %d	| Fuli Xelze: %d	| Fuli Bankshi %d",\
		GetPlayerSpawnSkin(playerid), GetPlayerCash(playerid), GetPlayerBankCash(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	format(text, sizeof text, " Xelfasi: %d",\
		GetPlayerPaycheck(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, "");

	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, "Iaragis flobis done");
	format(text, sizeof text, " 9mm: %d | SilencedPistol: %d | Desert Eagle: %d",
		GetPlayerWeaponSkillPistol(playerid), GetPlayerWeaponSkillSilencedPi(playerid), GetPlayerWeaponSkillDesertEagle(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	format(text, sizeof text, " Shotgun: %d | SawnOff shotgun: %d | Spaz12: %d",
		GetPlayerWeaponSkillShotGun(playerid), GetPlayerWeaponSkillSawnOff(playerid), GetPlayerWeaponSkillSpaz12(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	format(text, sizeof text, " SMG: %d | MP5: %d",
		GetPlayerWeaponSkillMicroUzi(playerid), GetPlayerWeaponSkillMP5(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	format(text, sizeof text, " AK47: %d | M4: %d | Sniper rifle: %d",
		GetPlayerWeaponSkillAK47(playerid), GetPlayerWeaponSkillM4(playerid), GetPlayerWeaponSkillSniperRifle(playerid));
	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, text);

	SendClientMessage(playerid, COLOUR_LIGHT_CREAM, "--------------------------------------------------------------------");
	return true;
}
