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

**Sun Apr 19 20:41:34 2015** : Thinking of using literate programming to keep docs and code in sync. Going to try out the npm module that allows this: https://github.com/jostylr/literate-programming. The plan is to use LP thus:

- Try it out for the user guide: write the user guide using markdown and generate all the files in `test` using LP. 
- If that works out fine, then try writing out the code itself using LP.

Also, need to be mindful of writing verbose text: I've assigned myself only 2 days per section for docs and code.

**Sun Apr 19 22:16:54 2015** : LP seems to work fine with the one test I did. Need to try one more file and then add an `lpgen` script to package.json; and merge the branch back to master.

**Mon Apr 20 00:14:12 2015** : LP is working fine for the docs. Will merge into master after this checkin.

**Mon Apr 20 00:26:40 2015** : Got numbers with -'s and .'s in the parser, but its failing for ssi.halo. Need to see where the overlap is.

**Mon Apr 20 02:56:29 2015** : finally fixed it. problem was the name rule was used everywhere. crated a new nvalue rule and put the number rule there, leaving the use of name in nvpair intact, and the use of text from within name and other places intact. This cleared the error where in ssi.halo the edge desc was being parsed as a number with resultant errors.

**Mon Apr 20 02:59:21 2015** : onto anonymous graphs.

**Mon Apr 20 03:39:34 2015** : got it working, but code needs cleanup. Not checking in yet, thus. also docs need to be written.

**Wed Apr 22 08:20:02 2015** : implemented a lot of what's due today. Pending: cleanup of the parser code and honoring the `#ignore` tag.

**Wed Apr 22 18:23:58 2015** : Was trying to figure out the best way to introduce aliases for nodes. Currently it works out for subgraphs because there's an easy way to figure out the end of the alias - the body begins. With nodes, there's no such distinction. Should i bring back the & sigil (or something else)?

**Mon Apr 27 08:05:41 2015** : Wasted the whole weekend, so really lagging behind. Plus: strangeloop's dates have been published, so no pressure :)

**Mon Apr 27 17:40:08 2015** : was still getting halo2.pegjs to work with primitive.halo.

**Wed Apr 29 17:48:03 2015** : Checkin before going any further since new parser works for the most part.

**Wed Apr 29 18:04:36 2015** : Was fixing the big ideas section.

**Thu Apr 30 21:19:43 2015** : Fixing ssi to work with new parse tree.

**Thu Apr 30 23:22:38 2015** : was trying to fix ssi.js.

**Sat May  2 07:33:31 2015** : fixed ssi, ssi2. added ssi_loop to show endless looping works.

**Sat May  2 09:44:50 2015** : finished fixing the ideas section - at least for now. Still not happy with the difference between the readme and the userguide top section, but leaving it as is for now.

**Sun May  3 01:59:14 2015** : finally merged the two sections.

**Mon May  4 09:00:48 2015** : was rewriting the overview again to rebadge the language as an application lifecycle language instead of just programming.

**Mon May 11 17:41:18 2015** : Rewritten.

**Thu May 14 09:01:41 2015** : Reorged the doc structure a bit. Added sections on edges. need to carve out a separate "using syntax for code" section.

**Thu May 14 18:25:13 2015** : was finishing up the reorg with syntax for code

**Sat May 16 00:12:16 2015** : was going to reorder chap 2 thus: talk about contexts. when talking about run we should probably implement as graph traversal. on a fork, the current node and its first child are eval'd. if they match from a language pov, that path is taken. next also need to talk about the default language.

**Sat May 16 06:51:18 2015** : just converted the value rule to allow for it to parse till the end of the line or start of attrs or comma. now see how this will be real useful with text, so wondering if comma is a good choice, or if i should reuse one of other reserved symbols, like | or . both wouldnt work when the language is code, but either would work when the language is human.

**Wed May 27 08:20:44 2015** : was thinking of moving to `;` as the delimiter since its the delimiter for graphviz, it works for most c-family languages and is a minor (imo) issue for text - search replace to escape semicolons are an easy pre-step to processing. however was trying to get semicolons to be recognized correctly in the grammar.

**Wed May 27 08:52:10 2015** : So thinking through the syntax a little bit wrt quotes and separators.

Before:
	- Nodes were delimited by spaces. anything larger than a word had to be quoted with double quotes
	- single quotes were not special, so were parsed as part of symbol.
	- double quotes allow escaping the space delimitation. quoted strings count as a single node.
	- back quotes are special, treated as an OS string.
Proposed now:
	- nodes separated by semi colon, end of line or attributes.
	- single quotes are still not special
	- double quotes remain as before, used to escape special chars like - when used in strings.
	- back quotes treated same as before.
Considered, rejected:
	- delimited by period. problem with this is that code will not abide by this rule. many languages use it as an object-property separator.
	- version 2: heredoc style nodes.

**Wed May 27 17:40:48 2015** : was updating userguide to follow new syntax.
**Fri May 29 08:55:20 2015** : Was still updating user guide to add semicolons and remove quotes. at line 360
**Wed Jun  3 05:39:09 2015** : Done updating for semis.

