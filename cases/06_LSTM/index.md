---
title: LSTM
layout: default
---

# LSTM forecasting

In this page we illustrate the capabilities of a LSTM neural network in terms of forecasting. Here we assume that the reader is already familiar with theory behind LSTM networks and with neural networks in general. 

The open-source library PyTorch [^1] has been used to generate part of the presented results.

The notation and the problem definition are briefly introduced. Let the sequence $\mathbf{X}\_T=\\{ x_1,x_2,...,x_T \\}$ denote a multivariate time-series sampled at discrete points $x_i \in \mathbb{R}^n$. Let $\mathbf{X}\_B \subset \mathbf{X}\_T$ denote a batch of $b$ samples $\\{ x\_{t-b+1},...,x_t \\}$. We consider the problem of forecasting $x_{t+1}$ given $\mathbf{X}\_B$. In particular, the loss function with respect to a bastch of data is defined by

$$
\mathcal{L}_B(\theta) = \lVert x_{t+1} - h_\theta(\mathbf{X}\_B) \rVert_2,
$$

with $h_\theta$ being the LSTM network. The overall loss is thus

$$
\mathcal{L}(\theta) = \frac{1}{|\mathcal{B}|} \sum_{B \in |\mathcal{B}|} \mathcal{L}_B(\theta). 
$$



We consider the problem of forecasting $x_{T+1}$ given $\mathbf{X}_T$. 

The prototype model employed are the Mackey–Glass equations. They refer to a family of delayed differential equations used to model blood cell production. Our interest here lies in the fact that the dynamics of the systems depends non-linearly from past information. This mimics financial mechanisms that react with a certain delay to key events in the past. 

The equations are the following:

$$
\frac{dx(t)}{dt} = \frac{\beta x(t-\tau)}{1+x(t-\tau)^n} - \gamma x(t), \qquad (1)
$$

where $x \in \mathbb{R}$. An example of the solution $x(t)$ over time is shown in Figure 1. Parameters have been chosen such that the system becomes chaotic. 

<p align="center">
  <img src="figures/xt_series.png" width="60%">
</p>

<p align="center"><b>Figure 1:</b> Evolution of $x(t)$ over time.</p>

The neural network has been trained on a dataset consisting of approximately $4000$ batches with a training-to-test split ratio of $0.7$. The batch length $b$ has been set to a value close to the lag $\tau$. Figure 2 shows the forecasting of a sequence of $x(t)$ in the test set. 

<p align="center">
  <img src="figures/xt_forecast.png" width="60%">
</p>

<p align="center"><b>Figure 1:</b> Forecasting (red circles) of $x(t)$ (solid black line). These results were generated using PyTorch [^1]. </p>

The accuracy of the LSTM predictions is satisfactory. Fine tuning of the network hyperparameters may improve the forecasting even further, but the point here is rather to show that this network architecture does a good job at learning non-linear dependence in past observations. 

A perhaps more compelling case for finance applications is a probabilistic forecast. For example, consider the scenario where past market observations are recorded and the aim is to predict whether the next observation will be positive. The network learns the conditional probability distribution

$$
p_\theta(y_{t+1} > 0 | y_t,...,y_{t-m+1})
$$

by minimising log-likelihood of the Bernoulli distribution

$$
\mathcal{L}(\theta) = - z \text{ln}p_\theta-(1-z)\text{ln}(1-p_\theta),
$$

where $z$ is a binary variable that takes value $1$ in the event $y_{t+1} > 0$ and $0$ otherwise. A learned distribution brings more value to the forecast. One not only predicts a future movement, but also the spread in the prediction. 

The success of a forecast is often determined by the quality of input data, rather than by the particular details of the network architecture. Preprocessing is, in fact, a crucial step and raw sequential data is seldom used. Methods to prepare input data are numerous and among these are filtering, convolutional neural networks, autoencoders and many others. Perhaps an interesting approach is persistent homology (see dedicated section here: [notes on persistent homology](https://github.com/cifanip/quantitative-finance/tree/main/cases/05_persistent_homology/)), where key topological structures are extracted from data. 

[^1]: Paszke, A. et al. (2019). *PyTorch: An Imperative Style, High-Performance Deep Learning Library*. NeurIPS 2019. Repository: PyTorch. https://github.com/pytorch/pytorch

