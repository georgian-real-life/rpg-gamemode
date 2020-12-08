#if defined BCRYPT_HASH_LENGTH
	#error BCRYPT_HASH_LENGTH is already defined
#endif
#define		BCRYPT_HASH_LENGTH		250

#if defined BCRYPT_HASH_COST
	#error BCRYPT_HASH_COST is already defined
#endif
#define		BCRYPT_HASH_COST		4


#include	<YSI_Coding\y_hooks>


hook OnScriptInit()
{
	bcrypt_set_thread_limit(3);
	return true;
}
