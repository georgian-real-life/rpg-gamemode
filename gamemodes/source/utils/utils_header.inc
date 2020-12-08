/*	Built-in include guard */
#if defined _inc_utils_header
	#undef _inc_utils_header
#endif

/*	Custom include guard */
#if defined _utils_header_included
	#endinput
#endif
#define _utils_header_included


#include	"colours.inc"

#include	"database\database_handler.pwn"

#include	"database\database_functions.pwn"

#include	"bcrypt\bcrypt_header.inc"

#include	"functions.pwn"

#include	"mapping.pwn"
