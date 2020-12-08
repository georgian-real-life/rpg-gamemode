alias:setweaponmultiplier("setwm", "setweaponm")
CMD:setweaponmultiplier(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
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

			new x = strval(inputtextt);

			return true;
		}
		Dialog_ShowCallback(playerid, using inline __response, DIALOG_STYLE_INPUT, !"{226db8} Weapon Multiplier", "{FFFFFF}Gtxovt sheiyvanot axali parametri", !">>", !"X");

	}

	new weaponInfo[512];
	format(weaponInfo, sizeof weaponInfo, "\
		9mm ammo\t\t\t%d\n\
		9mm points\t\t\t%d\n\
		Silenced Pistol ammo\t\t%d\n\
		Silenced Pistol points\t\t%d\n\
		Desert Eagle ammo\t\t%d\n\
		Desert Eagle points\t\t%d\n\
		Shotgun ammo\t\t%d\n\
		Shotgun points\t\t\t%d\n\
		Sawn Off ammo\t\t%d\n\
		Sawn Off points\t\t%d\n\
		UZI/TEC9 Ammo\t\t%d\n\
		UZI/TEC9 points\t\t%d\n\
		MP5 ammo\t\t\t%d\n\
		MP5 points\t\t\t%d\n\
		AK47 ammo\t\t\t%d\n\
		AK47 points\t\t\t%d\n\
		M4 ammo\t\t\t%d\n\
		M4 points\t\t\t%d\n\
		Sniper Rifle ammo\t\t%d\n\
		Sniper Rifle points\t\t%d",

	GetColtSkillMultiplierAmmo(),
	GetColtSkillMultiplierPoint(),
	GetSilencedSkillMultiplierAmmo(),
	GetSilencedSkillMultiplierPoint(),
	GetDeagleSkillMultiplierAmmo(),
	GetDeagleSkillMultiplierPoint(),
	GetShotgunSkillMultiplierAmmo(),
	GetShotgunSkillMultiplierPoint(),
	GetSawnOffSkillMultiplierAmmo(),
	GetSawnOffSkillMultiplierPoint(),
	GetUziSkillMultiplierAmmo(),
	GetUziSkillMultiplierPoint(),
	GetMP5SkillMultiplierAmmo(),
	GetMP5SkillMultiplierPoint(),
	GetAK47SkillMultiplierAmmo(),
	GetAK47SkillMultiplierPoint(),
	GetM4SkillMultiplierAmmo(),
	GetM4SkillMultiplierPoint(),
	GetSniperSkillMultiplierAmmo(),
	GetSniperSkillMultiplierPoint());

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Weapon Multiplier", weaponInfo, !">>", !"X");
	return true;
}
