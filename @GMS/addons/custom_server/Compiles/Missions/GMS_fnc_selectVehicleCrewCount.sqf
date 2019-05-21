
params["_diff"];
private ["_count"];
switch (toLower(_diff)) do
{
	case "blue": {_count = blck_vehCrew_blue};
	case "red": {_count = blck_vehCrew_red};
	case "green": {_count = blck_vehCrew_green};
	case "orange": {_count = blck_vehCrew_orange};
};
_count
