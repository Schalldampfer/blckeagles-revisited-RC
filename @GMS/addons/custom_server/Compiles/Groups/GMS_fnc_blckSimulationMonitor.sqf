/*
	Managages simulation using blckeagls logic 	
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
private["_playerType","_players"];

switch (toLower(blck_modType)) do
{
	case "exile": {_playerType = ["Exile_Unit_Player"]};
	case "epoch": {_playerType = ["Epoch_Male_F","Epoch_Female_F"]};
};
{
	private _players = (leader _x) nearEntities [_playerType, blck_simulationEnabledDistance];
	if (count _players > 0) then
	{
		private _group = _x;
		if (blck_revealMode isEqualTo "detailed") then
		{	
			{		
				_x enableSimulationGlobal  true;
				(_players select 0) reveal _x;  //  Force simulation on
			}forEach (units _group);
		} else {
			_x enableSimulationGlobal  true;
			(_players select 0) reveal _x;  //  Force simulation on
		};
	}else{
			{_x enableSimulationGlobal false}forEach (units _x);	
	};
} forEach blck_monitoredMissionAIGroups;
