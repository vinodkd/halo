// run.js
var log = require("../log.js").log;

exports.run = function (src,options) {
	// console.log(src.attrs);
	var lang = src.attrs.map["lang"];
	console.log("run:lang:" + lang);
	if(lang == undefined){
		var err=new Error("run: source needs a lang attribute to run");
		err.code = -1;
		throw err;
	}
	// try{
			var executor = require("./" + lang + ".js");
			return executor.run(src,options);
	// }catch(e){
	// 	console.log(e);
	// 	if(e.code == 'MODULE_NOT_FOUND'){
	// 		var err=new Error("Could not find language: "+ lang);
	// 		err.code = e.code;
	// 		throw err;
	// 	}
	// 	else{
	// 		var err=new Error("run(): failed to load handler due to unknown reason for language: "+ lang);
	// 		err.code = -1;
	// 		throw err;
	// 	}
	// }
}
