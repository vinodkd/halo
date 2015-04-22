The Halo programming language User Guide
========================================

# Overview

**Halo** is an experimental programming language that attempts to model software development as a **great translation exercise from human thought to running code**. It models not just the code, but the process by which code is created and the human doing the creation him/herself. It recognizes that there are multiple layers of abstraction and optimization involved in creating *acceptable* software and attempts to model that too. Further, it recognizes that change is inevitable, that software models change and specifically that change usually crosses domain (function, program, component, process, network) boundaries - and attempts to model that too.

# Disclaimer

**Halo is very much an "assembled" project - almost everything in Halo has been tried before; so if you find some feature of Halo reminding you of some language of the past, its most probably true. There was just a wealth of ideas from the past that Halo couldnt help but borrow.**

# The big ideas

  * Everything is a graph
  * Programs are "actions" by an executor
  * Components are the smallest pieces of code
  * Every software system is a combination of human and machine.
  * Every program has 4 layers - Human, Application, Language and OS - at a chosen level of abstraction.
  * Modeling software change *in the language* is a good thing(TM).
  * Modeling the process by which software is created *in the language* is a good thing(TM).


# Basic Data and Actions

## Graphs

Halo represents all data as graphs. Graphs are represented in Halo thus:

    // halo syntax                       // graphviz syntax
    alias {                              digraph name {
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

    primitives {
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

### Attributes

Nodes can have attributes, which are represented very similar to attributes in Graphviz. For example:

    {
        car [isA=vehicle,type=land]
        plane [isA=vehicle,type=air]
        ship [isA=vehicle type=water]
    }

As you can see, multiple attributes are allowed and can be separated by whitespace or commas.

Halo enhances the attribute concept, however, with tags. Tags are categories that you can attach to each node, like so:

    {
        ferrari [type=vehicle,#awesome,#wishIhadOne]
    }

Yes, the syntax is borrowed from hashtags. They are used in Halo to filter nodes out, essentially and we'll soon see an example of this.

### Subgraphs

Anything more complicated than a symbol, number or string must be represented as a Subgraph and they're depicted like so:

    graph {
        subgraph {
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
    arrays {
        // simple 1D array
        array1 {
            1 2 3 4 5
            //referred above
            6
            7 8
            9 10
        }
        // another 1-D array shown with each element in its own line. no change in meaning.
        array2{
            abc
            def
            "ghi"
            "ghi mno"
        }
        // a 2D array
        2darray {
            { 1 2 3 4 5 }
            { 11 12 13 14 15 }
            { 111 112 113 114 115 }
        }
    }


[../test/hashtable.halo](#Hashtables "save:")
#### Hashtables

    //hashtable.halo
    hashtables{
        // simple name-value pair
        name1 { value1 }
        name2 { value2 }
        name3 { value3 }

        // another way is to have attributes on a single node
        hashtable [
            name1 = value1
            name2 = value2
            name3 = value3
        ]
        // if you want values that are compound themselves, here's how:
        hashtable2 {
            name1 {
                value11
                value12
            }
            name2 {
                value21
                value22
            }
        }
    }


[../test/object.halo](#Objects "save:")
#### Objects

    //object.halo
    objects{
        object {
            valueMember1
            compoundMember2 {
                childValue1
                compoundChild2 {
                    value1
                    value2
                    // this is actually another "value"
                    ....
                }
            }
        }
        // a list of students
        students {
            student1 {
                john
                smith
                gpa { 3.45 }
            }
            student2 {
                john
                doe
                gpa { 2.45 }
            }
            student3 {
                jane
                clark
                gpa { 4.45 }
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
