/*

	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_pathScouts","_missionListScouts","_pathHunters","_missionListHunters","_pathBlue","_missionListBlue","_pathRed","_missionListRed","_pathGreen","_missionListGreen","_pathOrange","_missionListOrange"];



_pathUMS = "UMS\dynamicMissions";
_missionListUMS = ["default"];

_pathBlue = "Blue";
//_missionListBlue = ["hostage1"];
_missionListBlue = ["default","captive1","hostage1"/*,"default2"/*,"medicalCamp","redCamp","resupplyCamp"*/];

_pathRed = "Red";
//_missionListRed = ["resupplyCamp"];
_missionListRed = [/*"default","default2","medicalCamp",*/"redCamp"/*,"resupplyCamp"*/];

_pathGreen = "Green";
//_missionListGreen = ["resupplyCamp"];
_missionListGreen = [/*"default","default2",/*"redCamp",*//*"resupplyCamp",*/"medicalCamp"];

_pathOrange = "Orange";
//_missionListOrange = ["resupplyCamp"];
_missionListOrange = [/*"default","default2","medicalCamp","redCamp",*/"resupplyCamp"];
