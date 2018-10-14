

params["_coords","range"];
private["_return","_playerClassNames","_epochClasses","_exileClasses"];
_epochClasses = ["Epoch_Female_F","Epoch_Male_F"];
_exileClasses = ["Exile_Unit_Player"];
if (blck_modType isEqualTo "Epoch") then {_playerClassNames = _epochClasses};
if (blck_modType isEqualTo "Exile") then {_playerClassNames = _exileClasses};
_return = nearestObjects[_coords,_playerClassNames,_range];
_return