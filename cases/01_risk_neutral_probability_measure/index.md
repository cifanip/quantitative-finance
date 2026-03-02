---
title: Risk Neutral Probability Measure
layout: default
---

# Risk-Neutral Probability Measure

## 1. Theory
To set up our analysis, we begin by assuming the probability space $(\Omega, \mathcal{F}, \mathbb{P})$ and the Brownian motion $\\{ W(t) \\}\_{t \ge 0}$ are given. 

A central concept used in the following is the notion of a martingale. 

**Definition 1 (Martingale).**  
A stochastic process $\\{M(t)\\}\_{t \ge 0}$ is called a martingale with respect to the filtration $\\{\mathcal{F}(t)\\}\_{t \ge 0}$ if it is adapted to $\\{\mathcal{F}(t)\\}_{t \ge 0}$, $M(t)\in L^1(\Omega)$ for all $t\ge 0$, and

$$
\mathbb{E}[M(t)\mid \mathcal{F}_s] = M(s), \qquad 0 \le s \le t, \qquad (1.0)
$$

for all $t \ge 0$. From this defintion is clear that the process $M(t)$, conditioned on all the past informations up to time $s$, will on average neither rise nor fall on everage at future time $t$. 

### 1. Arbitrage-free market



