The Halo programming language User Guide
========================================

# Overview
# Basic Data and Actions

Halo represents all data as graphs. The three main types of data, therefore are:

* Nodes
* Edges
* Graphs

The syntax draws a lot of inspiration from [Graphviz](http://www.graphviz.org)'s dotformat; so if you're familiar with it, reading halo source should be easy.

## Nodes
[../test/primitives.halo](#Primitive Data Types "save:")
### Primitive Data types
The simplest nodes are atomic symbols, like so:

    primitives {
        // integer
        123
        // signed int
        "-123"
        // real
        "123.45"
        // e notation
        "123.45e-10"
        // strings: the two words are two nodes in halo
        hello world
        // string: this is one node
        "hello world"
    }


### Compound data types

[../test/arrays.halo](#Arrays "save:")
#### Arrays
Arrays can be expressed like so:

	// demonstrates representing arrays in halo
    // this works because all nodes have a natural index assigned to them.
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
            // yes rows have to have names
            row1 { 1 2 3 4 5 }
            row2 { 11 12 13 14 15 }
            row1 { 111 112 113 114 115 }
        }
    }
    

## Edges
## Graphs

# Contexts and the `run` Action
# Human Actions
# Prototypes and Halo as a documentation language
# Halo as an analysis language
# Meta data and meta code

