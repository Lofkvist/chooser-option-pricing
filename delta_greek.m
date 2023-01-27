% Calculate the delta quantity of a chooser option

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
Z4 = randn(M,N);


S0 = linspace(2, 23, 40);
dS0 = 1;
delta_cho = zeros(1,length(S0));
delta_call = zeros(1,length(S0));
delta_put = zeros(1,length(S0));

for i = 1:length(S0)
    [V1, err1] = mc_chooser(S0(i) + dS0,K,r,sigma,T, t_c,N,M,gamma,Z1);
    [V2, err2] = mc_chooser(S0(i) - dS0,K,r,sigma,T, t_c,N,M,gamma,Z2);

    [Call1, Put1, err_c1, err_p1] = monte_carlo(S0(i) + dS0,K,r,sigma,T,N,M,gamma,Z3);
    [Call2, Put2, err_c2, err_p2] = monte_carlo(S0(i) - dS0,K,r,sigma,T,N,M,gamma,Z4);
    
    delta_cho(i) = (V1 - V2)/(2*dS0);
    delta_call(i) = (Call1 - Call2)/(2*dS0);
    delta_put(i) = (Put1 - Put2)/(2*dS0);
end

% Plot and compare Chooser, Put and Call options
plot(S0, delta_cho, 'ro')
hold on
plot(S0, delta_call, 'b*')
hold on
plot(S0, delta_put, 'g*')
hold on
width = 1.5;
yline(0, 'm:', 'LineWidth', width)
hold on
yline(-1, 'm:', 'LineWidth', width)
hold on
yline(1, 'm:', 'LineWidth', width)
ylim([-1.5, 1.5])
legend('{\Delta} Chooser option', '{\Delta} Euopean Call option', '{\Delta} European Call option')
xlabel('Underlying price S_0')
ylabel('Option value V')