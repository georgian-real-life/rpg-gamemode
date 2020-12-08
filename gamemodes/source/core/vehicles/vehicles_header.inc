/*	Built-in include guard */
#if defined _inc_vehicles_header
	#undef _inc_vehicles_header
#endif

/*	Custom include guard */
#if defined _vehicles_header_included
	#endinput
#endif
#define _vehicles_header_included


#include	"vehicle_defines.inc"

#include	"vehicle_data.pwn"

#include	"vehicles_structure.pwn"

#include	"vehicles_load_save.pwn"

#include	"vehicle_functions.pwn"

#include	"vehicle_components.pwn"
