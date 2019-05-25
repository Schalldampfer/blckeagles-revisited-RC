
/*
	_fnc_alertNearestGroup
*/

params["_group"];
private _nearbyGroup = [group _unit] call blck_fnc_findNearestGroup;
{
	_x reveal[_killer,(_x knowsAbout _killer) + (_unit getVariable ["intelligence",1])];
}forEach (units _nearbyGroup);
