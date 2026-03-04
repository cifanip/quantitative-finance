---
title: Pairs Trading
layout: default
---

# Pairs Trading

In essence, pairs trading aims to construct a mean-reverting process by combining price signals that contain drift. If such an endeavour is successful, one obtains a statistical arbitrage opportunity. A long position initiated at a price well below the mean of the process will generate a positive return when the process will reveret to its mean. The opposite is be true for a short position. 

## 1. Theory
The mathematics behind pairs trading is known as **cointegration**. In the following, I will introduce the necessary tool to understand cointegrated processes.

### VAR(p) processes
The vector autoregressive model of order $p$, namely VAR(p), is defined as follows:

$$
y_t = \nu + A_1 y_{t-1}+ ... + A_p y_{t-p} + u_t, \qquad t \ge p \qquad\qquad  (1.0)
$$

where $y_t = (y_{1t},...,y_{Kt})'$ is a $K$-dimensional random vector, $A_i$ are coefficient matrices of size $(K \times K)$, $\nu=(\nu_1,...,\nu_K)'$ is vector of constants of size $(K\times 1)$ and $u_t=(u_1,...,u_K)'$ is a $K$-dimensional white noise vector with covariance $\mathbb{E}[u_tu_s']= \delta_{t,s} \Sigma_u$. 

Model (1.0) can be conviniently reqritten in a $Kp$-dimensional form:

$$
\mathbf{Y}_t = \boldsymbol{\nu} + \mathbf{A} \mathbf{Y}_{t-1} + \mathbf{U}_t (1.1)
$$

where $\mathbf{Y}_t = (y\_t, y\_{t-1},...,y\_{t-p+1})$ (see [^1] for the complete defition of the terms in (1.1))


[^1]: Kilian, L., 2006. New introduction to multiple time series analysis, by helmut lütkepohl, springer, 2005. Econometric theory.
