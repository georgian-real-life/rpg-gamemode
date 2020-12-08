/*	Built-in include guard */
#if defined _inc_server_header
	#undef _inc_server_header
#endif

/*	Custom include guard */
#if defined _server_header_included
	#endinput
#endif
#define _server_header_included


#include	"server_config.pwn"

#include	"server_textdraws.pwn"

#include	"server_misc.pwn"
