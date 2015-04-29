// halo.pegjs
/*
note to editors: If there are syntax errors, try adding the whitespace rule before or after a rule or expression.
*/

{
	function getNVPairs(attrs){
		var nvpairs = {};
		if(!attrs.length)
			return nvpairs;
		for(var i=0;i<attrs.length;i++){
			var attr = attrs[i];
			switch(attr.type){
				case "nv"	: nvpairs[attr.name] = attr.value; break;
				case "tag"	: nvpairs[attr.tag] = true; break;
				case "lref"	: nvpairs["alias"] = attr.ref; break;
			}
		}
		return nvpairs;
	}
}

start = _ g:graph _  						{ return g; }
graph = h:anode? _ b:body 					{
												var g = h ? h : {};
												g.type = 'graph'; g.value = b;
												// console.log("graph:"+ JSON.stringify(g));
												return g;
											}
	  / h:node 								{
												// console.log("graphnode:"+ JSON.stringify(h));
												return (h.attrs.nvpairs['ignore'] || h.attrs.nvpairs['nop']) ? null : h;
											}

anode = c:cmt* alias:text t:type? a:attrs?	{
												//console.log(n);
												if(a == undefined || a == null)
													a = {};
												if(a.attrs == undefined || a.attrs == null)
													a.attrs = [];
												if(alias != null){
													a.attrs.push({type:'lref',ref: alias});
												}
												if(a.nvpairs == undefined || a.nvpairs == null)
													a.nvpairs = {};
												a.nvpairs = getNVPairs(a.attrs);

												// console.log("node:"+JSON.stringify(alias)+"\n attrs:"+JSON.stringify(a));
												return { type:'node',comments:c,template:(t?t:null),attrs:a};
											}
node = c:cmt* alias:text? v:nvalue t:type? a:attrs?
											{
												//console.log(n);
												if(a == undefined || a == null)
													a = {};
												if(a.attrs == undefined || a.attrs == null)
													a.attrs = [];
												if(alias != null){
													a.attrs.push({type:'lref',ref: alias});
												}
												if(v.type=="e"){
													a.attrs.push({type:'nv',name:'lang',value:'base'});
												}
												if(a.nvpairs == undefined || a.nvpairs == null)
													a.nvpairs = {};
												a.nvpairs = getNVPairs(a.attrs);

												console.log("node:value:"+JSON.stringify(v)+"\n attrs:"+JSON.stringify(a));
												return { type:'node',comments:c,value:v.value,template:(t?t:null),attrs:a}; 
											}
body = "{" 
		  entries: entry* _
	   "}" 									{ console.log("body");return {type:'body', content: entries}; }

nvalue = e:eqstring							{ console.log("e:"+e);return {value:e,type:"e"};}
	 / n:number 							{ console.log("n:"+n);return {value:n,type:"n"};}
	 / t:text 								{ console.log("t:"+t);return {value:t,type:"t"};}
type = ":" t:text 							{ return t;}
attrs = c:cmt* "[" attrs:attr+ "]"			{ return {type:'attrs',comments: c,attrs: attrs, nvpairs: getNVPairs(attrs)}; }

/* 
removed nvpair since this was causing problems in sequencing of nodes
and for two functional reasons:
1. you *can* add attrs to the graph node itself using available syntax
2. attributes in the body are going to be hoisted to the graph level anyway
*/

entry = _ e:(graph / edge) _ 					{ return e; }

attr = c:cmt* a:(nvpair/lref/tag) _ ","? _ 	{ a.comments = c; return a; }
nvpair = n:name _ "=" _ v:value _			{ return {type:'nv',name:n,value:v}; }
name = text
value = text
lref = "&" r:nqstring 						{ return {type:'lref', ref:r}; }
tag = "#" t:text 							{ return {type:'tag', tag:t}; }

edge = c:cmt* roe:restOfEdge+				{ return {type:'edge', comments:c,        targets: roe}; }
	 / c:cmt* s:text roe:restOfEdge+		{ return {type:'edge', comments:c, src:s, targets: roe}; }
restOfEdge = e:(fwdRel/retRel) a:attrs* _ 	{ return { opr:e.opr, rel:e.rel, dest:e.dest, attrs: a}; }
fwdRel = opr:fwdPrefix r:desc "->" d:text 	{ return { opr:opr,rel:r,dest:d }; }
retRel = "<-" r:desc "-" 					{ return { opr:'ret',rel:r}; }
fwdPrefix = opr:(altOpr
				 /parallelOpr
				 /generic)					{ return opr; }
altOpr = "/-" 								{ return 'alt'; }
parallelOpr = "||-" 						{ return 'par'; }
generic = "-" 								{ return 'rel'; }
desc = (text / "") 							{ return text(); }

text = _ s:(qstring / nqstring) _			{ return s; }
// escape quoted string
eqstring = _ '`' chars: neqchar* '`' _		{ console.log("eq:"+text());return chars.join(''); }
qstring = '"' chars: nqchar* '"'			{ return chars.join(''); }
nqstring = s:nwchar+ 						{ return s.join(''); }
number = "-"? [0-9\.]+ [eE]? "-"? [0-9\.]* 	{ return text(); }
/* Still not clear what the . at the end does, but it hangs without it :) */
neqchar = !('`') . 							{ return text(); }
nqchar = !('"') . 							{ return text(); }
nwchar = ![ \t\n\r\{\}\[\]\:=#\>\/\|\*\",\-] .
											{ return text(); }

cmt = _ "/*" cc:cchar* "*/" _				{ return cc.join(''); }
	/ _ "//" cl:clchar* [\r\n]+	_			{ return cl.join(''); }
cchar = (!"*/") . 							{ return text(); }
clchar = (![\r\n]) .						{ return text(); }

_ "whitespace" = [ \t\n\r]*
