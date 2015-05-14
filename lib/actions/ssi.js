// ssi.js
var halolib = require("../halo.js");
var log = require("../log.js").log;

exports.run = function(ptree){
	console.log(ptree.alias);
	var seqNode = ptree.value[0];
	if(seqNode.alias != "sequence"){
		throw new Error("root graph must contain a sequence.");
	}
	checkSemantics(seqNode);
	console.log(JSON.stringify(seqNode,null,2));
	return run(seqNode);
}

var revMap = {};

function checkSemantics (seqNode) {
	// console.log("seqNode contents:" + seqNode.value.content.length);
	revMap = {};
	for(var n=0; n< seqNode.value.length; n++){
		var node = seqNode.value[n];
		node.out = [];
		// this handles the "natural graph nature" of sequences 
		// by adding the next node in the out list for the previous node.
		if(n>0) seqNode.value[n-1].out.push(node);
		var type = node.type;
		console.log(node.value +":"+type);
		switch(type){
			case 'node'	: handleNode(node,n); 			break;
			case 'graph': checkIf(node,n);				break;
		}
	}
	// console.log(JSON.stringify(revMap));
}

// created for when we may have to do more preprocessing per node
function handleNode (node,index) {
	setRevMap(node,index);
}

function setRevMap (node,index) {
	// console.log("setRevMap:"+ node.value + "," + node.type);

	if(node.type != "node") return;

	// add ref to index using name by default
	revMap[node.value] = index;
	if(node.attrs == undefined || node.attrs.attrs == undefined) 
		return;

	// now add ref to index using alias too
	revMap[node.alias] = index;
}

function checkIf (node,index) {
	if(node.alias != 'if') throw new Error("if is the only allowed subgraph in ssi");
	var ifNode = node.value;
	if(ifNode.length != 2) throw new Error("if must have exactly one condition node and 2 branching edges");

	if(ifNode[0].type != 'node') throw new Error("condition not found");
  	handleCondition(ifNode[0],index);

  	// console.log(ifNode[1].targets[0]);
	if(ifNode[1].type != 'edge' || ifNode[1].targets[0].opr != 'rel') throw new Error("if true edge missing");
	ifNode[0].out.push(ifNode[1].targets[0]);

	if(ifNode[1].type != 'edge' || ifNode[1].targets[1].opr != 'rel') throw new Error("if false edge missing");
	ifNode[0].out.push(ifNode[1].targets[1]);
}

function handleCondition (node,index) {
	// todo: do any condition specific prep here
	node.out = [];
	handleNode(node,index);
}

function handleJumps (node) {
	// console.log(node);
}

function run(seqNode) {
	var step = null, ret = null, haltYN = null;
	console.log("run:start");
	do{
		// console.log("b4: step:" + JSON.stringify(step) + ",ret:" + JSON.stringify(ret));
		step = nextStep(seqNode,step,ret);
		// console.log("new: step:" + JSON.stringify(step));
		console.log("executing: " + step.alias);
		ret = execute(step);
		console.log("ret:" + JSON.stringify(ret));
		haltYN = shouldHalt(ret,step);
		console.log("shouldHalt:" + haltYN);
	}while(!haltYN);
	console.log("run:end");
	// this returns the last return value to its caller
	return ret;
}

function nextStep (seqNode,step,ret) {
	// start
	if(step == null){
		return seqNode.value[0];
	}
	if(ret < 0){	// error
		return null;
	}
	if(step.alias == "if"){
		// console.log("dest:"+ret.dest);
		// console.log("revmap:" + revMap[ret.dest]);
		// console.log("ret:" + seqNode.value[revMap[ret.dest]]);

		return seqNode.value[revMap[ret.dest.value]];
	}
	return step.out[0];
}

function execute (step) {
	if(step == null)
		return -1;
	// console.log("execute: "+step.type);
	if(!(step.type == 'node' || step.type == 'graph')){
		// console.log("step not node or graph");
			return -2;
	}
	if(step.alias == "if"){
		// console.log("execute:if"+JSON.stringify(step,null,2));
		var ret = baseExecute(step.value[0].value);
		// console.log("op:"+ret.output + "true:"+(ret.output.trim() == "1"));
		return ret.output.trim() == "1" ? step.value[0].out[0] : step.value[0].out[1];
	}

	// log(step);
	if(step.attrs && step.attrs.map){
		var lang = step.attrs.map["lang"];
		log(lang);
		if( lang && ["base", "os"].indexOf(lang)  != -1 ){
			return baseExecute(step.value).code;
		}
	}
	return { code: -1, message: "ssi steps must have a lang attribute set"};
}

function baseExecute (s) {
	return halolib.do("exec",null,s);
}

function shouldHalt (ret,step){
	// console.log("shouldHalt:ret:" + ret + ",step:" + JSON.stringify(step));
	if(ret == null || ret == undefined) return true;
	if(ret <0) 							return true;
	if(ret.code && ret.code <0 )		return true;
	if(step.out.length == 0) 			return true;
	return false;	
}
