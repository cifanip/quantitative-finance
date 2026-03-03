---
title: Fractional Brownian Motion
layout: default
---

# Fractional Brownian Motion

Many phenomena in nature, most prominently the motion of particles suspended in a quiescent medium, are well described by standard Brownian Motion $B_t$. While this is a good approximation in several instances, studies on random processes, e.g. turbulent flows
and financial time series, have shown strong interdependence between distant samples. To this aim an extension was put forward in the seminal paper of Mandelbrot, 1968, where long-range dependence is regulated by the Hurst exponent $H \in (0,1)$. In the following, some basic results about Fractional Brownian Motion (FBM) and Fractional Brownian Noise (FBN) are illustrated with a focus on its implications for high-frequencies trading strategies. A recent application of FBM driven partciles and transport dynamics can be found in [^1]

[^1]: Cifani, P. and Flandoli, F., 2025. Diffusion Properties of Small-Scale Fractional Transport Models, Journal of Statistical Physics.

## 1. Theory

A cenetered Gaussian procces $B_t$ is defined to be a Fractional Brownian Motion if its covariance matrix has the following form:

$$
\mathbb{E}[B_t B_s] = \frac{1}{2} \left( s^{2H}+t^{2H} - |t-s|^{2H} \right). \qquad (1.0)
$$

As for standard Brownian Motion, recovered for $H=1/2$, a self-similarity exists: for any constant $a>0$, the process $\\{ a^{-H}B_{at}\\}\_{t \ge 0}$ has the same distribution as the process $\\{ B_{t}\\}\_{t \ge 0}$. This makes it appealing from a fincancial view-point, since it is often the case that time-series looked at different time-scales are found to be statistically equivalent. 

From (1.0) one finds that

$$
\mathbb{E}[ (B_t-B_s)^2] = |t-s|^{2H} . \qquad (1.1)
$$

The process has then stationary increments and the scaling of their covariance can be computed numerically. This property is a ‘fingerprint’ of such processes. 

