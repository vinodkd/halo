// log.js
// A simple log function that uses an environment variable **HALO_DEBUG_LEVEL** to turn on debug logs.
// HALO_DEBUG_LEVEL sets the maximum level of logging that will be output.
// If the debug level in the call is <= HALO_DEBUG_LEVEL, we'll see output.
// By default, 	HALO_DEBUG_LEVEL = 0; so with 	level = 1 no output is seen.
// When 		HALO_DEBUG_LEVEL = 1; and 		level = 1    output is seen.
// When 		HALO_DEBUG_LEVEL = 1+; and  	level = 1+ 	 output is seen.


exports.log = function(msg,level) {
	var lvl = (level == undefined) ? 1 : level;

	var confLvl = process.env.HALO_DEBUG_LEVEL;
	confLvl = (confLvl == undefined || confLvl.trim() == "") ? 0 : confLvl;

	// console.log("lvl:"+lvl+",HALO_DEBUG_LEVEL:" + confLvl);
	if(lvl <= confLvl){
		exports.err(msg);
	}
}

exports.err = function(msg){
	if(typeof msg == "string")
		console.log(msg);
	else
		console.log(JSON.stringify(msg));
}
