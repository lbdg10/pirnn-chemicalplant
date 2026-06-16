%% Initialization
n_states = [3,3,3,3,3,3];
states_tot = sum(n_states);
yk2_0 = 0.5*ones(4,1);
yk6_0 = 0.5*ones(4,1);
time_sim = 102;

%% Cambiare
xk0_obs = 0*ones(states_tot, 1);
xk0_mod = 0.9*ones(states_tot, 1);

%% Load
sim1 = load('sim001.mat');
sim2 = load('sim003.mat');
sim3 = load('sim005.mat');
sim4 = load('sim007.mat');
sim5 = load('sim009.mat');

x_norm_diff1 = zeros(1, time_sim);
x_norm_diff2 = zeros(1, time_sim);
x_norm_diff3 = zeros(1, time_sim);
x_norm_diff4 = zeros(1, time_sim);
x_norm_diff5 = zeros(1, time_sim);

for i=1:time_sim
    x_norm_diff1(1,i) = norm(sim1.x_obs(:,1,i) - sim1.x_mod(:,1,i), "inf");
    x_norm_diff2(1,i) = norm(sim2.x_obs(:,1,i) - sim2.x_mod(:,1,i), "inf");
    x_norm_diff3(1,i) = norm(sim3.x_obs(:,1,i) - sim3.x_mod(:,1,i), "inf");
    x_norm_diff4(1,i) = norm(sim4.x_obs(:,1,i) - sim4.x_mod(:,1,i), "inf");
    x_norm_diff5(1,i) = norm(sim5.x_obs(:,1,i) - sim5.x_mod(:,1,i), "inf");
end

%% Plot
time = 0:1:101;

figure('DefaultAxesFontSize',62); plot(time, x_norm_diff1,'LineWidth',4); hold on; plot(time, x_norm_diff2,'LineWidth',4); plot(time, x_norm_diff3,'LineWidth',4); plot(time, x_norm_diff4,'LineWidth',4); plot(time, x_norm_diff5,'LineWidth',4); 
xlabel('Time $[s]$', 'interpreter', 'latex', 'FontWeight', 'bold'); ylabel('$||\hat{x}_k-x_k||_{\infty}$', 'interpreter', 'latex'); box off; xlim([2 100]); xticks([20 40 60 80 100]); %set(gca,'linewidth',4)
