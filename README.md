# Risk Parity and Budgeting
## Abstract

### Problems to Solve

* ERC portfolios have high Sharpe ratio (~1.4) with relatively low annual return (~4.8%), which may not meet the expectation from customers.

* Bonds usually takes up a large portion in ERC portfolios (~70-80%), due to their low volatility and risk, which may limit the performance of the portfolio.

* Quantitative methods to determined the risk budget for RB portfolios.



### Data

Daily return of Wind A-Shares, S&P 500, China Treasury Bond Index, Nanhua Commodity Index, AU9999 and Hang Seng Index during the period of 12/01/2004 to 08/05/2019 from [Wind Information](https://www.wind.com.cn/en/default.html). 

Backtestings are performed from 12/01/2009 to 08/05/2009. Positions are changed monthly. In all backtesting, we account for 0.3% transaction cost.



### Model

**Benchmark:** **Risk parity** model, also known as equally weighted risk contribution (**ERC**), risk budget for each asset is equal.

<p align="center">
  <img src="fc1.png" weidth=25%>
</p>



**Max Sharpe ratio (maxSR):** Risk budget is a linear combination of Sharpe ratios, which maximize portfolio's Sharpe ratio.

<p align="center">
  <img src="fc2.png" weidth=60%>
</p>



**Squared Sharpe ratio (SRS):** Risk budget is proportional to squared Sharpe ratio, this formula is acquired when assuming zero correlation between assets.

<p align="center">
  <img src="fc3.png" weidth=10%>
</p>



SRS model is also tested with **momentum effect**, where the budget is set to zero if estimated Sharp ratio of a asset is negative. In addition, we developed **Sharpe ratio budget (SRB)** model with momentum effect, where risk budget is proportional to squared Sharpe ratio.

<p align="center">
  <img src="fc4.png" weidth=10%>
</p>



Returns and volatility, and hence Sharpe ratio, are estimated by computing mean and standard deviation of daily returns from the past N months, where N is the time window



### Result

* **SRS** is a strengthened version of ERC **(6.6% vs 4.9%)**, maintaining most of the Sharpe ratio when getting higher return.
* **MaxSR** is difficult to implement in practice as correlations between assets are difficult to estimate.
* **SRS and SRB with momentum** **(~8%)** are adapted version of momentum effect model, with more stability.  When comparing to original SRS model, they sacrifice some Sharpe ratio and get higher return. SRS with momentum generally has better performance than SRB with momentum.
* **Higher return** of SRS, SRS with momentum and SRB with momentum is acquired during years **when equity securities have higher return**.
* **Longer time windows** when estimating Sharpe ratio provides more **stable** portfolios.
* The performance of all models are improved when using GARCH model to get better prediction of volatility.



## Full Description

[[html]](https://htmlpreview.github.io/?https://github.com/y-yang42/ERC_RB/blob/master/Summary/Risk%20Parity%20and%20Risk%20Budgeting.html)	[[pdf]](./Summary/Risk%20Parity%20and%20Risk%20Budgeting.pdf)
