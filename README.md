The HALO Programming Language
==============================

**Halo** is an experimental meta-programming language that parasitically models the creation, modification and overall lifecycle of component-based multi-lingual applications. That's a lot of buzzwords, so let's break it down:

* **experimental**: because I dont know if this will all work out in the end, or be any different than *one more wrapper*. We'll see.
* **parasitically**: Halo live atop a host language and therefore doesnt have a standard lib, framework or runtime of its own. It uses the host langauge for all of these; making it a parasite.
* **meta-**: As in "about" programming, not "programs writing programs". There's some of the latter, but its secondary to the former.
* **programming**: Halo is turing complete in a very simple sense, so concievably it can be used for programming directly, but that's not its primary intent.
* **creation/modification**: Meaning change. Halo models changes made to code and its surrounding artifacts *within the langauage*.
* **lifecycle**: Means everything in the SDLC from early ideas to sunseting, not just code to deployment.
* **component-based**: Components are the smallest unit of code in Halo, although it's definition of component is very lax: anything callable in the base language is a component.
* **multi-lingual**: Halo recognizes that typical applications are written in multiple languages and allows for that from the ground up.

Put grandiosely, Halo models software development as a **great translation exercise from human thought to running code**. It models not just the code, but the process by which code is created and the human doing the creation him/herself. It recognizes that there are multiple layers of abstraction and optimization involved in creating *acceptable* software and attempts to model that too. Further, it recognizes that change is inevitable, that software models change and specifically that change usually crosses domain (function, program, component, process, network) boundaries - and attempts to model that too.

Status
------
Halo is currently a prototype of the lofty goals listed above. This prototype is based on nodejs and uses nodejs as the OS and Javascript as the language. I hope to go beyond this platform once the basic use and value of the ideas presented here are proven to be useful.

History
-------
HALO is the public version of a long-running personal project of mine unimaginatively called "plnext" - for the next programming language. There are two pieces in plnext - a [language called **jack**](http://tt2n.blogspot.com/search/label/jack) and an associated [IDE called **fluent**](http://tt2n.blogspot.com/search/label/fluent). I have written a number of blog posts about the grand vision for this programming language and the IDE. Halo is a prototype for jack and may well be what it ultimately becomes. We'll see :).

Download
--------
Halo is an npm-installable application. Run:

	[sudo] npm install halo

... to install it.

Run:

	npm test

... to run a test on all included sample source.

Dependencies
-------------

Halo uses [Graphviz](http://graphviz.org) to visualize its data. If you dont use the `viz` action, you will be unaffected.

Documentation
--------------

See `docs` for documentation on the language and its features.

Getting started
---------------

<!-- 1. Run `halo` to enter an interactive shell-->
<!-- 2. Run `halo [file|dir]` to read a file or directory (and potentially "run" something) -->

2. Run `halo file.halo` to read a file (and potentially "run" something)
3. Run `halo action [options] file` to have an `action` act on a file.

<!-- 3. Run `halo action [options] [file|dir]` to have an `action` act on a file or directory. -->

<!-- 4. Run `halo gui` to see halo's native IDE -->

Here're some specific examples that show halo's features:

* See `test/primitives.halo` to see how primitive data types can be represented in the halo data format.
* See `test/array.halo` to see how arrays can be represented in the halo data format.
* See `test/hashtable.halo` to see one way of representing hashtables in the halo data format.
* See `test/object.halo` to see how objects can be represented in the halo data format.

<!-- * Run the `analyze` action on any of the files above to get a graph analysis of the contents -->
<!-- * eg, run `halo analyze test/object.halo` to get a graph analysis of that file. -->
<!-- * Run the `viz` action on any of the files above to get a graphviz output of the contents -->
<!-- * eg, run `halo viz test/object.halo` to get a dot file output of that file. -->
<!-- * You can now run `dot -Tsvg -o output.svg object.dot` or run `halo viz -Tsvg test/object.halo` to get an svg display of `object.halo`. -->
<!-- * Run `halo viz test/spa.halo` to visualize the structure and behavior of a single page js app (as documented in that file) -->
<!-- * Run `halo viz test/abs_todomvc.halo` to visualize the structure and behavior of of an app that inherits from `spa.halo`. -->
* Run `halo run test/ssi.halo` to see a simple imperative machine at work. It's called ssi since it models the 3 basic imperative operations - [sequence, selection and iteration](http://en.wikipedia.org/wiki/Structured_programming#Control_structures)
* Run `halo run test/ssi2.halo` to see a simpler syntax to run actions in the base or OS's language.
* Run `halo run test/ssi_loop.halo` to see an endless loop in the base or OS's language.

<!-- * Run `halo run test/fizzbuzz.halo` to see a single-language app in action. -->
<!-- * Run `halo run test/todomvc/main.halo` to see a multi-language app in action. -->
