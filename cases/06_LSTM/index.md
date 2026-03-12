---
title: LSTM
layout: default
---

# LSTM forecasting

In this page we illustrate the capabilities of a LSTM neural network in terms of forecasting. Here we assume that the reader is already familiar with theory behind LSTM networks and with neural networks in general. The notation and the problem definition are briefly introduced. Let $\mathbf{X}$ denote a multivariate time series 

The prototype model employed are the Mackey–Glass equations. They refer to a family of delayed differential equations used to model blood cell production. Our interest here lies in the fact that the dynamics of the systems depends non-linearly from past information. This mimics finanacial mechanisms that react with a certain dealy to key events in the past. 

The equations are the following:

$$
\frac{dx(t)}{dt} = \frac{\beta x(t-\tau)}{1+x(t-\tau)^n} - \gamma x(t). \qquad (1)
$$

An example of the solution $x(t)$ over time is shown in Figure 1. Parameters have been chosen such that the system becomes chaotic. 

<p align="center">
  <img src="figures/xt_series.png" width="60%">
</p>

<p align="center"><b>Figure 1:</b> Evolution of $x(t)$ over time.</p>


