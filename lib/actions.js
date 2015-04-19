// actions.js
var log = require("./log.js").log;

exports.load = function (action) {
	try{
			var executor = require("./actions/" + action + ".js");
			return executor;
	}catch(e){
		if(e.code == 'MODULE_NOT_FOUND'){
			var err=new Error("Could not find action: "+ action);
			err.code = e.code;
			throw err;
		}
		else{
			var err=new Error("actions.load(): failed to load handler due to unknown reason for action: "+ action);
			err.code =-1;
			throw err;
		}
	}

}
