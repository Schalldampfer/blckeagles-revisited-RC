
/*
	calculate a reward player for AI Kills in crypto.
	Code fragment adapted from VEMF
	call as [_unit,_killer] call blck_fnc_rewardKiller;
	Last modified 6/3/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_unit","_killer"];
private["_reward","_maxReward","_dist","_killstreakReward","_distanceBonus","_newKillerScore","_newKillerFrags","_money"];
if (toLower(blck_modType) isEqualTo "Epoch") then
{
	if ( (vehicle _killer) in blck_forbidenVehicles || (currentWeapon _killer) in blck_forbidenVehicleGuns ) then 
	{
		_reward = 0;
	}
	else
	{
		_maxReward = 50;
		_dist = _unit distance _killer;
		_reward = 0;

		if (_dist < 50) then { _reward = _maxReward - (_maxReward / 1.25); _reward };
		if (_dist < 100) then { _reward = _maxReward - (_maxReward / 1.5); _reward };
		if (_dist < 800) then { _reward = _maxReward - (_maxReward / 2); _reward };
		if (_dist > 800) then { _reward = _maxReward - (_maxReward / 4); _reward };
		
		private _killstreakReward=+(_kills*2);
		if (blck_addAIMoney) then
		{
			[_killer,_reward + _killstreakReward] call blck_fnc_giveTakeCrypto;
		};
		if (blck_useKillScoreMessage) then
		{
			[["showScore",[_reward,"",_kills],""],[_killer]] call blck_fnc_messageplayers;
		};
	};
};

if (toLower(blck_modType) isEqualTo "Exile") then
{
	private["_distanceBonus","_overallRespectChange","_newKillerScore","_newKillerFrags","_maxReward","_money","_message"];
	if ( (isPlayer _killer) && (_killer getVariable["ExileHunger",0] > 0) && (_killer getVariable["ExileThirst",0] > 0) ) then
	{
		_distanceBonus = floor((_unit distance _killer)/100);
		_killstreakBonus = 3 * (_killer getVariable["blck_kills",0]);
		_respectGained = 25 + _distanceBonus + _killstreakBonus;
		_score = _killer getVariable ["ExileScore", 0];
		_score = _score + (_respectGained);
		_killer setVariable ["ExileScore", _score];
		format["setAccountScore:%1:%2", _score,getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		_newKillerFrags = _killer getVariable ["ExileKills", 0];
		_newKillerFrags = _newKillerFrags + 1;
		_killer setVariable ["ExileKills", _newKillerFrags];
		format["addAccountKill:%1", getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		_killer call ExileServer_object_player_sendStatsUpdate;
		if (blck_useKillScoreMessage) then
		{
			[["showScore",[_respectGained,_distanceBonus,_kills]], [_killer]] call blck_fnc_messageplayers;
		};
	};
};
