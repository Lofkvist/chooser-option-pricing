# Pricing of a chooser option 
These MATLAB scripts implements a solver for pricing a simple chooser option. The price of the underlying asset is simulated using the Black-Scholes model

$$\frac{\partial V}{\partial t} + \frac{1}{2}\sigma^2S^2 \frac{\partial^2 V}{\partial S^2} + rS\frac{\partial V}{\partial S} - rV = 0$$

A simple chooser option gives the buyer the right to choose at time $t$ whether the option should be a European call or put option with strike price $K$ and expiration time $T > t$. The script delta_greek.m calculates the quantity $\Delta = \partial V/\partial S, which shows the rate of change of the theoretical option with respect to change in the underlying asset

## Results
### The price of the chooser option compared to European call and put option:
![alt text](https://github.com/Lofkvist/chooser-option-pricing/blob/main/price_vs_underlying.png?raw=true)

### Value of chooser option for varying chooser times $t$
![alt text](https://github.com/Lofkvist/chooser-option-pricing/blob/main/time_choice.png?raw=true)

### $\Delta$ calculated for varying prices of the underlying $S_0$
![alt text](https://github.com/Lofkvist/chooser-option-pricing/blob/main/delta.png?raw=true)
