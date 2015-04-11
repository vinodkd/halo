// contexts.js
exports.read = function read (srcRef) {
	if(srcRef.ctx == undefined) return null;
	try{
			var ctxHandler = require("./contexts/" + srcRef.ctx + ".js");
			return ctxHandler.read(srcRef);
	}catch(e){
		if(e.code == 'MODULE_NOT_FOUND'){
			throw {code: e.code, message: "Could not find context: "+ srcRef.ctx} ;
		}
		else{
			throw {code: -1, message: "ctx.read(): failed to load context for unknown reason: "+ srcRef.ctx};
		}
	}
}
