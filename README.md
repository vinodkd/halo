The HALO Programming Language
==============================

**HALO** is an experimental programming language. Here are some of the things it attempts to do:

* Model all software as having 4 layers - Human, Application, Language and OS (hence the name); and built using components.
* Model data (and therefore code representation) as graphs.
* Model programs as actions on graphs.
* Model multi-language applications as unified graphs.
* Model the human processes by which software is made - also as actions.
* Model changes in data, programs and processes as versioned graphs
* Model large-scale changes to large applications
* Model multi-level abstraction and/or optimization of software.

It is intended to:
* Enable full-lifecycle representation of all coding artifacts - from design to maintenance.
* Enable cross-language code analysis for dependency, quality, etc.
* Enable building multi-language component-based software.
* Enable large scale change of software

Status
------
Halo is currently a prototype of the lofty goals listed above. This prototype is based on nodejs and uses nodejs as the OS and javascript as the language. I hope to go beyond this once the basic use and value of the ideas presented here are proven to be useful.

History
-------
HALO is the public version of a long-running personal project of mine unimaginatively called "plnext" - for the next programming language. There are two pieces in plnext - a language called **jack** and an associated IDE called **fluent**. I have written a number of blog posts about the grand vision for this programming language and the IDE. Halo is a prototype for jack and may well be what it ultimately becomes. We'll see :).

Download
--------
Halo is an npm installable application. Run:

	[sudo] npm install halo

... to install it.

Getting started
---------------

1. Run `halo` to enter an interactive shell
2. Run `halo [file|dir]` to read a file or directory (and potentially "run" something)
3. Run `halo action [options] [file|dir]` to have an `action` act on a file or directory.

Here're specific examples of the 3 modes above to show halo's features:

* See `test/primitives.halo` to see how primitive data types can be represented in the halo data format.
* See `test/array.halo` to see how arrays can be represented in the halo data format.
* See `test/hashtable.halo` to see one way of representing hashtables in the halo data format.
* See `test/object.halo` to see how objects can be represented in the halo data format.
* Run the `analyze` action on any of the files above to get a graph analysis of the contents
	* eg, run `halo analyze test/object.halo` to get a graph analysis of that file.
* Run the `viz` action on any of the files above to get a graphviz output of the contents
	* eg, run `halo viz test/object.halo` to get a dot file output of that file.
	* You can now run `dot -Tsvg -o output.svg object.dot` to get an svg display of `object.halo`
* Run `halo viz test/spa.halo` to visualize the structure and behavior of a single page js app (as documented in that file)
* Run `halo viz test/abs_todomvc.halo` to visualize the structure and behavior of of an app that inherits from `spa.halo`.
* Run `halo `
