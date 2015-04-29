// halo2.pegjs

start 	= _ n:node _								{ return n; }

_ "ws"	= [ \t\r\n]*
node 	= _ c:cmt* _ a:alias? _ v:(atom / graph) _	{ console.log(v);v.comments=c; v.alias=a; return v; }

cmt   	= _ "/*" cc:cchar* "*/" _ 					{ return cc.join(''); }
		/ _ "//" cl:clchar* [\r\n]+ _				{ return cl.join(''); }
alias =  _ ":" _ al:identifier _  					{ console.log('al:'+al);return al; }
graph = _ attrs:attrs* _ "{" _ e:entry* _ "}" _		{ return {type:'graph', value:e, attrs:attrs}; }
atom = v:avalue attrs:attrs*						{ v.attrs=attrs; return v; }
avalue = e:eqstring									{ return {value:e,type:"e"}; }
	 / n:number 									{ return {value:n,type:"n"}; }
	 / t:text 										{ return {value:t,type:"t"}; }

cchar = (!"*/") . 									{ return text(); }
clchar = (![\r\n]) .								{ return text(); }
identifier = id:[a-z,A-Z,0-9_]+						{ return text(); }
entry = _ c:(edge / node) _							{ return c; }
eqstring = _ '`' chars: neqchar* '`' _				{ return chars.join(''); }
number = "-"? [0-9\.]+ [eE]? "-"? [0-9\.]* 			{ return text(); }
text = _ t:(nqstring/qstring) _						{ return t; }
attrs = c:cmt* _ "[" _ attrs:attr+ _ "]" _			{ return {type:'attrs',comments:c, attrs:attrs}; }

edge = c:cmt* roe:restOfEdge+						{ return {type:'edge', comments:c,        targets: roe}; }
	 / c:cmt* s:text roe:restOfEdge+				{ return {type:'edge', comments:c, src:s, targets: roe}; }
neqchar = !('`') . 									{ return text(); }
nqstring = s:nwchar+								{ return s.join('');}
qstring = '"' s:nqchar+ '"'							{ return s.join('');}
attr = c:cmt* _ a:(tag / nvpair) _ ","? _			{ console.log(a);a.comments = c; return a; }

restOfEdge = e:(fwdRel/retRel) a:attrs* _ 			{ return { opr:e.opr, rel:e.rel, dest:e.dest, attrs: a}; }
nwchar = ![ \t\n\r\{\}\[\]\:=#\>\/\|\*\",\-] . 		{ return text(); }
nqchar = !('"') . 									{ return text(); }
nvpair = _ n:name _ "=" _ v:value _ 				{ return {type:'nv',name:n,value:v}; }
tag = "#" t:text 									{ return {type:'tag', tag:t}; }

fwdRel = opr:fwdPrefix r:desc "->" d:text 			{ return { opr:opr,rel:r,dest:d }; }
retRel = "<-" r:desc "-" 							{ return { opr:'ret',rel:r}; }
fwdPrefix = opr:(altOpr
				 /parallelOpr
				 /generic)							{ return opr; }
altOpr = "/-" 										{ return 'alt'; }
parallelOpr = "||-" 								{ return 'par'; }
generic = "-" 										{ return 'rel'; }
desc = (text / "") 									{ return text(); }

name = text
value = text