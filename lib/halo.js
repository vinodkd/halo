// halo.js
var  log = require("./log.js").log;
var haloparser = require("./haloparser.js");


/*
	load() reads a graph from a source ref, parses it and loads it into memory. 
	The source ref could be a file, a network graph, or a human(ie in or out) graph.
	syntax: srcRef = [ctx://]path[$verpath]
	defaults: ctx = file, verpath=latest
*/
exports.load = function(srcRef){
	log("load:start:srcRef:" + srcRef);

	var ctx = getContext(srcRef);
	
	var ctxHandler = require("./contexts/" + ctx + ".js");
	var srcTxt = ctxHandler.read(srcRef);

	var ptree = haloparser.parse(srcTxt);
	log("load:ptree:" + JSON.stringify(ptree));
	log("load:done");
	return ptree;
}

function getContext (srcRef) {
	var ctx = srcRef.match(/(^.*\:\/\/)*(.*)/);
	log(ctx);
	return ctx[1] == undefined ? "file" : ctx[1];
}

exports.do = function(action,options,src){
	log("do:start");
}