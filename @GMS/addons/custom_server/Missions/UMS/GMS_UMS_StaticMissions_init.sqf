/*
	by Ghostrider [GRG]
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_path","_staticMissions"];
{
	if ((toLower worldName) isEqualTo toLower(_x select 1)) then
	{
		if ((toLower blck_modType) isEqualTo (toLower(_x select 0))) then
		{
			call compilefinal preprocessFileLineNumbers format["\q\addons\custom_server\Missions\UMS\staticMissions\%1",(_x select 2)];
		};
	};
}forEach _staticMissions;