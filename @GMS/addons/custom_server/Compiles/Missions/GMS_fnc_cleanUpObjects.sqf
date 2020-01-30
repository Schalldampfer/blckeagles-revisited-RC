	// Delete objects in a list after a certain time.
	// code to delete any smoking or on fire objects adapted from kalania 
	//http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page1
	// http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page2
/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//diag_log format["_fnc_cleanUpObjects: time %1 | count blck_oldMissionObjects %2",diag_tickTime,count blck_oldMissionObjects];

for "_i" from 1 to (count blck_oldMissionObjects) do {
	if (_i <= count blck_oldMissionObjects) then {
		private _oldObjs = blck_oldMissionObjects deleteAt 0;
		_oldObjs params ["_missionCenter","_objarr","_timer"];
		if (diag_tickTime > _timer) then 
		{
			private _nearplayer = [_missionCenter,800] call blck_fnc_nearestPlayers;
			if (_nearPlayer isEqualTo []) then 
			{
				//diag_log format["_fnc_cleanUpObjects: _nearPlayer = %1 | _missionCenter = %2 | _objarr = %3",_nearplayer,_missionCenter,_objarr];
				{deleteVehicle _x}forEach _objarr;
			} else {
				blck_oldMissionObjects pushback _oldObjs;
			};
		} else {
			blck_oldMissionObjects pushback _oldObjs;
		};
	};
};
