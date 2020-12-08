/*	Built-in include guard */
#if defined _inc_anticheat_header
	#undef _inc_anticheat_header
#endif

/*	Custom include guard */
#if defined _anticheat_header_included
	#endinput
#endif
#define _anticheat_header_included


#include	"anticheat_constructor.pwn"

#include	"anticheat_handler.pwn"

#include	"anticheat_functions.pwn"
