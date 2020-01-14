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

// Static missions
private _pathStaticMissions = "\Static\missions";
private _staticMissions = [
	// [mod (Epoch, Exile), map (Altis, Tanoa etc), mission center, eg [10445,2014,0], filename.sqf (name of static mission template for that mission)];
	//["Epoch","Altis","template.sqf"],
	//["Epoch","Altis","staticMissionExample2_Epoch.sqf"],
	//["Exile","Altis","template.sqf"],	
	["Exile","Altis","staticMissionExample2_Exile.sqf"],
	["newmission","newmap","somescript.sqf"]  //  Here just so you dont have to worry about all those commas
];

// Static water/underwater missions 
private _pathStaticUnderwaterMissions = "\UMS\staticMissions";
private _staticUnderwaterMissions = [
	// [mod (Epoch, Exile), map (Altis, Tanoa etc), mission center, eg [10445,2014,0], filename.sqf (name of static mission template for that mission)];
	//["Epoch","Altis","staticMissionExample2_Epoch.sqf"],
	["Exile","Altis","staticMissionExample2_Exile.sqf"]
];

private _pathUMS = "UMS\dynamicMissions";
private _missionListDynamicUMS = ["default"];

private _pathBlue = "Blue";
_missionListBlue = ["default"/*,"hostage1","captive1","default2","medicalCamp","redCamp","resupplyCamp"*/];

_pathRed = "Red";
_missionListRed = [/*"default","resupplyCamp","medicalCamp","hostage1","captive1",*/"redCamp"];

private ["_missionListGreen"];
_pathGreen = "Green";
_missionListGreen = [/*"default","default2",/*"medicalCamp","redCamp","resupplyCamp",*/"resupplyCamp"];

_pathOrange = "Orange";
_missionListOrange = [/*"default",*/"medicalCamp"/*,"redCamp","resupplyCamp"*/];
