/*	Built-in include guard */
#if defined _inc_account_header
	#undef _inc_account_header
#endif

/*	Custom include guard */
#if defined _account_header_included
	#endinput
#endif
#define _account_header_included


#include	"account_setup_init.pwn"

#include	"account_connection.pwn"

#include	"account_authorization.pwn"

#include	"account_registration.pwn"

#include	"account_character_creation.pwn"
