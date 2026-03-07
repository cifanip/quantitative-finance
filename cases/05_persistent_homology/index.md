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

**Definition 1**

Continuous maps $f,g: X \to Y$ between metric spaces $X$ and $Y$ are homeotopic, denoted by $f \simeq g$, if there exists a continuous deformation of $f$ into $g$. Such a deformation is called a homotopy. 




[^1]: Virk, Ž., 2022. Introduction to Persistent Homology. Založba UL FRI.
