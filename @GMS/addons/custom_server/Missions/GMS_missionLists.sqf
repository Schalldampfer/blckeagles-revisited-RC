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
	["Epoch","Altis","template.sqf"],
	["Epoch","Altis","staticMissionExample2_Epoch.sqf"],
	//["Epoch","Altis","destroyer.sqf"],
	["Exile","Altis","template.sqf"],	
	["Exile","Altis","staticMissionExample2_Exile.sqf"],
	//["Epoch","Altis","chelnosiStatic.sqf"],
	//#ifndef blck_milServer
	//["Exile","Altis","chelnosiStatic.sqf"],
	//#endif
	["newmission","newmap","somescript.sqf"]  //  Here just so you dont have to worry about all those commas
];

// Static water/underwater missions 
private _pathStaticUnderwaterMissions = "\UMS\staticMissions";
private _staticUnderwaterMissions = [
	// [mod (Epoch, Exile), map (Altis, Tanoa etc), mission center, eg [10445,2014,0], filename.sqf (name of static mission template for that mission)];
	["Epoch","Altis","staticMissionExample2_Epoch.sqf"],
	["Exile","Altis","staticMissionExample2_Exile.sqf"]
];

private _pathScouts = "Scouts";
private _missionListScouts = ["Scouts"];

private _pathHunters = "Hunters";
private _missionListHunters = ["Hunters"];

private _pathUMS = "UMS\dynamicMissions";
private _missionListDynamicUMS = ["default"];

private _pathBlue = "Blue";
//_missionListBlue = ["hostage1"]; //["default_testing"];
_missionListBlue = ["default"/*,"hostage1","captive1"*/,"sniperBase","survivalSupplies"/*,"default2","medicalCamp","redCamp","resupplyCamp"*/];
//diag_log format["_missionLists: _missionListBlue = %1",_missionListBlue];
// Passed 

_pathRed = "Red";
if (blck_debugOn) then 
{
	_missionListRed = ["fuelDepot"];
} else {
	_missionListRed = [/*"default","default2","medicalCamp","hostage1","captive1",*/"fuelDepot","junkyardWilly","TraderBoss","carThieves"];
};
// Passed 
private ["_missionListGreen"];
_pathGreen = "Green";
if (blck_debugOn || blck_debugLevel > 0) then
{
	_missionListGreen = ["redCamp"/*,"colonelsBase","banditVillage"*/];
} else {
	_missionListGreen = [/*"default","default2",/*"medicalCamp","redCamp","resupplyCamp",*/"FieldCamp","FieldHQ","weaponsResearch","munitionsResearch","colonelsBase","banditVillage"];
};
// Passed 

_pathOrange = "Orange";
//_missionListOrange = ["redCamp"/*,"operationTakeover"*/];
_missionListOrange = [/*"default","default2","medicalCamp","redCamp","resupplyCamp",*/"CommandersComplex","generalsCamp","colonel2","stronghold","operationShutdown","operationTakeover"/*,"temple"*/];
// Passed 

#ifdef blck_milServer
if (blck_debugOn) then 
{
	_missionListGreen = ["FieldCamp"];
} else {
	_missionListGreen = [/*"default","default2",/*"medicalCamp","redCamp","resupplyCamp",*/"FieldCamp","FieldHQ","weaponsResearch","munitionsResearch","colonelsBase"/*,"banditVillage"*/];
};
// Passed 

if (blck_debugOn) then 
{
	_missionListOrange = ["operationTakeover"/*,"pinkPoison","stronghold","operationShutdown","operationTakeover","generalsCamp","colonel2"*/];
} else { 
	_missionListOrange = [/*"default","default2","medicalCamp","redCamp","resupplyCamp",*/"CommandersComplex","generalsCamp","colonel2","pinkPoison","stronghold","operationShutdown","operationTakeover"/*,"temple"*/];
};
// Passed CommandersComplex  generalsCamp  colonel2  pinkPoison  stronghold  
// Failed 
#endif

_pathHeliCrashes = "HeliCrashes";

if (toLower(worldName) isEqualTo "namalsk") then
{
	diag_log format["[blckeagls] GMS_missionLists.sqf:: -> running mission list variants for Namalsk"];
	_missionListGreen = [/*"default","default2",/*"medicalCamp","redCamp","resupplyCamp",*/"FieldCamp","FieldHQ"/*,"weaponsResearch","munitionsResearch"*/];
	_missionListOrange = [/*"default","default2","medicalCamp","redCamp","resupplyCamp",*/"CommandersComplex","generalsCamp"/*,"colonel2","temple"*/];
};
