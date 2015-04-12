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

- correct readme to reflect currently doable things.
- fix ssi.js to work only when base attributes are provided with the current strings.
- change syntax to include \`-quoted strings; change parser logic to convert these into normal base attrs.
- create an ssi2.js that uses this new format
- create hin and hout contexts and switch all logging to that
- add the reference syntax into the parser
