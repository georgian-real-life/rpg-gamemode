//'Default' colours
#define		COLOUR_LIGHT_ERROR		0xDE3126FF
#define		COLOUR_INFORMATION		0xF7E54BFF
#define		COLOUR_WHITE			0xFFFFFFFF
#define		COLOUR_GREEN			0x1E711BFF
#define		COLOUR_PURPLE			0xC2A2DAAA
#define		COLOUR_LIGHT_GREY		0x7E868CAA
#define		COLOUR_LIGHT_CREAM		0xFFFDD0AA
#define		COLOUR_LIGHT_BLUE		0x1E90EAAA
#define		COLOUR_LIGHT_ORANGE		0xF5782CAA

//Colours for administrators
#define		COLOUR_ADMIN_RED		0x800E0EFF


//Colours for factions
#define		COLOUR_LSPD				0x8080FFAA


#define RGBAtoARGB(%0)				(((%0) >>> 8) & 0xFFFFFF)

#define		RGB%0(%1,%2,%3) ((((%1) & 0xff) << 16) | (((%2) & 0xff) << 8) | ((%3) & 0xff))
#define		RGBA%0(%1,%2,%3,%4) ((RGB(%1,%2,%3) << 8) | ((%4) & 0xff))
#define		ARGB%0(%1,%2,%3,%4) ((RGB(%1,%2,%3)) | (((%4) & 0xff) << 24))

#define		RGBA2ARGB%0(%1) ((((%1) & 0xffffff00) >>> 8) | (((%1) & 0x000000ff) << 24))
#define		RGBA2RGB%0(%1) (((%1) & 0xffffff00) >>> 8)
#define		ARGB2RGBA%0(%1) ((((%1) & 0x000000ff) << 8) | (((%1) & 0xff000000) >>> 24))
#define		ARGB2RGB%0(%1) (((%1) & 0x00ffffff))


// SIMPLE USAGFE COLOUR<WHITE>

