Todos on the Halo project
==========================

Format
------
	- [] taskdesc @context +category //priority is based on document order
	- 	[] subtaskdesc @context2 +category2

The todo list
-------------

- [] Prototype version !4/30/2015!
	- [] The version should contain:
		- [] graph language concept:
			- [] notional components and layers in a todo app
			- [] todomvc viz from jack source
			- [] same todomvc to demo mutlilanguage app rep
		- [] no lang/mutli-lang: covered by 3rd line above
		- [] .. thereby actions: demo using todomvc:
			- [] run
			- [] build
			- [] deploy
			- [] analyze
		- [X] turing complete: covered by first line above
		- [] include the human:
			- [] add ask and wait actions to base machine
			- [] demo understanding of todomvc as a series of edit actions
			=> need basic editor
		- [] ... meta concept:
			- [] add a logic language in comments and have it interpreted at a higher level
				- [] use prolog/logic language from ometa for this
		- [] incremental code
			- [] show mapping from one version of todomvc to another using inheritance.
		- [] incomplete features
			- [] trivially done with ... nodes
	- [] start with the end user documentation and slowly bring in working pieces from the plnext source - making them uniform as I go along
	- [] parser should not just give out a parse tree - it should actually convert the text into a graph with:
		- [] nodes list
		- [] edges list
		- [] nodes with in and out edge properties that can be used to traverse the graph.
		- [] lookup table that maps aliases to nodes
		- [] and more generically, creates hash ids for each node
		- [] sequence would then just add a start and stop node to and traverse the graph to execute it.
	- [] represent nodes with some short cuts: 
		- [X] backquoted strings are base strings
		- [] double quoted strings are evaled, ie understood by the language. 
		- [] Comments are just strings understood by humans or the sentient meta program
	- [] create hin and hout contexts and switch all logging to that
	- [] add the reference syntax into the parser
- [] Version 1.0

