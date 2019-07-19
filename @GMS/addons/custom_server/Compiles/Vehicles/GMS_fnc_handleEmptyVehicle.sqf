/*
	By Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

//diag_log format["_fnc_handleEmptyVehicle: _this = %1",_this];
params["_veh"];
//diag_log format["_fnc_handleEmptyVehicle: vehicle %1 | count(crew _veh) = %2 | typoeOf _veh = %3 | description _veh = %4",_veh,count(crew _veh),typeOf _veh,gettext(configFile >> 'cfgWeapons' >> typeOf _veh >> 'displayName')];
if ({alive _x} count (crew _veh) == 0 || crew(_veh) isEqualTo []) then
{	
	//diag_log format["_fnc_handleEmptyVehicle: no units alive in vehicle %1",_veh, typeOf _veh,gettext (configFile >> 'cfgWeapons' >> typeOf _veh >> 'displayName')];
	if (_veh getVariable["GRG_vehType","none"] isEqualTo "emplaced") then
	{
		//diag_log format["_fnc_handleEmptyVehicle: emplaced weapon %1 being handled",_veh];
		if (blck_killEmptyStaticWeapons) then
		{
			//diag_log format["_fnc_handleEmptyVehicle: disabling static %1 and setting its delete time",_veh];
			_veh setDamage 1;
			_veh setVariable["blck_deleteAtTime",diag_tickTime + 60,true];
		}else {
			//diag_log format["_fnc_handleEmptyVehicle: releasing static %1 to players and setting a default delete timer",_veh];
			[_veh] call blck_fnc_releaseVehicleToPlayers;  //Call this from _processAIKill
			_veh setVariable["blck_DeleteAt",diag_tickTime + blck_vehicleDeleteTimer,true];
		};			
	} else {
		if (blck_killEmptyAIVehicles) then
		{
			//diag_log format["_fnc_handleEmptyVehicle: disabling vehicle %1 and setting a delete time",_veh];
			_veh setDamage 0.7;
			_veh setFuel 0;
			_veh setVariable["blck_deleteAtTime",diag_tickTime + 60];
		} else {
			//diag_log format["_fnc_handleEmptyVehicle: releasing vehicle %1 to players and setting a default delete timer",_veh];
			_veh setVariable["blck_deleteAtTime",diag_tickTime + blck_vehicleDeleteTimer,true];	
			[_veh] call blck_fnc_releaseVehicleToPlayers;
		};
	};			
};
 


