function [call, put, error_call, error_put] = mc(S0,K,r,sigma,T,N,M,gamma,Z)
% European call option pricing.
% Compute European call option prices using Euler's method and Monte Carlo 
% Simulation.
% Inputs:
% S0          - Current price of the underlying asset.
% K           - Strike (i.e., exercise) price of the option.
% r           - Annualized continuously compounded risk-free rate of return
%               over the life of the option, expressed as a positive decimal
%               number.
% T           - Time to expiration of the option, expressed in years.
% sigma       - Annualized asset price volatility (i.e., annualized standard
%               deviation of the continuously compounded asset return),
%               expressed as a positive decimal number.
% N           - Number of timesteps
% M           - Number of simulations
% Gamma       - controls the relationship between volatility and price
%               [0,1]
% Z           - Brownian motion
% Output:
% Value       - Price (i.e., value) of a European call option.
% Error       - Absolute error between the Black-Scholes analytical price and
%               the simulated approximation

dt = T/N;  
S = S0*ones(M,1);

for k=1:N % Loop for number of simulations
    dW  = Z(:,k)*sqrt(dt);
    S = S + r*S*dt + sigma*S.^gamma.*dW; % Euler-Maruyama
end
call = exp(-r*T)*mean(max(S-K,0)); %Expected value
put = exp(-r*T)*mean(max(K-S,0)); %Expected value
[call_exact, put_exact] = blsprice(S0,K,r,T,sigma);
error_call = abs(call_exact - call);
error_put = abs(put_exact - put);
end