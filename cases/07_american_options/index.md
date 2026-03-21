---
title: American Options
layout: default
---

# American Options

This section summarises results from the theory of American derivatives pricing. Background material can be found here: [notes on risk-neutral probability measure](https://github.com/cifanip/quantitative-finance/tree/main/cases/01_risk_neutral_probability_measure/).

The theory presented in these notes is based on the lecture notes Stochastic Calculus, Financial Derivatives and PDE's [^1], by prof. S. Calogero. They are intended as a condensed summary of the material, and any mistakes are my own. I am grateful to the author for making this material publicly available.

## 1. Theory

In contrast to European options, American options can be exercised at any time $t \in (0,T]$, where $T$ is the maturity time. Let $Y(t)=g(S(t))$, for some measurable function $g$ of the stock price $S(t)$, be the pay-off of the option if it were exercised at time $t$. We call $Y(t)$ the intrinsic value of the option. Similarly to what we have seen for European options we have

$$
\begin{aligned}
g(x) &= (x-K)_+ \qquad \text{for call options,} \\
g(x) &= (K-x)_+ \qquad \text{for put options.}
\end{aligned}
$$

Nest, we define $\widehat{\Pi}_Y(t)$ and $\Pi_Y(t)$ the price of the American and European option, respectively. Two basic principles should apply to determine $\widehat{\Pi}_Y(t)$:

1. $\widehat{\Pi}_Y(t) \geq \Pi_Y(t)$ for all $t \in [0,T]$. This is reasonable since American options give its owner the additional possibility of early exercise compared to European options, to which it should correspond a higher premium.
2. $\widehat{\Pi}_Y(t) \geq Y(t)$ otherwise an arbitrage would exist simply by purchasing the option at $\widehat{\Pi}_Y(t)$ and exercising immediately to gain $Y(t)-\widehat{\Pi}_Y(t)$.

For an American option we thus have always two choices: exercise and obtain the payoff $Y(t)$ or wait and keep the option with value $\widehat{\Pi}_Y(t)$. When $\widehat{\Pi}_Y(t)>Y(t)$ there is an expectation that the value of the underlying stock will rise, in which case exercising is not optimal. On the other hand, when $\widehat{\Pi}_Y(t)=Y(t)$ exercising is optimal, given the available information at time $t$. This is called the **optimal exercise time**. 

**Theorem 1**

Assume that we are under condition 1., i.e. $\widehat{\Pi}_Y(t) \geq \Pi_Y(t)$ for all $t \in [0,T]$. We denote by $\widehat{C}(t)$ the price an American call option. Then $\widehat{C}(t) > Y(t)$ for all $t \in [0,T)$. Thus, it is never optional to exercise prior to maturity $T$.

The proof is rather simple. If $S(t)<K$, since $\widehat{C}(t) \geq 0$, the clain in trivial. Is then sufficient to look at the case $S(t)-K \geq 0$. Recall from [notes on risk-neutral probability measure](https://github.com/cifanip/quantitative-finance/tree/main/cases/01_risk_neutral_probability_measure/) that the price of European call option is 

$$
\Pi_Y(t) = \widetilde{\mathbb{E}} [ (S(T)-K)_+ D(T)/D(t) | \mathcal{F}_W(t) ]. \qquad (1.0)
$$

Therefore by condition 1. we have:

$$
\begin{aligned}
\widehat{C}(t) & \geq \widetilde{\mathbb{E}} [ (S(T)-K)_+ D(T)/D(t) | \mathcal{F}_W(t) ] \\
& \geq [ (S(T)-K) D(T)/D(t) | \mathcal{F}_W(t) ] \\
& =  [ S(T) D(T)/D(t) | \mathcal{F}_W(t) ] - K [ D(T)/D(t) | \mathcal{F}_W(t) ] \\
& > D(t)^{-1} [ S(T) D(T) | \mathcal{F}_W(t) ] - K \\
& = S(t)-K.
\end{aligned}
$$

Here we used: $D(t)$ is $\mathcal{F}_W(t)$ measurable; $D(T)/D(t)$ is positive ($R(t)>0$); the discounted price $\\{ S(t)D(t) \\}$ is a $\widetilde{\mathbb{P}}$-martingale. 

If it is then never optimal to exercise the American call option, then its value must be equal to that of a European option (see again point 1.). 

A couple of remarks are in order. Since interest rate is (assumed to be) positive, the amount to buy shares at $K$ one needs to exercise can be invested to earn interests. This favours waiting and dominates exercising early. However, here we are not considering dividends. If we allow them, then exercising early might be convenient since by holding the actual stock just purchased we receive dividends, while we obviously do not receive dividends if we hold the option. 

For put American options the picture is different. A formal definition of **stopping time** is needed [^1]. A random variable $\tau \ : \ \Omega \to [0,T]$ is called a stopping time for the filtration $\\{ \mathcal{F}(t)_W \\}\_{t \geq 0}$ if $\\{ \tau \leq t \\} \in \mathcal{F}_W(t)$, for all $t \in [0,T]$. In plain terms, $\tau$ corresponds to a random event happening before or at time $t$ that can be inferred by the information in the filtration $\mathcal{F}(t)_W$. Here we are interested in the event where $\widehat{\Pi}_Y(t) = Y(t)$. 

We recall that the expression (1.0) takes for constant parameters and under the assumptions that the stock price follows a geometric Brownian motion:

$$
\Pi_Y(t,T) = \widetilde{\mathbb{E}} [ (e^{-r(T-t)} g( S(t) e^{ (r-\frac{1}{2}\sigma^2)(T-t) } e^{ \sigma(\widetilde{W}(T) - \widetilde{W}(t)) } )   | \mathcal{F}_W(t) ]. \qquad (1.1)
$$

For European options the stopping time equals the maturity time $T$. For American options, however, the stopping time is the random variable $\tau$ defined earlier. A reasonable definition of American put option price is therefore the following:

$$
\widehat{\Pi}_Y(t,T) = \max\limits_{\tau \in \mathcal{Q}_{t,T}} \widetilde{\mathbb{E}} [ (e^{-r(\tau-t)} g( S(t) e^{ (r-\frac{1}{2}\sigma^2)(\tau-t) } e^{ \sigma(\widetilde{W}(\tau) - \widetilde{W}(t)) } )   | \mathcal{F}_W(t) ], \qquad (1.2)
$$

where $\mathcal{Q}_{t,T}$ is the set of all possible stopping times $\tau \in [t,T]$.

[^1]: Calogero, S., 2019. Stochastic Calculus Financial Derivatives and PDE’s. Lecture notes for the course MMA711 at Chalmers University of Technology. 
