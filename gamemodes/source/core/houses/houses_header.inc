/*	Built-in include guard */
#if defined _inc_houses_header
	#undef _inc_houses_header
#endif


/*	Custom include guard */
#if defined _houses_header_included
	#endinput
#endif
#define _houses_header_included


#include	"house_constructor.pwn"

#include	"house_commands.pwn"

#include	"house_load_save.pwn"

#include	"house_textdraws.pwn"
