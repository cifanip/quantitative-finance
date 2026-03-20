---
title: American Options
layout: default
---

# American Options

This section summarizes results from the theory of American derivatives pricing. Background material can be found here: [notes on risk-neutral probability measure](https://github.com/cifanip/quantitative-finance/tree/main/cases/01_risk_neutral_probability_measure/)).

The theory presented in these notes is based on the lecture notes Stochastic Calculus, Financial Derivatives and PDE's [^1], by prof. S. Calogero. They are intended as a condensed summary of the material, and any mistakes are my own. I am grateful to the author for making this material publicly available.

## 1. Theory

In contrast to European options, American options can be excercised at any time $t \in (0,T]$, where $T$ is the maturity time. Let $Y(t)=g(S(t))$, for some measurable function $g$ of the stock price $S(t)$, be the pay-off of the option if it were exercised at time $t$. We call $Y(t)$ the intrinsic value of the option. Similarly to what we have seen for European options we have

$$
\begin{aligned}
g(x) &= (x-K)_+ \qquad \text{for call options,} \\
g(x) &= (K-x)_+ \qquad \text{for put options.}
\end{aligned}
$$

Nest, we define $\widehat{\Pi}_Y(t)$ and $\Pi_Y(t)$ the price of the American and Euoropean option, respectively. Two basic principles should apply to determine $\widehat{\Pi}_Y(t)$:

1. $\widehat{\Pi}_Y(t) \geq \Pi_Y(t)$ for all $t \in [0,T]$. This is reasonable since American options give its owner the additional possibility of early excercise compared to European options, to which it should correspond a higher premium.
2. $\widehat{\Pi}_Y(t) \geq Y(t)$ otherwise an arbitrage would exist simply by purchsing the option at $\widehat{\Pi}_Y(t)$ and excerising immedediately to gain $Y(t)-\widehat{\Pi}_Y(t)$.

For an American option we thus have always two choises: excercise and obtain the payoff $Y(t)$ or wait and keep the option with value $\widehat{\Pi}_Y(t)$. When $\widehat{\Pi}_Y(t)>Y(t)$ there is an expectation that the value of the underlying stock will rise, in which case excercising is not optimal. On the other hand, when $\widehat{\Pi}_Y(t)=Y(t)$ excercising is optimal, given the available information at time $t$. This is called the **optimal excercise time**. 

**Theorem 1**

Assume that we are under condition 1., i.e. $\widehat{\Pi}_Y(t) \geq \Pi_Y(t)$ for all $t \in [0,T]$. We denote by $\widehat{C}(t)$ the price an American call option. Then $\widehat{C}(t) > Y(t)$ for all $t \in [0,T)$. Thus, it is never optional to excercise prior to maturity $T$.

The proof is rather simple. If $S(t)<K$, since $\widehat{C}(t) \geq 0$, the clain in trivial. Is then sufficient to look at the case $S(t)-K \geq 0$. Recall from [notes on risk-neutral probability measure](https://github.com/cifanip/quantitative-finance/tree/main/cases/01_risk_neutral_probability_measure/)) that the price of European call option is 

$$
\Pi_Y(t) = \widetilde{\mathbb{E}} [ (S(T)-K)_+ D(T)/D(t) | \mathcal{F}_W(t) ]. \qquad (1.0)
$$

Therefore by condition 1. we have:

$$
\begin{aligned}
\widehat{C}(t) & \geq \widetilde{\mathbb{E}} [ (S(T)-K)_+ D(T)/D(t) | \mathcal{F}_W(t) ] \\
& \geq [ (S(T)-K) D(T)/D(t) | \mathcal{F}_W(t) ]
\end{algined}
$$


[^1]: Calogero, S., 2019. Stochastic Calculus Financial Derivatives and PDE’s. Lecture notes for the course MMA711 at Chalmers University of Technology. 
