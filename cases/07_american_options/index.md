---
title: American Options
layout: default
---

# American Options

This section summarizes results from the theory of American derivatives pricing. Background material can be found here: [notes on risk-neutral probability measure](https://github.com/cifanip/quantitative-finance/tree/main/cases/01_risk_neutral_probability_measure/)).

The theory presented in these notes is based on the lecture notes Stochastic Calculus, Financial Derivatives and PDE's [^1], by prof. S. Calogero. They are intended as a condensed summary of the material, and any mistakes are my own. I am grateful to the author for making this material publicly available.

## 1. Theory

In contrast to European options, American options can be excercised at any time $t \in (0,T]$, where $T$ is the maturity time. We assume the pay-off $Y(t)=g(S(t))$ for some measurable function $g$ of the stock price $S(t)$. Similarly to what we have seen for European options we have

$$
\begin{aligned}
g(x) &= (x-K)_+ \qquad \text{for call options,} \\
g(x) &= (K-x)_+ \qquad \text{for put options.}
\end{aligned}
$$






[^1]: Calogero, S., 2019. Stochastic Calculus Financial Derivatives and PDE’s. Lecture notes for the course MMA711 at Chalmers University of Technology.
