## 1. Theory
The central concept required for our analysis is the martingale. The precise definition is the following:

**Definition 1 (Martingale).**  
A stochastic process $\{M(t)\}\_{t \ge 0}$ is called a martingale with respect to the filtration $\{\mathcal{F}(t)\}\_{t \ge 0}$ if it is adapted to $\{F(t)\}_{t \ge 0}$, $M(t)\in L^1(\Omega)$ for all $t\ge 0$, and

$$
\mathbb{E}[M(t)\mid \mathcal{F}_s] = M(s), \qquad 0 \le s \le t,
$$

for all $t \ge 0$.
