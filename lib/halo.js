// halo.js
var log = require("./log.js").log;
var err = require("./log.js").err;
var refs = require("./refs.js");
var ctx = require("./contexts.js");
var parser = require("./haloparser.js");
var actions = require("./actions.js");

/*
	load() reads a graph from a source ref, parses it and loads it into memory. 
	The source ref could be a file, a network graph, or a human(ie in or out) graph.
*/
exports.load = function(srcRefStr){
	try{
		log("load:start:srcRefStr:" + srcRefStr);

		var srcRef = refs.parse(srcRefStr);
		var srcTxt = ctx.read(srcRef);
		var ptree = parser.parse(srcTxt);
		log("load:ptree:" + JSON.stringify(ptree),2);

		log("load:done");
		return ptree;
	}catch(e){
		err(e);
	}
}

exports.do = function(actionName,options,src){
	log("do:start:" + actionName);
	var action = actions.load(actionName);
	action.run(src,options);
	log("do:done:" + actionName);
}
