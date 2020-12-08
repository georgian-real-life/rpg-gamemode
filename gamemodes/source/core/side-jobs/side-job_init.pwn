#include <YSI_Coding\y_hooks>


new JobLabel[MAX_JOBS];


hook OnJobCreate(jobID, Float:jPos_X, Float:jPos_Y, Float:jPos_Z)
{
	new string[MAX_JOB_NAME + 40], job_Name[MAX_JOB_NAME];
	GetJobName(jobID, job_Name);
	format(string, sizeof(string), "{FF0000}Samushao\n{78F22C}Dasaxeleba {FFFFFF}- {78F22C}%s\nXelfasi {FFFFFF}- {78F22C}%d$", job_Name, GetJobPayment(jobID));
	JobLabel[jobID] = Create3DTextLabel(string, -1, jPos_X, jPos_Y, jPos_Z, 5.0, 0, 1);
	//DEBUG
	//printf("[JOB CREATED] Job Name: %s, Job Payment: %d", job_Name,GetJobPayment(jobID));
	return 1;
}

public OnPlayerGetNewJob(playerid, jobID)
{
	new string[MAX_JOB_WORKER_STATUS + 46], pWorkerStatus[MAX_JOB_WORKER_STATUS], job_Name[MAX_JOB_NAME];
	GetJobWorkerStatus(pMayChooseJob[playerid], pWorkerStatus);
  	format(string, sizeof(string), "Sheni samushaoa {FF0000}%s{FFFFFF}. Sheni xelfasi iqneba {45EA2F}%d${FFFFFF} !", pWorkerStatus, GetJobPayment(pMayChooseJob[playerid]));
   	SendClientMessage(playerid, -1, string);
   	format(string, sizeof(string), "{FF0000}Samushao\n{78F22C}Dasaxeleba {FFFFFF}- {78F22C}%s\nXelfasi {FFFFFF}- {78F22C}%d$\nAmjamad momushaveebi - %d", job_Name, GetJobPayment(jobID), CountJobWorkers(jobID));
   	Update3DTextLabelText(JobLabel[jobID], -1, string);
	return 1;
}

public OnPlayerRemoveFromJob(playerid, jobID)
{
	new string[MAX_JOB_WORKER_STATUS + 50], job_WorkerStatus[MAX_JOB_WORKER_STATUS];

	GetJobWorkerStatus(jobID, job_WorkerStatus);

	format(string, sizeof(string), "Shen agar xar {FF0000}%s!", job_WorkerStatus);
	SendClientMessage(playerid, -1, string);
	return 1;
}
