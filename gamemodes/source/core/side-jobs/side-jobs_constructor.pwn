#if !defined MAX_JOBS
	#define MAX_JOBS 15
#endif

#if !defined MAX_JOB_NAME
	#define MAX_JOB_NAME 120
#endif

#if !defined MAX_JOB_WORKER_STATUS
	#define MAX_JOB_WORKER_STATUS (164)
#endif

//JOB TYPE DEFINES
#if !defined MAX_JOB_TYPES
	#define MAX_JOB_TYPES 	(JobType:50)
#endif

#if !defined INVALID_JOB_TYPE
	#define INVALID_JOB_TYPE	(JobType:-1)
#endif

#if !defined STARTING_JOB_TYPE
	#define STARTING_JOB_TYPE 	(JobType:0)
#endif

#if !defined INVALID_JOB_ID
	#define INVALID_JOB_ID (-1)
#endif

#if !defined INVALID_PLAYER_JOB
	#define INVALID_PLAYER_JOB (-1)
#endif

forward OnJobCreate(jobID, Float:jPos_X, Float:jPos_Y, Float:jPos_Z);
// PLAYER Callbacks
forward OnPlayerPickupJobPickup(playerid, jobID);
forward OnPlayerGetNewJob(playerid, jobID);
forward OnPlayerRemoveFromJob(playerid, jobID);



new
	JTYPworkerStatus[MAX_JOB_WORKER_STATUS][MAX_JOB_TYPES],
	JTYPpayment[MAX_JOB_TYPES],
	JTYPpickupID[MAX_JOB_TYPES]
;

new JobType:VAR__createdjtypes = STARTING_JOB_TYPE;

new
		jName[MAX_JOBS][MAX_JOB_NAME],
JobType:jobType[MAX_JOBS],
		jPickup[MAX_JOBS],

Float:	jPosition[MAX_JOBS][3];

new
	VAR__createdjobs = 0;

// Player Vars


new
		jf_pJob[MAX_PLAYERS],
		jf_paymentForPlayer[MAX_PLAYERS];



stock JobType:DefineJobType(jTypWorkerStatus[], jTypPayment, jTypPickupID = 1239)
{
	//Back-end
	strcat(JTYPworkerStatus[VAR__createdjtypes], jTypWorkerStatus, sizeof JTYPworkerStatus[VAR__createdjtypes]);
	JTYPpayment[VAR__createdjtypes] = JTYPpayment;
	JTYPpickupID[VAR__createdjtypes] = jTypPickupID
	return VAR__createdjtypes++;
}



stock CreateJob(jobName[], JobType:jType, Float:jPosition_X, Float:jPosition_Y, Float:jPosition_Z)
{
	//Back-end
	jobType[VAR__createdjobs] = jType;
	strcat(jName[VAR__createdjobs], jobName, sizeof jName[VAR__createdjobs]);
	jPosition[VAR__createdjobs][0] = jPosition_X;
	jPosition[VAR__createdjobs][1] = jPosition_Y;
	jPosition[VAR__createdjobs][2] = jPosition_Z;
	//Front-end
	jPickup[VAR__createdjobs] = CreatePickup(JTYPpickupID[jobType[VAR__createdjobs]], 21, jPosition_X, jPosition_Y, jPosition_Z);
	#if defined OnJobCreate
		CallLocalFunction("OnJobCreate", "dfff", VAR__createdjobs, jPosition_X, jPosition_Y, jPosition_Z);
	#endif
	return VAR__createdjobs++;
}



stock CountJobWorkers(jobID)
{
	new counted;
	foreach(new i : Player)
	{
		if(GetPlayerJob(i) == jobID) counted++;
	}
	return counted;
}



stock GetJobPayment(jobID)
{
	return jobID;//JTYPpayment[jobType[jobID]];
}



stock GetJobName(jobID, output[], len = sizeof(output))
{
	if(jobID == INVALID_JOB_ID) return printf("[JOB FRAMEWORK] ERROR: GetJobName | Invalid Job ID!");
	format(output, len, "%s", jName[jobID]);
	return 1;
}



stock GetJobWorkerStatus(jobID, output[], len = sizeof(output))
{
	if(jobID == INVALID_JOB_ID) return printf("[JOB FRAMEWORK] ERROR: GetJobWorkerStatus | Player Invalid Job!");
	format(output, len, "%s", JTYPworkerStatus[jobType[jobID]]);
	return 1;
}



stock JobsCreated()
{
	return VAR__createdjobs;
}



hook OnPlayerPickUpPickup(playerid, pickupid)
{
	for(new i; i<VAR__createdjobs;i++)
	{
		while(jPickup[i] == pickupid)
		{
			CallLocalFunction("OnPlayerPickupJobPickup", "dd", playerid, i);
			break;
		}
	}
	return 1;
}



hook OnPlayerConnect(playerid)
{
	SetPlayerJob(playerid, INVALID_PLAYER_JOB);
	return 1;
}



stock SetPlayerJob(playerid, jobid)
{
	jf_pJob[playerid] = jobid;
	jf_paymentForPlayer[playerid] = GetJobPayment(jobid);
	#if defined OnPlayerGetNewJob
		CallLocalFunction("OnPlayerGetNewJob", "dd", playerid, jobid);
	#endif
	return 1;
}



stock GetPlayerJob(playerid)
{
	return jf_pJob[playerid];
}



stock RemovePlayerFromJob(playerid)
{
	#if defined OnPlayerRemoveFromJob
		CallLocalFunction("OnPlayerRemoveFromJob", "dd", playerid, jf_pJob[playerid]);
	#endif
	jf_pJob[playerid] = -1;
	jf_paymentForPlayer[playerid] = -1;
	return 1;
}
