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

