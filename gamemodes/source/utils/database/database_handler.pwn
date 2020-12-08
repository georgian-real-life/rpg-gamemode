#include	<YSI_Coding\y_hooks>


#if defined	mysql_host
	#error	mysql_host is already defined
#endif
#define		mysql_host		"localhost"

#if defined mysql_user
	#error mysql_user is already defined
#endif
#define		mysql_user		"root"

#if defined mysql_pass
	#error mysql_pass is already defined
#endif
#define		mysql_pass		""

#if defined mysql_db
	#error mysql_db is already defined
#endif
#define		mysql_db		"serverdb"


static MySQL:DB_HANDLER;


hook OnScriptInit()
{
	DB_Connect(mysql_host, mysql_user, mysql_pass, mysql_db);
	return 1;
}


MySQL:DB_SetHandler(const MySQL:value)
{
	return DB_HANDLER = value;
}

MySQL:DB_GetHandler()
{
	return DB_HANDLER;
}


static DB_Connect(const host[], const user[], const password[], const database[])
{
	DB_SetHandler(mysql_connect(host, user, password, database));
	switch(mysql_errno(DB_GetHandler()))
	{
		case 0:
		{
			print(!"[MySQL] Connection established successfully");
		}
		default:
		{
			print(!"[MySQL] Connection failed\nShutting down the server");
			//SendRconCommand("exit");
		}
	}
	mysql_log(ERROR | WARNING);
	return 1;
}
