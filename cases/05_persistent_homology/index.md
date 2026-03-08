---
title: Persistent Homology
layout: default
---

# Persistent Homology

Persistent Homology is concerned with the studies of the shape of data by tracking how topological features appear and disappear across multiple scales. It finds applications in a wide range of fields, including data analysis, machine learning, image processing, computational biology and finance, where it helps uncover structural patterns in complex datasets. 

These theory presented in these notes is based on the lecture notes Introduction to Persistent Homology [^1]. They are intended as a condensed summary of the material, and any mistakes are my own. I am grateful to the author for making this material publicly available.

After introducing the fundamental concepts, a numerical example is presented to illustrate their application.

## 1. Theory

### Homotopy

The first concept needed is that of homotopy. The precise definition, given in [^1], is the following:

**Definition 1 (Homotopy)**

Continuous maps $f,g: X \to Y$ between metric spaces $X$ and $Y$ are homeotopic, denoted $f \simeq g$, if there exists a continuous deformation of $f$ into $g$. Such a deformation is called a homotopy. 

Next is the definition of homotopy equivalence.

**Definition 2 (Homotopy equivalence)**

Metric spaces $X$ and $Y$ are homotopy equivalent, denoted $X \simeq Y$, if there exist maps $f: X \to Y$ and $g:Y \to X$, sich that $f \circ g \simeq id_Y$ and $g \circ f \simeq id_X$. Such maps are called homotopy equivalences. Consider the simple example in Figure 1. 

<p align="center">
  <img src="figures/PH_sketch_1.png" width="40%">
</p>

<p align="center"><b>Figure 1:</b> Example of homotopy and homotopy equivalence.</p>

The space $X$ is composed of one single point. The space $Y$ is composed of a (full) disk to which a line is attached and a point. The map $f : X \to Y$ which sends $X$ into point $A$ in $Y$ is homotopic to the map $g : X \to Y$ that sends $X$ into point $B$ in $Y$. An example of homotopy is represented by the dahsed line connecting $A$ and $B$. The homotopy class $\[ f \]$ is the set of all maps that can be deformed into $f$. In this example we have two classes $\\{ [f_1], [f_2] \\}$, corresponding to the connected components of $Y$. The set $Y \setminus \\{ C\\}$ is homotopy equivalent to $X$, which is said to be contractible. 

As it turns out homotopy equivalent spaces have the same homology groups.

### Simplicial complexes and their constructions

We will not delve into the precise definition of simplicial complexes and their construction. We refer the interested reader to [^1] or to the many textbooks on this subject. The rough idea is the following: a simplicial complex is a space obtained by gluing simplices (points, line segments, triangles, and their higher-dimensional analogues) along their faces. When a topological space admits such a triangulation, its topological invariants (e.g., homology groups) can be computed from the corresponding simplicial complex. 

Since data are not given in the form of simplicial complexes, the preliminary step to computation is to construct such complexes. A widely used construction is the so-called **Rips complex**. 

We briefly introduce the necessary notation used in the remainder of this notes. Let $d,k \in \mathcal{N}$

### Homology


[^1]: Virk, Ž., 2022. Introduction to Persistent Homology. Založba UL FRI.
