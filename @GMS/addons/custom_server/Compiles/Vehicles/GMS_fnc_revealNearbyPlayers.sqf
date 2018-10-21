
/*
	algorhytm one: pure chance base on inverse of distance. More efficient.
	algorhythm two: based on canSee. More detailed.
*/

params["_vehicle","_searchRadius","_detectionOdds"];
private["_player","_detectionOdds","_nearbyPlayers","_knowsAbout","_cansee","_knowledgeGained"];
_nearbyPlayers = [position _vehicle, _vehicle getVariable["blck_vehicleSearchRange",500]] call blck_fnc_nearestPlayers;

if (blck_revealMode isEqualTo "detailed") then
{
	private["_crew","_group"];
	_crew = crew _vehicle;
	_group = group(_crew select 0);
	{
		if (random(1) < _detectionOdds) then 
		{
			_player = _x;
			{
				_cansee = [objNull, "VIEW"] checkVisibility [eyePos _x, position _player];
				if (_cansee > 0) then
				{
					_knowledgeGained = _cansee;
				} else {
					_knowledgeGained = _x knowsAbout _player;
					if (_knowledgeGained == 0) then {_knowledgeGained = 0.1};
				};
				_x reveal[_player,_knowledgeGained];
				//diag_log format["_fnc_revealNearbyPlayers: player %1 revealed to unit %2",_player,_x];
			}forEach _crew;
		};
	}forEach _nearbyPlayers;
};

if (blck_revealMode isEqualTo "basic") then
{
	{
		_player = _x;
		if (random(1) < _detectionOdds) then 
		{
			_knowsAbout = (_vehicle) knowsAbout _player;
			if (_knowsAbout > 0) then
			{
				_knowledgeGained = _knowsAbout;
			} else {
				_knowledgeGained = (_searchRadius  - (_x distance _vehicle))/_searchRadius;
			};
			_x reveal[_player, _knowledgeGained];
		};
	}forEach _nearbyPlayers;
};