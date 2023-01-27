% Compare the value of the chooser option for varying
% values of the underlying asset S0

% Define specific parameters
K = 12;
r = 0.025;
sigma = 0.4;
T = 0.5;
t_c = 0.3;
N = 100;
M = 10000;
gamma = 1;

% Random variable vectors for Brownian motion
Z1 = randn(M,N);
Z2 = randn(M,N);
Z3 = randn(M,N);

S0 = linspace(1, 23, 40);
Val = zeros(3,length(S0));

for i = 1:length(S0)
    [V2, err_choo] = mc_chooser(S0(i),K,r,sigma,T, t_c,N,M,gamma,Z1);
    
    [Call1, Put1, err_c1, err_p1] = monte_carlo(S0(i),K,r,sigma,T,N,M,gamma,Z2);
    [Call2, Put2, err_c2, err_p2] = monte_carlo(S0(i),K,r,sigma,T,N,M,gamma,Z3);

    Val(1, i) = V2;
    Val(2, i) = Call1;
    Val(3, i) = Put2;
end

plot(S0, Val(1, :), 'ro')
hold on 
plot(S0, Val(2, :), 'b*')
hold on
plot(S0, Val(3, :), 'g*')
legend('Chooser option', 'Euopean Call option', 'European Put option')
xlabel('Underlying price S_0')
ylabel('Option value V')