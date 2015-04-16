// exec.js
var process= require("child_process");

exports.run = function (src,options) {
	var output = "", code = 0;
	console.log("exec:src:" + src);
	try{
		output = process.execSync(src).toString();
		console.log(output);
	}catch(e){
		code = e.code;
	}
	return {code: code, output: output};
}
