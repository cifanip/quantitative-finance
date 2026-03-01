# Quant Research Portfolio (Finance)

A collection of reproducible quantitative finance case studies, written like mini research notes:
**problem → theory (equations) → implementation → plots → evaluation → conclusions**.

## Case Studies
1. **Mean-Variance Portfolio Optimization** (with shrinkage + constraints)
2. **Pairs Trading** (cointegration + walk-forward validation)
3. **Volatility Forecasting** (GARCH / HAR / realized volatility)
4. **Equity Factor Model** (cross-sectional regression + IC analysis)

## Reproducibility
- Python environment: see `environment.yml` (or `requirements.txt`)
- Each case has its own `cases/<case_name>/README.md` with exact run steps.

## Research Standards Used
- No look-ahead bias
- Walk-forward / time-series CV where appropriate
- Transaction costs & turnover reporting
- Clear assumptions + limitations
