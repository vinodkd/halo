// refs.js
/*
	syntax: srcRef = [ctx://]path[$verpath]
	defaults: ctx = file, verpath=latest
*/

var  log = require("./log.js").log;

exports.parse = function(srcRef) {
	var parts = srcRef.match(/(^.*\:\/\/)*(.*)$(.*)*/);
	log(parts);
	var ctx = parts[1] == undefined ? "file" : parts[1];
	var path = parts[2];
	var version = parts[3] == undefined ? "HEAD" : parts[3];
	log(ctx + "," + path + "," + version);
	return {ctx:ctx, path:path, version: version};
}
