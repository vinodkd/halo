The Halo Journal
=================
Meta
----
Since 2013 or so, I've started keeping journals for all my personal projects. This is largely because I have to stop working on them in short notice (getting off a train, for example) and need to write things down so I can pick them up later; but I've found that the journal becomes a free-format discussion with myself on design choices, implementation specifics etc.

Entries
--------
**Wed Apr  8 08:53:09 2015** : Started the project as a fork from `plnext/pegjs` yesterday in preparation for Strangeloop. Having a deadline like that helps me focus. While strangeloop is the motivation, the real intent is to use that deadline as a way to push out version 0.1 or 0.5 of jack (renamed Halo) out and into the public view (ie github).

**Wed Apr  8 08:54:41 2015** : Right now creating the readme. My intention this time around is to start with the end user documentation and slowly bring in working pieces from the plnext source - making them uniform as I go along.

**Wed Apr  8 18:28:43 2015** : Was reading up on how to create a node module and make it runnable as a command line app.
Resources: 
* http://tutorialzine.com/2014/09/creating-your-first-node-js-command-line-application/
* https://quickleft.com/blog/creating-and-publishing-a-node-js-module/

**Thu Apr  9 08:03:13 2015** : Created basic node module and linked it to global list. Commands:
	
	npm init
	<<edit package.json to add bin>>
	npm link

**Thu Apr  9 08:23:12 2015** : Created basic halo shell script and parsed cmd line params. now need to move stuff from pegjs/jack to halolang/halo.

**Thu Apr  9 18:02:54 2015** : need to be able to flip on logging without changing code. so log() = log level 1, log(msg,2) = log level 2 and so forth. unsetting the env var or cmd line param should turn off all logging.

**Fri Apr 10 08:50:27 2015** : basic logging done now.

**Fri Apr 10 17:33:24 2015** : Got basic structure of halo.js done, now need to flesh out the actual loading and parsing of a test file. However, one side thought: halo.js should do error reporting through the hout context in graph syntax, not through log.js. Will change that once the basic loading of files is done.

**Fri Apr 10 17:38:03 2015** : Was about to change the regex to match for ctx beginning. Need to look up how js does regexes.

**Sat Apr 11 12:31:22 2015** : Added the basics of actual execution:
  - added code in halo binary
  - created lib/halo.js to hold the logic used in the binary
  - copied the old dotformat.js as haloparser.js. This will be replaced with a generated file soon; right now it confirms that once i have the generated file in place, things will work	
  - created a basic file context and loaded a sample file

**Sat Apr 11 12:33:09 2015** : Next steps:

- bring pegjs parser in.
- create context.js and move context logic there.

**Sat Apr 11 18:53:28 2015** : Chose to do no. 2 from list above first. Committing lots of changes that cannot be itemized due to issue with git gui:
- Added an err function in log.js and wrapped halo.js.load() using it.
- moved the ref parsing logic to refs.js
- moved the context loading logic to contexts.js
- created a contexts dir and added file.js to it
- created actions.js and called it from halo.js.do()
- created actions dir and added a stub viz.js action to it.

**Sat Apr 11 18:56:17 2015** : Now to bring the pegjs version of the parser in.

**Sat Apr 11 20:03:16 2015** : Basic move of the pegjs based parser into the halo codebase.
- deleted lib/haloparser.js
- changed reference to haloparser in halo.js to parser
- moved dotformat.pegjs as src/halo.pegjs
- setup script in package.json to generate parser.js from this source
- added lib/parser.js to the .gitignore file.

**Sat Apr 11 20:06:40 2015** : Next steps:

