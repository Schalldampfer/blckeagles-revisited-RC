/*
	[] call blck_fnc_waypointMonitor;
	
	Scans all groups in  for those that have been stuck in a particular waypoint for an excessive time and checks if they are in combat. 
	If not it directs them to the next waypoint. 
	It uses a timestamp attached to the group that is cleared upon waypoint completion.
	
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";



