/*
	by Ghostrider [GRG]
	Last Modified 3/14/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

///////////////////////////////////////////////
//  prevent the system from being started twice
//////////////////////////////////////////////
if !(isNil "blck_missionSystemRunning") exitWith {};
blck_missionSystemRunning = true;

/////////////////////////////////////////////
//  Run the initialization routinge
////////////////////////////////////////////

if (isServer) then 
{
	diag_log format["blck_fnc_init <SERVER> called at %1",diag_tickTime];
	private _initFunc = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\init\blck_init_server.sqf";
	//private _script = [] execVM "\q\addons\custom_server\init\blck_init_server.sqf";
	[] spawn _initFunc;
	//waitUntil {scriptDone _script};
	diag_log format["blck_fnc_init: initialization scripts done at %1",diag_tickTime];
};
if (!isServer && !hasInterface) then 
{
	diag_log format["Loading blackeagls for headless clients"];
	[] execVM "\q\addons\custom_server\init\blck_init_HC.sqf";
};

/*
	TODO 
	Check patrol radius for Air units, Ship units, land vehicle units, and infantry, both static and dynamically spawned.

*/
