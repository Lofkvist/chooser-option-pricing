% Compare the value of the chooser option for varying
% chooser times t_c

% Define specific parameters
K = 12;
S0 = 10;
r = 0.025;
sigma = 0.4;
T = 0.5;
N = 100;
M = 10000;
gamma = 1;

% Random variable vectors for Brownian motion
Z1 = randn(M,N);
Z2 = randn(M,N);
Z3 = randn(M,N);

t_c = linspace(1e-4, 0.5, 40);
val = zeros(1, length(t_c));

for i = 1:length(t_c)
    [V2, err_choo] = mc_chooser(S0,K,r,sigma,T, t_c(i),N,M,gamma,Z1);
    val(i) = V2;
end

plot(t_c, val, 'ro')
grid on
legend('Chooser option')
xlabel('Time of chose t')
ylabel('Option value V')