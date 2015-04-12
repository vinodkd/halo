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
			if(attr.type == "nv"){
				nvpairs[attr.name] = attr.value;
			}
		}
		return nvpairs;
	}
}

start = _ g:graph _  						{ return g; }
graph = h:node _ b:body 					{ var g=h; g.type = 'graph'; g.body = b; return g; }
	  / h:node 								{ return h; }
node = c:cmt* n:name t:type? a:attrs?		{ return { type:'node',comments:c,name:n,template:(t?t:null),attrs:a}; }
body = "{" 
		  entries: entry* _
	   "}" 									{ return {type:'body', content: entries}; }

name = text
type = ":" t:text 							{ return t;}
attrs = c:cmt* "[" attrs:attr+ "]"			{ return {type:'attrs',comments: c,attrs: attrs, nvpairs: getNVPairs(attrs)}; }

/* 
removed nvpair since this was causing problems in sequencing of nodes
and for two functional reasons:
1. you *can* add attrs to the graph node itself using available syntax
2. attributes in the body are going to be hoisted to the graph level anyway
*/

entry = _ c:cmt* e:(edge/graph) _ 			{ e.comments = c; return e; }

attr = c:cmt* a:(nvpair/lref/tag) _ ","? _ 	{ a.comments = c; return a; }
nvpair = n:name _ "=" _ v:value _			{ return {type:'nv',name:n,value:v}; }
value = text
lref = "#" r:nqstring 						{ return {type:'lref', ref:r}; }
tag = t:text 								{ return {type:'tag', tag:t}; }

edge = roe:restOfEdge+						{ return {type:'edge', targets: roe}; }
	 / s:text roe:restOfEdge+				{ return {type:'edge',src:s, targets: roe}; }
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
qstring = '"' chars: qchar* '"'				{ return chars.join(''); }
nqstring = s:('_' / [a-zA-Z0-9])+ 			{ return s.join(''); }
qchar = !('"') . 							{ return text(); }

cmt = _ "/*" cc:cchar* "*/" _				{ return cc.join(''); }
	/ _ "//" cl:clchar* [\r\n]+	_			{ return cl.join(''); }
cchar = (!"*/") . 							{ return text(); }
clchar = (![\r\n]) .						{ return text(); }

_ "whitespace" = [ \t\n\r]*
