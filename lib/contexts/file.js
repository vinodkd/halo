// file.js
var fs = require("fs");

exports.read = function(srcRef){
	// todo: input validation
	// todo: check for dir
	return fs.readFileSync(srcRef).toString();
}
