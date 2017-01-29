/*
	Adds a list of live AI associated with a mission to a que of live AI that will be deleted at a later time by the main thread
	call as [ [list of AI], time] call blck_fnc_addLiveAItoQue; where time is the time delay before deletion occurs
	
	by Ghostrider-DbD-
	Last modified 1-14-17
*/
//diag_log format["_fnc_addLiveAIToQue:: -> when called, blck_liveMissionAI = %1",blck_liveMissionAI];
params["_aiList","_timeDelay"];
diag_log format["_fnc_addLiveAIToQue::  -->> _aiList = %1 || _timeDelay = %2",_aiList,_timeDelay];
blck_liveMissionAI pushback [_aiList, (diag_tickTime + _timeDelay)];
//diag_log format["_fnc_addLiveAIToQue:: -> blck_fnc_addLiveAI updated to %1",blck_liveMissionAI];

