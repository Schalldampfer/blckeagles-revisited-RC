
//diag_log format["_fnc_nearestPlayers: _this = %1",_this];
params["_coords","_range"];
private["_return","_playerClassNames","_epochClasses","_exileClasses"];
if (blck_modType isEqualTo "Epoch") then {_playerClassNames = ["Epoch_Female_F","Epoch_Male_F"]};
if (blck_modType isEqualTo "Exile") then {_playerClassNames = ["Exile_Unit_Player"]};
_return = nearestObjects[_coords,_playerClassNames,_range];
_return