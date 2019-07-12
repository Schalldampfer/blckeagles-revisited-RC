/*
	blck_fnc_ai_offloadToClients
	Addapted for blckeagls from:
    DMS_fnc_AILocalityManager
	Created by Defent and eraser1
	https://github.com/Defent/DMS_Exile/wiki/DMS_fnc_AILocalityManager
	Offloads AI groups to a nearby client in order to improve server performance.
*/
private ["_groups"];
if (!blck_ai_offload_to_client) exitWith {};
if (blck_limit_ai_offload_to_blckeagls) then {_groups = blck_monitoredMissionAIGroups} else {_groups = allGroups};

{
	if (((count (units _x))>1) && {!(_x getVariable ["blck_LockLocality",false])} && {!(blck_ai_offload_Only_blck_AI && {!(_x getVariable ["blck_SpawnedGroup",false])})}) then
	{
		private _leader = leader _x;
		private _group = _x;
		if !(isPlayer _leader) then
		{
			// Ignore Exile flyovers.
			//if (((side _group) isEqualTo independent) && {(count (units _group)) isEqualTo 1}) exitWith {};
			#ifdef blck_debugMode
			if (blck_debugOn) then
			{
				(format ["AILocalityManager :: Finding owner for group: %1",_group]) call blck_fnc_DebugLog;
			};
			#endif
			private _groupOwner = groupOwner _group;
			private _ownerObj = objNull;
			private _isLocal = local _group;

			if !(_isLocal) then								// Only check for the group owner in players if it doesn't belong to the server.
			{
				{
					if (_groupOwner isEqualTo (owner _x)) exitWith
					{
						_ownerObj = _x;
					};
				} forEach allPlayers;
			};

			// If the owner doesn't exist or is too far away...				Attempt to set a new player owner, and if none are found...	and if the group doesn't belong to the server...
			if (((isNull _ownerObj) || {(_ownerObj distance2D _leader)>3500}) && {!([_group,_leader] call blck_fnc_SetAILocality)} && {!_isLocal}) then
			{
				// Reset locality to the server
				_group setGroupOwner 2;
				#ifdef blck_debugMode
				if (blck_debugOn) then
				{
					(format ["AILocalityManager :: Current owner of group %1 is too far away and no other viable owner found; resetting ownership to the server.",_group]) call DMS_fnc_DebugLog;
				};
				#endif
			};
		};
	};
} forEach _groups;