- <s>correct readme to reflect currently doable things.</s>
- <s>fix ssi.js to work only when base attributes are provided with the current strings.</s>
- <s>change syntax to include \`-quoted strings; change parser logic to convert these into normal base attrs.</s>
- <s>create an ssi2.js that uses this new format</s>
- create hin and hout contexts and switch all logging to that
- add the reference syntax into the parser

**Sat Apr 11 20:28:25 2015** : fixed the readme to reflect only ssi working currently.

**Sat Apr 11 21:12:24 2015** : Need to resolve how to handle "running". current jack practice is to look at the lang attr and auto run files when presented with `jack file`. With halo, `read` is the default, so `run` will have to be explicitly stated. That still doesnt resolve how to figure out the language. should it still be lang? I guess.

**Sat Apr 11 21:14:49 2015** : getting a lot of errors with git gui. Downloading latest git from git-scm. Have to install it and use instructions in http://coolestguidesontheplanet.com/install-update-latest-version-git-mac-osx-10-9-mavericks/ to point to it vs xcode version.

**Sun Apr 12 02:30:25 2015** : Next steps:

- <s>correct readme to reflect currently doable things.</s>
- do things in the order of the readme's get started section.
	- <s>primitives</s>
	- <s>array</s>
	- <s>hashtables</s>
	- <s>objects</s>
	- analyze
	- viz
	- run fizzbuzz
	- run todomvc
- <s>fix ssi.js to work only when base attributes are provided with the current strings.</s>
- <s>change syntax to include \`-quoted strings; change parser logic to convert these into normal base attrs.</s>
- <s>create an ssi2.js that uses this new format</s>
- create hin and hout contexts and switch all logging to that
- add the reference syntax into the parser

**Sun Apr 12 06:09:24 2015** : Still trying to figure out why the nqstring rule wont work correctly. latest: added all strings that are used in the language to stop parsing them as part of nqstring.

**Sun Apr 12 06:58:01 2015** : Got the text rule to be redefined such that non-quoted strings now can be anything other than the symbols used in syntax, ie they're that much closer to the lang they're written in. All of this is so that primitives from the base language can be allowed to be expressed naturally.

Next up: actually creating the test primitives files.

**Mon Apr 13 17:37:18 2015** : Added a basic test harness using npm's scripts and bash as part of primitives testing.

**Wed Apr 15 09:15:44 2015** : new ideas for syntax:

- <s>change "#" to "&" to "#" can be used for hashtags</s>
- node "name" should be optional and equal to alias. this way anonymous nodes can be created with "names" based on value hash alone. these two syntaxes will be equivalent:

	name { ... }
	[&name] { ... }

... and this syntax should be invalid

	name [&alias] { ... }

- non-quoted syntax for nodes should support "-" and ".". This will allow numbers to be represented without quoting. This needs checking the peg syntax since edges are also represented with one dash followed by relation descriptor followed by another dash. so potentially something like `123e-10 234e-5` could be considered an edge between `123e` and `5` with a description of `10 234e`. The mitigations are that all edges are directed, so the second dash will have to be followed with another symbol, and that is that such a description will have to be quoted, so we should be good ,but getting this into the parser will be tough.

**Thu Apr 16 09:58:57 2015** : Still working on getting run.js and ssi.js to work together. running ssi.js from halo.js works, but calling it from run.js doesnt. must be some module deps issue, but cannot figure it out yet

**Thu Apr 16 10:04:15 2015** : Figured it out. no module deps issue. run.js should actually run the executor after it loads it, which it wasnt :)

**Thu Apr 16 10:37:52 2015** : - Added returns to do(),run.js and ssi.js so that they can be used both from the command line and as functions
- replaced ssi.js.baseExecute() with a call to actions/exec.js
- changed the main runner - halo - to return the code from execution to the environment.
- commented out all the try/catch blocks since they were preventing display of the stacktrace

**Thu Apr 16 10:39:38 2015** : Now taking up the change to make ssi run baseexec only if the attribute is on the node.
Started making change to ssi execute() when train reached. later.

**Thu Apr 16 18:02:22 2015** : Completed the change to make ssi run baseexe only if attr is in node. ssi.js needs clean up and migration to the log() call instead of console.log

Now changes for ssi have broken the other tests. need to fix that.

**Thu Apr 16 19:21:47 2015** : fixed the issue by moving the return in halo into the if block - as it should be.

**Thu Apr 16 19:22:06 2015** : Commiting changes:
- added log to ssi and used it in one place.
- added check to ssi that it will execute a step with base only if the attr lang=os/base is present
- changed ssi.halo to work with new expectations in code

**Fri Apr 17 05:32:38 2015** : debugging failure of parsing when node name is made null. changing the entry and edge rules to see if moving comments inside the edge rule will help prevent left recursion.

**Fri Apr 17 06:08:56 2015** : giving up on this change for now. the # to & change seems simpler. going to try that.
**Sun Apr 19 08:07:16 2015** : & change done. Now working (since friday actually) on introducing the \` quote into the syntax. Running into issues with ssi2.halo on this.

**Sun Apr 19 13:31:37 2015** : Finally got the \` version to work. Spent a lot of time debugging the parser since it was failing only on the backquoted strings. After hours of debugging this turned out to be the lack of white space after the new `eqstring` sub rule of the `name` rule. All the more reason for me to normalize the names part of the parser.

Anyhow, this works for now and can be checked in.

**Sun Apr 19 14:36:31 2015** : Copying todos from plnext now so that there's a comprehensive list to work from. Also sorting out tasks between prototype version and the real version 1.

**Sun Apr 19 18:10:59 2015** : added correct exception handling using the error object.

**Sun Apr 19 19:10:21 2015** : Update and organized todo list as a series of documentation+coding tasks, plus moved some items to version 1 already. The list is interspersed with data and action improvements in increments that are complete in themselves and can be versioned off at that point.

**Sun Apr 19 20:39:37 2015** : Reorged the todo list, moved two sections into version 1 and setup a plan for completion by may 3rd. Let's see how that goes :). Work and personal constraints abound between 4/28 and 5/1; not to mention the start of the summer semester in may.
