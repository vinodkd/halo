// actions.js
var log = require("./log.js").log;

exports.load = function (action) {
	try{
			var executor = require("./actions/" + action + ".js");
			return executor;
	}catch(e){
		if(e.code == 'MODULE_NOT_FOUND'){
			throw {code: e.code, message: "Could not find action: "+ action} ;
		}
		else{
			throw {
					code: -1, 
					message: "actions.load(): failed to load handler due to unknown reason for action: "+ action + e
			};
		}
	}

}
