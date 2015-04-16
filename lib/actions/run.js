// run.js
var log = require("../log.js").log;

exports.run = function (src,options) {
	var lang = src.attrs.nvpairs["lang"];
	console.log("run:lang:" + lang);
	if(lang == undefined)
		throw {error: -1, message: "run: source needs a lang attribute to run"}
	try{
			var executor = require("./" + lang + ".js");
			executor.run(src,options);
	}catch(e){
		console.log(e);
		if(e.code == 'MODULE_NOT_FOUND'){
			throw {code: e.code, message: "Could not find language: "+ lang, exception: e} ;
		}
		else{
			throw {
				code: -1, 
				message: "run(): failed to load handler due to unknown reason for language: "+ lang, 
				exception: e
			};
		}
	}
}