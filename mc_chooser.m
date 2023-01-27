function [chooser_value, error] = mc_chooser(S0,K,r,sigma,T, t_c,N,M,gamma,Z)
% Chooser option pricing
% Inputs:
% S0          - Current price of the underlying asset.
% K           - Strike (i.e., exercise) price of the option.
% r           - Annualized continuously compounded risk-free rate of return
%               over the life of the option, expressed as a positive decimal
%               number.
% T           - Time to expiration of the option, expressed in years.
% t_c         - Time of choise
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
t = 0;

% Loop for number of simulations
for k=1:N
    t = t+dt;
    if abs(t - t_c) <= 1e-2
        S_t = S; % Price at time of choice
    end

    % Euler-Maruyama
    dW  = Z(:,k)*sqrt(dt);
    S = S + r*S*dt + sigma*S.^gamma.*dW;
end

[Call,Put] = blsprice(S0, K, r, T, sigma);
Exact = max(Call, Put);

discout = exp(-r*(T-t_c));
chooser_value = discout*( mean(max(S_t - K,0)) + mean(max(K*discout - S_t, 0)) );

error = abs(Exact - chooser_value);
end