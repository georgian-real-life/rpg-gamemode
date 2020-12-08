CMD:gps(playerid, params)
{
	inline _response(playerID, dialogID, response, listitem, string:inputtext[])
	{
		#pragma unused dialogID, inputtext, playerID

		if (response)
		{
			switch (listitem)
			{
				case 2:
				{
					inline __response(playerIDD, dialogIDD, responsee, listitemm, string:inputtextt[])
					{
						#pragma unused playerIDD, dialogIDD, responsee, listitemm, inputtextt

						if (responsee)
						{
							switch (listitem)
							{
								case 2:
								{

								}
							}
							return true;
						}
						return false;
					}
					Dialog_ShowCallback(playerID, using inline __response, DIALOG_STYLE_LIST, !"{226db8} Samushaoebi", "workText", !">>", !"X");
				}
			}
			return true;
		}
		return false;
	}
	new gpsText[256];
	format(gpsText, sizeof gpsText, \
	"[1] Mtavari adgilebi\n\
	[2] Organizaciebi \n\
	[3] Samushao adgilebi \n\
	[4] Gasartobi adgilebi \n\
	[5] SaJmeli <3 \n\
	[6] Marketebi \n\
	[8] Benzin Gasamart Sadgurebi \n\
	");
	Dialog_ShowCallback(playerid, using inline _response, DIALOG_STYLE_LIST, !"{226db8} GPS", gpsText, !">>", !"X");
	return true;
}
