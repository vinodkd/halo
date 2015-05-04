The Halo programming language User Guide
========================================

# Overview

**Halo** is an experimental programming language that attempts to model software development as a **great translation exercise from human thought to running code**. It models not just the code, but the process by which code is created and the human doing the creation him/herself. It recognizes that there are multiple layers of abstraction and optimization involved in creating *acceptable* software and attempts to model that too. Further, it recognizes that change is inevitable, that software models change and specifically that change usually crosses domain (function, program, component, process, network) boundaries - and attempts to model that too.

## The Big Ideas(TM)

* Everything is a graph - data, code and documents related to code.
* Programs are descriptions of processes as graph data, which are "run" by an executor by traversing the graph.
* Executors can be machines or humans; software development is the grand exercise of minimizing the role of human executors.
* Running programs and their data can also be represented as graphs; and changes in data and code that's running can be represented as versioned data.
* Programs always have multiple levels of abstraction.
    * For example, a Java program runs on a C runtime, which runs on a x86 virtual machine which runs on a docker instance, which runs on a physical macbook pro.
* At every level of abstraction, a program has 4 layers - Human (or Meta), Application, Language and OS (or Base).
    * For a Java program, Human = human using bash, App = java app, Lang = Java, OS (Base) = Java runtime
    * For the Java runtime itself: Human (Meta) = human using bash, app = Java program, Lang = C, OS (Base) = actual OS of machine.
    * For the OS: Human (Meta) = Java app, App = Java runtime, lang = System call API, OS (Base) = instruction set of machine.
