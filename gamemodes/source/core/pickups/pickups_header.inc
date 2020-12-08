/*	Built-in include guard */
#if defined _inc_pickups_header
	#undef _inc_pickups_header
#endif

/*	Custom include guard */
#if defined _pickups_header_included
	#endinput
#endif
#define _pickups_header_included


#include	"pickups_structure.pwn"

#include	"pickups_load_save.pwn"

#include	"pickups_handler.pwn"
