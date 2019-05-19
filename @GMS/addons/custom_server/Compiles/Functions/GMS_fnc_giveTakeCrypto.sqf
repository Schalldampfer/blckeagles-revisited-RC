/*
	Credit for this method goes to He-Man who first suggested it.
*/
//diag_log format["_fnc_giveTakeCrypto: _this = %1",_this];
//_object = _this select 0;
//diag_log format["_giveTakeCrypto: _object data = %1 | _object = %2",_object call BIS_fnc_objectType, _object];
if (_object isKindOf "Man") then 
{
	(_this select 0) call EPOCH_server_effectCrypto;
};


