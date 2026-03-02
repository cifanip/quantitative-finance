---
title: Risk Neutral Probability Measure
layout: default
---

# Risk-Neutral Probability Measure

## 1. Theory
To set up our analysis, we begin by assuming the probability space $(\Omega, \mathcal{F}, \mathbb{P})$ and the Brownian motion $\\{ W(t) \\}\_{t \ge 0}$ are given. The filtration $\\{ \mathcal{F}(t) \\}\_{t \ge 0 }$ is a non-anticipating filtration for the Brownian motion $\\{ W(t) \\}\_{t \ge 0}$.

### Martingale
A central concept used in the following is the notion of a martingale. 

**Definition 1**  
A stochastic process $\\{M(t)\\}\_{t \ge 0}$ is called a martingale with respect to the filtration $\\{\mathcal{F}(t)\\}\_{t \ge 0}$ if it is adapted to $\\{\mathcal{F}(t)\\}_{t \ge 0}$, $M(t)\in L^1(\Omega)$ for all $t\ge 0$, and

$$
\mathbb{E}[M(t)\mid \mathcal{F}_s] = M(s), \qquad 0 \le s \le t, \qquad (1.0)
$$

for all $t \ge 0$. From this defintion is clear that the process $M(t)$, conditioned on all the past informations up to time $s$, will on average neither rise nor fall on everage at future time $t$. As it will be clear in the next sections, condition (1.0) is tightly linked to arbitrage-free markets.

### Novikov's condition
Let $\\{ \theta(t) \\}\_{t \ge 0} \in \mathcal{C}^0[\mathcal{F}(t)]$ satisfy

$$
\mathbb{E}[\exp \left( \frac{1}{2} \int_0^T \theta(t)^2 dt \right)]< \infty, \qquad \text{for all } T>0. \qquad (1.1)
$$

**Theorem 1**  
Then the stochastic process $\\{ Z(t) \\}\_{t \ge 0}$ given by

$$
Z(t) = \exp \left( - \int_0^t \theta(s) dW(s) = \frac{1}{2} \int_0^t \theta(s)^2 ds \right) \qquad (1.2)
$$

is a martingale relative to the filtration $\\{ \mathcal{F}(t)\_{t \ge 0} \\}$. 

### Girsanov's theorem
Let $\\{ \theta(t) \\}\_{t \ge 0} \in \mathcal{C}^0[\mathcal{F}\_W(t)]$ satisfy condition (1.1). It follows from theorem Theorem 1 that process (1.2) is a martingale relative to the filtration $\\{\mathcal{F}\_W(t) \\}\_{t \ge 0}$. Then, by the martingale property, $\mathbb{E}[Z(t)]=\text{const}$ for all $t \ge 0$. But $Z(0)=1$, thus $\mathbb{E}[Z(t)]=1$ for all $t \ge 0$. Hence, one can use the stochastic process $\\{ Z(t) \\}\_{t \ge 0}$ to construct an equivalent probability measure $\widetilde{\mathbb{P}}$ to $\mathbb{P}$. 

**Theorem 2**
Consider the stochastic process $\\{ \widetilde{W}(t) \\}\_{t \ge 0}$

$$
\widetilde{W}(t) = W(t) + \int_0^t \theta(s) ds. \qquad (1.3)
$$

Then $\\{ \widetilde{W}(t) \\}\_{t \ge 0}$ is a $\widetilde{\mathbb{P}}$-Brownian motion. 

As a result we have that $\widetilde{\mathbb{E}}[\widetilde{W}(t)|\mathcal{F}\_W(s)] = \widetilde{W}(s)$, for $0 \le s \le t$. 

### Arbitrage-free market
We consider now a 1+1 dimensional market, that is a portoflio made of $\\{h\_{S(t)},h\_{B(t)} \\}$ shares of a stock $S(t)$ and of a bond $B(t)$. As is customary, the stock price $S(t)$ is assumed to evolve according to a geometric Brownian motion

$$
dS(t) = \mu(t)S(t)dt + \sigma(t) S(t) dW(t)
$$

and the bond price $B(t)$ follows the equation

$$
dB(t) = B(t)R(t)dt.
$$

The portfolio $\\{h\_{S(t)},h\_{B(t)} \\}\_{t ge 0}$ is said to be self-financing if its value $V(t)$ satisfies

$$
dV(t) = h\_S(t) dS(t) + h\_B(t) dB(t). \qquad (1.4)
$$

That is, any change in value resulting from a variation in the number of shares held in the stock or the bond must offset each other. In other words, changes in $V(t)$ arise solely from changes in the values of the stock and the bond. 

Now let $\\{ \theta(t) \\}\_{t ge 0}$ be the stochastic process

$$
\theta(t) = \frac{\mu(t) - R(t)}{\sigma(t)}
$$

and $\\{ Z(t) \\}\_{t ge 0}$ defined as in (1.2). 