* At a particular level of abstraction, **Components** are the smallest pieces of *callable* code. The exact definitions of "component" and "callable" depends on the language being used.
* Good software has the right set of components at the right level of abstraction. This, however, happens over time because of [Reality Driven Development](http://tt2n.blogspot.com/2011/02/reality-driven-development.html)
* Changing software to reach this state requires moving components in three ways:
    * Up the abstraction ladder to make it more generic (abstraction)
    * Down the abstraction ladder to make it efficient (optimization)
    * Within the same abstraction layer in response to change in domain logic (sequencing)
    These are lossy processes since they're largely manual.
* Modeling software change *in the language* is therefore a good thing(TM) since some of the losses can be recouped by storing metadata about how and why the change was made, reducing [Snapshot based code](http://tt2n.blogspot.com/2011/04/evolutionary-vs-snapshot-development.html)
* Further, modeling the process by which software is created and changed *in the language*, becomes a good thing(TM) as a since it helps the automation of change.
* Applications are typically collections of programs/services and regularly use multiple languages and executors. Modeling the multi-lingual and multi-process nature of applictions *in the language* is required to extend the concepts above to real-world applications.


## ... and some smaller ideas too
These ideas fix some small annoyance or purpose some small best practice:

* No comments without code.
* No misusing comments to hide code, use tags to mark code as ignorable instead.
* Names for things are bad and prevent change. Content-based IDs are good. Aliases are ok.

## Halo features
In response to these ideas, Halo has or does this:

* Everything is represented as a **graph**, in a Graphviz-like syntax. Everything = code, data, docs.
* Everything has IDs which act as names, a la git's blob hashes. Aliases are allowed, however.
* Graphs are stored and used via contexts, which are sources or sinks for graph data. The default contexts are `file` - the file system and `mem` - the memory itself.
* Executors are represented by **actions**. Executors run actions in Halo.
* The layers at each level of abstraction are directly represented in Halo:
    * Comments represent the Human (or Meta) level
    * Nodes, graphs and edges represent the application
    * Nodes with quoted strings (or appropriately attributed nodes) represent `eval`-ed language code.
    * Nodes with back-quoted strings (or appropriately attributed nodes) represent `exec`-ed language code.
* To keep the definition of "component" and "call" generic, Halo adds no additional syntax or library of its own. Instead it defines that:
    * any node is a potential component call
    * a graph is a component definition (or collection/hierarchy of components)
* Changes to software are modeled as changes to the graph representing the software
* The process by which software is created, deployed and maintained is itself modeled as a basic workflow.
* Multilingual software is represented by allowing each node or graph to have its own language (and associated executor)

## Halo use cases

Halo can be used to:
* Enable full-lifecycle representation of all coding artifacts - from design to maintenance and beyond.
* Enable cross-language code analysis for dependency, quality, etc.
* Enable building multi-language component-based software.
* Enable large scale change of software

## Disclaimer

Halo is very much an "assembled" language - almost everything in Halo has been built and/or tried before; so if you find some feature of Halo reminding you of some language of the past, its most probably true. There was just a wealth of ideas from the past that Halo couldnt help but borrow!

# Basic Data and Actions

## Graphs

Halo represents all data as graphs. Graphs are represented in Halo thus:

    // halo syntax                       // graphviz syntax
    :alias {                              digraph name {
        ... graph contents ...                ... graph contents ...
    }                                    }

The syntax draws a lot of inspiration from [Graphviz](http://www.graphviz.org)'s dotformat; so if you're familiar with it, reading halo source should be easy.

Note that there are a few differences:

* You dont need to call out that they are digraphs. All halo graphs are directed graphs by default.
* Halo graphs dont have names; instead they have aliases, which are similar to tags.
* Halo graphs dont need to have aliases at all, they can be anonymous.

So the following graph is perfectly valid.

    // anonymous graph
    {
        ... graph contents ...
    }

Halo graphs **do** have something similar to names, however; they have IDs. IDs are hashes generated from the contents of the graph and uniquely identify the graph based on its contents.

This leads us to the contents of the graphs: nodes and edges.

## Nodes

In Halo, nodes are essentially values and like Graphviz, they are represented with symbols or strings. They can be used to hold primitive values like shown below.

[../test/primitives.halo](#Simple Nodes "save:")
### Simple Nodes
The simplest nodes are atomic symbols, like so:

    :primitives {
        // atoms
        car plane boat ship
        // integer
        123
        // signed int
        -123
        // real
        123.45
        // e notation
        123.45e-10
        // strings: the two words are two nodes in halo
        hello world
        // string: this is one node
        "hello world"
    }

The simplest node is an atom - a symbol represented by an unquoted string of characters. Strings are nodes too, and represented with double-quotes surrounding them.

Numbers can be represented naturally as shown above but Halo has no number type. All nodes are essentially string values that are passed as-is to the underlying language. More on this later.

[../test/attributes.halo](#Attributes "save:")
### Attributes

Nodes can have attributes, which are represented very similar to attributes in Graphviz. For example:

    {
        car [isA=vehicle,type=land]
        plane [isA=vehicle,type=air]
        ship [isA=vehicle type=water]
        ....

As you can see, multiple attributes are allowed and can be separated by whitespace or commas.

Halo enhances the attribute concept, however, with tags. Tags are categories that you can attach to each node, like so:

        ...
        ferrari [type=vehicle,#awesome,#wishIhadOne]
    }

Yes, the syntax is borrowed from hashtags. They are used in Halo to filter nodes out, essentially and we'll soon see an example of this.

### Subgraphs

Anything more complicated than a symbol, number or string must be represented as a Subgraph and they're depicted like so:

    :graph {
        :subgraph {
            ... subgraph content ...
        }
        // anonymous subgraph
        {
            ... subgraph content ...
        }
    }

In general, anything that "contains" things or has inner structure must go into a subgraph; so this construct can be used to represent standard data structures like arrays, hashtables and objects.

[../test/arrays.halo](#Arrays "save:")
#### Arrays

Arrays work because all nodes in Halo have an index assigned to them based on document order.

    // arrays.halo
    // all nodes have a natural index assigned to them.
    // so you could refer to the 6 below as arrays.array1[5]
    :arrays {
        // simple 1D array
        :array1 {
            1 2 3 4 5
            //referred above
            6
            7 8
            9 10
        }
        // another 1-D array shown with each element in its own line. no change in meaning.
        :array2{
            abc
            def
            "ghi"
            "ghi mno"
        }
        // a 2D array
        :2darray {
            { 1 2 3 4 5 }
            { 11 12 13 14 15 }
            { 111 112 113 114 115 }
        }
    }

[../test/hashtable.halo](#Hashtables "save:")
#### Hashtables

    //hashtable.halo
    :hashtables{
        // simple name-value pair
        :name1 { value1 }
        :name2 { value2 }
        :name3 { value3 }

        // another way is to have attributes on a single node
        hashtable [
            name1 = value1
            name2 = value2
            name3 = value3
        ]
        // if you want values that are compound themselves, here's how:
        :hashtable2 {
            :name1 {
                value11
                value12
            }
            :name2 {
                value21
                value22
            }
        }
    }

[../test/object.halo](#Objects "save:")
#### Objects

    //object.halo
    :objects{
        :object {
            valueMember1
            :compoundMember2 {
                childValue1
                :compoundChild2 {
                    value1
                    value2
                    // this is actually another "value"
                    ....
                }
            }
        }
        // a list of students
        :students {
            :student1 {
                john
                smith
                :gpa { 3.45 }
            }
            :student2 {
                john
                doe
                :gpa { 2.45 }
            }
            :student3 {
                jane
                clark
                :gpa { 4.45 }
            }
        }
    }


### Some comments about comments

Comments in Halo look similar to comments in the C-family of programming languages.

#### Basic comments
    {
        /* This
            is
            a
            multi-line
            comment
        */
        // ...and this is a single line comment
        node
    }


[../test/invalid_comments.halo](#Invalid comments "save:")
#### Invalid comments
However, there's one deviation from other languages: *comments are tied to nodes*. Comments cannot be free-standing; they **must appear only before** a node, attribute, graph, subgraph or edge. They are parsed and available in the parsed output as an attribute on the node. Thus, this source code:

    {
        // a node
        node
        // the node above is awesome!
    }



... is invalid syntax and will fail in parsing.

[../test/commenting_code.halo](#Commenting code out "save:")

#### Commenting code out
If you're used to commenting out code to prevent it from being used, you can use the `#nop` or `#ignore` tags instead, like so:

    {
        nodeA
        nodeB [#ignore]
        nodeC
        nodeD [#nop]
    }

In this case, nodeB and nodeD will be parsed but ignored from further processing.

## Edges

# Contexts and the `run` Action
# Human Actions
# Prototypes and Halo as a documentation language
# Halo as an analysis language
# Meta data and meta code