#define		@COLOUR@ALICEBLUE<%1,%2>						%1F0F8FF%2
#define		@COLOUR@ANTIQUEWHITE<%1,%2>						%1FAEBD7%2
#define		@COLOUR@AQUA<%1,%2>								%100FFFF%2
#define		@COLOUR@AQUAMARINE<%1,%2>						%17FFFD4%2
#define		@COLOUR@AZURE<%1,%2>							%1F0FFFF%2
#define		@COLOUR@BEIGE<%1,%2>							%1F5F5DC%2
#define		@COLOUR@BISQUE<%1,%2>							%1FFE4C4%2
#define		@COLOUR@BLACK<%1,%2>							%1000000%2
#define		@COLOUR@BLANCHEDALMOND<%1,%2>					%1FFEBCD%2
#define		@COLOUR@BLUE<%1,%2>								%10000FF%2
#define		@COLOUR@BLUEVIOLET<%1,%2>						%18A2BE2%2
#define		@COLOUR@BROWN<%1,%2>							%1A52A2A%2
#define		@COLOUR@BURLYWOOD<%1,%2>						%1DEB887%2
#define		@COLOUR@CADETBLUE<%1,%2>						%15F9EA0%2
#define		@COLOUR@CHARTREUSE<%1,%2>						%17FFF00%2
#define		@COLOUR@CHOCOLATE<%1,%2>						%1D2691E%2
#define		@COLOUR@CORAL<%1,%2>							%1FF7F50%2
#define		@COLOUR@CORNFLOWERBLUE<%1,%2>					%16495ED%2
#define		@COLOUR@CORNSILK<%1,%2>							%1FFF8DC%2
#define		@COLOUR@CRIMSON<%1,%2>							%1DC143C%2
#define		@COLOUR@CYAN<%1,%2>								%100FFFF%2
#define		@COLOUR@DARKBLUE<%1,%2>							%100008B%2
#define		@COLOUR@DARKCYAN<%1,%2>							%1008B8B%2
#define		@COLOUR@DARKGOLDENROD<%1,%2>					%1B8860B%2
#define		@COLOUR@DARKGRAY<%1,%2>							%1A9A9A9%2
#define		@COLOUR@DARKGREY<%1,%2>							%1A9A9A9%2
#define		@COLOUR@DARKGREEN<%1,%2>						%1006400%2
#define		@COLOUR@DARKKHAKI<%1,%2>						%1BDB76B%2
#define		@COLOUR@DARKMAGENTA<%1,%2>						%18B008B%2
#define		@COLOUR@DARKOLIVEGREEN<%1,%2>					%1556B2F%2
#define		@COLOUR@DARKORANGE<%1,%2>						%1FF8C00%2
#define		@COLOUR@DARKORCHID<%1,%2>						%19932CC%2
#define		@COLOUR@DARKRED<%1,%2>							%18B0000%2
#define		@COLOUR@DARKSALMON<%1,%2>						%1E9967A%2
#define		@COLOUR@DARKSEAGREEN<%1,%2>						%18FBC8F%2
#define		@COLOUR@DARKSLATEBLUE<%1,%2>					%1483D8B%2
#define		@COLOUR@DARKSLATEGRAY<%1,%2>					%12F4F4F%2
#define		@COLOUR@DARKSLATEGREY<%1,%2>					%12F4F4F%2
#define		@COLOUR@DARKTURQUOISE<%1,%2>					%100CED1%2
#define		@COLOUR@DARKVIOLET<%1,%2>						%19400D3%2
#define		@COLOUR@DEEPPINK<%1,%2>							%1FF1493%2
#define		@COLOUR@DEEPSKYBLUE<%1,%2>						%100BFFF%2
#define		@COLOUR@DIMGRAY<%1,%2>							%1696969%2
#define		@COLOUR@DIMGREY<%1,%2>							%1696969%2
#define		@COLOUR@DODGERBLUE<%1,%2>						%11E90FF%2
#define		@COLOUR@FIREBRICK<%1,%2>						%1B22222%2
#define		@COLOUR@FLORALWHITE<%1,%2>						%1FFFAF0%2
#define		@COLOUR@FORESTGREEN<%1,%2>						%1228B22%2
#define		@COLOUR@FUCHSIA<%1,%2>							%1FF00FF%2
#define		@COLOUR@GAINSBORO<%1,%2>						%1DCDCDC%2
#define		@COLOUR@GHOSTWHITE<%1,%2>						%1F8F8FF%2
#define		@COLOUR@GOLD<%1,%2>								%1FFD700%2
#define		@COLOUR@GOLDENROD<%1,%2>						%1DAA520%2
#define		@COLOUR@GRAY<%1,%2>								%1808080%2
#define		@COLOUR@GREY<%1,%2>								%1808080%2
#define		@COLOUR@GREEN<%1,%2>							%1008000%2
#define		@COLOUR@GREENYELLOW<%1,%2>						%1ADFF2F%2
#define		@COLOUR@HONEYDEW<%1,%2>							%1F0FFF0%2
#define		@COLOUR@HOTPINK<%1,%2>							%1FF69B4%2
#define		@COLOUR@INDIANRED<%1,%2>						%1CD5C5C%2
#define		@COLOUR@INDIGO<%1,%2>							%14B0082%2
#define		@COLOUR@IVORY<%1,%2>							%1FFFFF0%2
#define		@COLOUR@KHAKI<%1,%2>							%1F0E68C%2
#define		@COLOUR@LAVENDER<%1,%2>							%1E6E6FA%2
#define		@COLOUR@LAVENDERBLUSH<%1,%2>					%1FFF0F5%2
#define		@COLOUR@LAWNGREEN<%1,%2>						%17CFC00%2
#define		@COLOUR@LEMONCHIFFON<%1,%2>						%1FFFACD%2
#define		@COLOUR@LIGHTBLUE<%1,%2>						%1ADD8E6%2
#define		@COLOUR@LIGHTCORAL<%1,%2>						%1F08080%2
#define		@COLOUR@LIGHTCYAN<%1,%2>						%1E0FFFF%2
#define		@COLOUR@LIGHTGOLDENRODYELLOW<%1,%2>				%1FAFAD2%2
#define		@COLOUR@LIGHTGRAY<%1,%2>						%1D3D3D3%2
#define		@COLOUR@LIGHTGREY<%1,%2>						%1D3D3D3%2
#define		@COLOUR@LIGHTGREEN<%1,%2>						%190EE90%2
#define		@COLOUR@LIGHTPINK<%1,%2>						%1FFB6C1%2
#define		@COLOUR@LIGHTSALMON<%1,%2>						%1FFA07A%2
#define		@COLOUR@LIGHTSEAGREEN<%1,%2>					%120B2AA%2
#define		@COLOUR@LIGHTSKYBLUE<%1,%2>						%187CEFA%2
#define		@COLOUR@LIGHTSLATEGRAY<%1,%2>					%1778899%2
#define		@COLOUR@LIGHTSLATEGREY<%1,%2>					%1778899%2
#define		@COLOUR@LIGHTSTEELBLUE<%1,%2>					%1B0C4DE%2
#define		@COLOUR@LIGHTYELLOW<%1,%2>						%1FFFFE0%2
#define		@COLOUR@LIME<%1,%2>								%100FF00%2
#define		@COLOUR@LIMEGREEN<%1,%2>						%132CD32%2
#define		@COLOUR@LINEN<%1,%2>							%1FAF0E6%2
#define		@COLOUR@MAGENTA<%1,%2>							%1FF00FF%2
#define		@COLOUR@MAROON<%1,%2>							%1800000%2
#define		@COLOUR@MEDIUMAQUAMARINE<%1,%2>					%166CDAA%2
#define		@COLOUR@MEDIUMBLUE<%1,%2>						%10000CD%2
#define		@COLOUR@MEDIUMORCHID<%1,%2>						%1BA55D3%2
#define		@COLOUR@MEDIUMPURPLE<%1,%2>						%19370DB%2
#define		@COLOUR@MEDIUMSEAGREEN<%1,%2>					%13CB371%2
#define		@COLOUR@MEDIUMSLATEBLUE<%1,%2>					%17B68EE%2
#define		@COLOUR@MEDIUMSPRINGGREEN<%1,%2>				%100FA9A%2
#define		@COLOUR@MEDIUMTURQUOISE<%1,%2>					%148D1CC%2
#define		@COLOUR@MEDIUMVIOLETRED<%1,%2>					%1C71585%2
#define		@COLOUR@MIDNIGHTBLUE<%1,%2>						%1191970%2
#define		@COLOUR@MINTCREAM<%1,%2>						%1F5FFFA%2
#define		@COLOUR@MISTYROSE<%1,%2>						%1FFE4E1%2
#define		@COLOUR@MOCCASIN<%1,%2>							%1FFE4B5%2
#define		@COLOUR@NAVAJOWHITE<%1,%2>						%1FFDEAD%2
#define		@COLOUR@NAVY<%1,%2>								%1000080%2
#define		@COLOUR@OLDLACE<%1,%2>							%1FDF5E6%2
#define		@COLOUR@OLIVE<%1,%2>							%1808000%2
#define		@COLOUR@OLIVEDRAB<%1,%2>						%16B8E23%2
#define		@COLOUR@ORANGE<%1,%2>							%1FFA500%2
#define		@COLOUR@ORANGERED<%1,%2>						%1FF4500%2
#define		@COLOUR@ORCHID<%1,%2>							%1DA70D6%2
#define		@COLOUR@PALEGOLDENROD<%1,%2>					%1EEE8AA%2
#define		@COLOUR@PALEGREEN<%1,%2>						%198FB98%2
#define		@COLOUR@PALETURQUOISE<%1,%2>					%1AFEEEE%2
#define		@COLOUR@PALEVIOLETRED<%1,%2>					%1DB7093%2
#define		@COLOUR@PAPAYAWHIP<%1,%2>						%1FFEFD5%2
#define		@COLOUR@PEACHPUFF<%1,%2>						%1FFDAB9%2
#define		@COLOUR@PERU<%1,%2>								%1CD853F%2
#define		@COLOUR@PINK<%1,%2>								%1FFC0CB%2
#define		@COLOUR@PLUM<%1,%2>								%1DDA0DD%2
#define		@COLOUR@POWDERBLUE<%1,%2>						%1B0E0E6%2
#define		@COLOUR@PURPLE<%1,%2>							%1800080%2
#define		@COLOUR@REBECCAPURPLE<%1,%2>					%1663399%2
#define		@COLOUR@RED<%1,%2>								%1FF0000%2
#define		@COLOUR@ROSYBROWN<%1,%2>						%1BC8F8F%2
#define		@COLOUR@ROYALBLUE<%1,%2>						%14169E1%2
#define		@COLOUR@SADDLEBROWN<%1,%2>						%18B4513%2
#define		@COLOUR@SALMON<%1,%2>							%1FA8072%2
#define		@COLOUR@SANDYBROWN<%1,%2>						%1F4A460%2
#define		@COLOUR@SEAGREEN<%1,%2>							%12E8B57%2
#define		@COLOUR@SEASHELL<%1,%2>							%1FFF5EE%2
#define		@COLOUR@SIENNA<%1,%2>							%1A0522D%2
#define		@COLOUR@SILVER<%1,%2>							%1C0C0C0%2
#define		@COLOUR@SKYBLUE<%1,%2>							%187CEEB%2
#define		@COLOUR@SLATEBLUE<%1,%2>						%16A5ACD%2
#define		@COLOUR@SLATEGRAY<%1,%2>						%1708090%2
#define		@COLOUR@SLATEGREY<%1,%2>						%1708090%2
#define		@COLOUR@SNOW<%1,%2>								%1FFFAFA%2
#define		@COLOUR@SPRINGGREEN<%1,%2>						%100FF7F%2
#define		@COLOUR@STEELBLUE<%1,%2>						%14682B4%2
#define		@COLOUR@TAN<%1,%2>								%1D2B48C%2
#define		@COLOUR@TEAL<%1,%2>								%1008080%2
#define		@COLOUR@THISTLE<%1,%2>							%1D8BFD8%2
#define		@COLOUR@TOMATO<%1,%2>							%1FF6347%2
#define		@COLOUR@TURQUOISE<%1,%2>						%140E0D0%2
#define		@COLOUR@VIOLET<%1,%2>							%1EE82EE%2
#define		@COLOUR@WHEAT<%1,%2>							%1F5DEB3%2
#define		@COLOUR@WHITE<%1,%2>							%1FFFFFF%2
#define		@COLOUR@WHITESMOKE<%1,%2>						%1F5F5F5%2
#define		@COLOUR@YELLOW<%1,%2>							%1FFFF00%2
#define		@COLOUR@YELLOWGREEN<%1,%2>						%19ACD32%2

#define		COLOUR%0<%1> (@COLOUR@%1<0x,ff>)
#define		COLOURA%0<%1,%2> (@COLOUR@%1<0x,%2>)
#define		SCOLOUR%0<%1> (#@COLOUR@%1<\x7B;,\x7D;>)
