
params["_entity","_isLocal"];
diag_log format["_EH_changeLocality call with params = %1 | typeOf _entity %2 | _isLocal %3",_this,typeOf _entity,_isLocal];
if (isServer) then {[_entity] call blck_fnc_checkForEmptyVehicles}
else {};
