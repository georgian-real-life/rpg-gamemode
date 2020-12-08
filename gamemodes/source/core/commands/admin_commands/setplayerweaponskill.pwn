alias:setplayerweaponskill("setskill")

CMD:setplayerweaponskill(playerid, const params[])
{
	if (GetPlayerAdminLevel(playerid) == 0 || GetPlayerAdminAuthentication(playerid) == 0)
	{
		return false;
	}

	new targetid;
	if (sscanf(params, "i", targetid))
	{
		SendClientMessage(playerid, COLOUR_INFORMATION, "Gamoiyenet brdzaneba /setplayerweaponskill [targetid]");
		return false;
	}

	if (!IsPlayerConnected(targetid) || !IsPlayerAuthorized(targetid))
	{
		return false;
	}

	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, inputtext, playerID

		if (!response)
		{
			return false;
		}


		new x;
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

			if (strlen(inputtextt) < 1 || strlen(inputtextt) > 4)
			{
				return false;
			}

			x = strval(inputtextt);

			switch (listitem)
			{
				case WEAPONSKILL_PISTOL:
				{
					SetPlayerWeaponSkillPistol(targetid, x);
				}

				case WEAPONSKILL_PISTOL_SILENCED:
				{
					SetPlayerWeaponSkillSilencedPi(targetid, x);
				}

				case WEAPONSKILL_DESERT_EAGLE:
				{
					SetPlayerWeaponSkillDesertEagle(targetid, x);
				}

				case WEAPONSKILL_SHOTGUN:
				{
					SetPlayerWeaponSkillShotGun(targetid, x);
				}

				case WEAPONSKILL_SAWNOFF_SHOTGUN:
				{
					SetPlayerWeaponSkillSawnOff(targetid, x);
				}

				case WEAPONSKILL_SPAS12_SHOTGUN:
				{
					SetPlayerWeaponSkillSpaz12(targetid, x);
				}

				case WEAPONSKILL_MICRO_UZI:
				{
					SetPlayerWeaponSkillMicroUzi(targetid, x);
				}

				case WEAPONSKILL_MP5:
				{
					SetPlayerWeaponSkillMP5(targetid, x);
				}

				case WEAPONSKILL_AK47:
				{
					SetPlayerWeaponSkillAK47(targetid, x);
				}

				case WEAPONSKILL_M4:
				{
					SetPlayerWeaponSkillM4(targetid, x);
				}

				case WEAPONSKILL_SNIPERRIFLE:
				{
					SetPlayerWeaponSkillSniperRifle(targetid, x);
				}

				default:
				{
					SetPlayerAllWeaponSkills(targetid, x);
				}
			}
			UpdatePlayerWeaponSkills(targetid);

			new text[144];
			format(text, sizeof text, "%s Administratorma %s shegicvalat tqven iaragis codnis done %d -ze", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), x);
			SendClientMessage(targetid, COLOUR_LIGHT_ERROR, text);

			format(text, sizeof text, "%s [AdminCMD] %s[%d] sheucvala iaragis codnis done %s[%d] %d -ze", FormatHex(COLOUR_LIGHT_ERROR), GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(targetid), targetid, x);
			SendAdminMessage(text);
		}
		Dialog_ShowCallback(playerid, using inline __response, DIALOG_STYLE_INPUT, !"{226db8} Weapon Skills", "Gtxovt sheiyvanot cifri 0 idan 999 mde", !">>", !"X");
	}

	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} Weapon Skills", \
		"[0] 9mm\n\
		[1] Silenced Pistol\n\
		[2] Desert Eagle\n\
		[3] Shotgun\n\
		[4] SawnOff Shotgun\n\
		[5] Spaz12\n\
		[6] SMG\n\
		[7] MP5\n\
		[8] AK-47\n\
		[9] M4\n\
		[10] Sniper Rifle\n\
		[11] All of them" ,!">>", !"X");
	return true;
}
