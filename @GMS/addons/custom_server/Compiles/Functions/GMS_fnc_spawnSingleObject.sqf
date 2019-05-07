/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_objClassName","_objPosn",["_objDir",0],["_enableSimulation",true],["_enableDamage",true],["_enableRopes",true],["_mode","NONE"]];
private _obj = createVehicle[_objClassName,_objPosn,[],0,_mode];
_obj setDir _objDir;
_obj allowDamage _enableDamage;
_obj enableDynamicSimulation _enableSimulation;
_obj