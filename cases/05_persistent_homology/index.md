---
title: Persistent Homology
layout: default
---

# Persistent Homology

Persistent Homology is concerned with the studies of the shape of data by tracking how topological features appear and disappear across multiple scales. It finds applications in a wide range of fields, including data analysis, machine learning, image processing, computational biology and finance, where it helps uncover structural patterns in complex datasets. 

These theory presented in these notes is based on the lecture notes Introduction to Persistent Homology [^1]. They are intended as a condensed summary of the material, and any mistakes are my own. I am grateful to the author for making this material publicly available.

After introducing the fundamental concepts, a numerical example is presented to illustrate their application.

## 1. Theory

The first concept needed is that of **homotopy**. The precise definition, given in [^1], is the following:

**Definition 1 (Homotopy)**

Continuous maps $f,g: X \to Y$ between metric spaces $X$ and $Y$ are homeotopic, denoted $f \simeq g$, if there exists a continuous deformation of $f$ into $g$. Such a deformation is called a homotopy. 

Next is the definition of homotopy equivalence.

**Definition 2 (Homotopy equivalence)**

Metric spaces $X$ and $Y$ are homotopy equivalent, denoted $X \simeq Y$, if there exist maps $f: X \to Y$ and $g:Y \to X$, sich that $f \circ g \simeq id_Y$ and $g \circ y \simeq id_X$. Such maps are called homotopy equivalences. Consider the simple example in Figure 1. 

<p align="center">
  <img src="figures/PH_sketch_1.png" width="40%">
</p>

<p align="center"><b>Figure 1:</b> Example of homotopy and homotopy equivalence.</p>

The space $X is compoed of one single point. The space $Y$ is composed of a (full) disk to which a line is attached and a point. 


[^1]: Virk, Ž., 2022. Introduction to Persistent Homology. Založba UL FRI.
