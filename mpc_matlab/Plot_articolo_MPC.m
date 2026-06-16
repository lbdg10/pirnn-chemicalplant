%% Read directly from simulation
len = 400;
in = 1;
y_q_R1 = out_y(in:end,1);
y_xR1_1 = out_y(in:end,2);
y_xR1_2 = out_y(in:end,3);
y_xR1_3 = out_y(in:end,4);
y_xR1_4 = out_y(in:end,5);
y_D1 = out_y(in:end,6);
y_xd1_1 = out_y(in:end,7);
y_xd1_2 = out_y(in:end,8);
y_xd1_3 = out_y(in:end,9);
y_xd1_4 = out_y(in:end,10);
y_B1 = out_y(in:end,11);
y_xb1_1 = out_y(in:end,12);
y_xb1_2 = out_y(in:end,13);
y_xb1_3 = out_y(in:end,14);
y_xb1_4 = out_y(in:end,15);
y_B2 = out_y(in:end,16);
y_xb2_1 = out_y(in:end,17);
y_xb2_2 = out_y(in:end,18);
y_xb2_3 = out_y(in:end,19);
y_xb2_4 = out_y(in:end,20);
y_q_R2 = out_y(in:end,21);
y_xR2_1 = out_y(in:end,22);
y_xR2_2 = out_y(in:end,23);
y_xR2_3 = out_y(in:end,24);
y_xR2_4 = out_y(in:end,25);
y_q_R3 = out_y(in:end,26);
y_xR3_1 = out_y(in:end,27);
y_xR3_2 = out_y(in:end,28);
y_xR3_3 = out_y(in:end,29);
y_xR3_4 = out_y(in:end,30);
y_D3 = out_y(in:end,31);
y_xd3_1 = out_y(in:end,32);
y_xd3_2 = out_y(in:end,33);
y_xd3_3 = out_y(in:end,34);
y_xd3_4 = out_y(in:end,35);

% Compute the product
y1 = y_q_R1.*y_xR1_1;
y2 = y_q_R1.*y_xR1_2;
y3 = y_q_R1.*y_xR1_3;
y4 = y_q_R1.*y_xR1_4;
y5 = y_D1.*y_xd1_1;
y6 = y_D1.*y_xd1_2;
y7 = y_D1.*y_xd1_3;
y8 = y_D1.*y_xd1_4;
y9 = y_B1.*y_xb1_1;
y10 = y_B1.*y_xb1_2;
y11 = y_B1.*y_xb1_3;
y12 = y_B1.*y_xb1_4;
y13 = y_B2.*y_xb2_1;
y14 = y_B2.*y_xb2_2;
y15 = y_B2.*y_xb2_3;
y16 = y_B2.*y_xb2_4;
y17 = y_q_R2.*y_xR2_1;
y18 = y_q_R2.*y_xR2_2;
y19 = y_q_R2.*y_xR2_3;
y20 = y_q_R2.*y_xR2_4;
y21 = y_q_R3.*y_xR3_1;
y22 = y_q_R3.*y_xR3_2;
y23 = y_q_R3.*y_xR3_3;
y24 = y_q_R3.*y_xR3_4;
y25 = y_D3.*y_xd3_1;
y26 = y_D3.*y_xd3_2;
y27 = y_D3.*y_xd3_3;
y28 = y_D3.*y_xd3_4;

u_opt = zeros(len, 4);
for i=1:len
    u_opt(i,:) = out_u(:,1,i).';
end

%% Read from file
file = load("MPC_results_400s_R001.mat");

len = 400;
in = 1;
y_q_R1 = file.out_y(in:end,1);
y_xR1_1 = file.out_y(in:end,2);
y_xR1_2 = file.out_y(in:end,3);
y_xR1_3 = file.out_y(in:end,4);
y_xR1_4 = file.out_y(in:end,5);
y_D1 = file.out_y(in:end,6);
y_xd1_1 = file.out_y(in:end,7);
y_xd1_2 = file.out_y(in:end,8);
y_xd1_3 = file.out_y(in:end,9);
y_xd1_4 = file.out_y(in:end,10);
y_B1 = file.out_y(in:end,11);
y_xb1_1 = file.out_y(in:end,12);
y_xb1_2 = file.out_y(in:end,13);
y_xb1_3 = file.out_y(in:end,14);
y_xb1_4 = file.out_y(in:end,15);
y_B2 = file.out_y(in:end,16);
y_xb2_1 = file.out_y(in:end,17);
y_xb2_2 = file.out_y(in:end,18);
y_xb2_3 = file.out_y(in:end,19);
y_xb2_4 = file.out_y(in:end,20);
y_q_R2 = file.out_y(in:end,21);
y_xR2_1 = file.out_y(in:end,22);
y_xR2_2 = file.out_y(in:end,23);
y_xR2_3 = file.out_y(in:end,24);
y_xR2_4 = file.out_y(in:end,25);
y_q_R3 = file.out_y(in:end,26);
y_xR3_1 = file.out_y(in:end,27);
y_xR3_2 = file.out_y(in:end,28);
y_xR3_3 = file.out_y(in:end,29);
y_xR3_4 = file.out_y(in:end,30);
y_D3 = file.out_y(in:end,31);
y_xd3_1 = file.out_y(in:end,32);
y_xd3_2 = file.out_y(in:end,33);
y_xd3_3 = file.out_y(in:end,34);
y_xd3_4 = file.out_y(in:end,35);

% Compute the product
y1 = y_q_R1.*y_xR1_1;
y2 = y_q_R1.*y_xR1_2;
y3 = y_q_R1.*y_xR1_3;
y4 = y_q_R1.*y_xR1_4;
y5 = y_D1.*y_xd1_1;
y6 = y_D1.*y_xd1_2;
y7 = y_D1.*y_xd1_3;
y8 = y_D1.*y_xd1_4;
y9 = y_B1.*y_xb1_1;
y10 = y_B1.*y_xb1_2;
y11 = y_B1.*y_xb1_3;
y12 = y_B1.*y_xb1_4;
y13 = y_B2.*y_xb2_1;
y14 = y_B2.*y_xb2_2;
y15 = y_B2.*y_xb2_3;
y16 = y_B2.*y_xb2_4;
y17 = y_q_R2.*y_xR2_1;
y18 = y_q_R2.*y_xR2_2;
y19 = y_q_R2.*y_xR2_3;
y20 = y_q_R2.*y_xR2_4;
y21 = y_q_R3.*y_xR3_1;
y22 = y_q_R3.*y_xR3_2;
y23 = y_q_R3.*y_xR3_3;
y24 = y_q_R3.*y_xR3_4;
y25 = y_D3.*y_xd3_1;
y26 = y_D3.*y_xd3_2;
y27 = y_D3.*y_xd3_3;
y28 = y_D3.*y_xd3_4;

u_opt = zeros(len, 4);
for i=1:len
    u_opt(i,:) = file.out_u(:,1,i).';
end

%% Plot
time = 1:1:300;

figure('DefaultAxesFontSize',44); plot(time, u_opt(101:400,4),'LineWidth',4); hold on; plot(time, 80*ones(300,1),'LineWidth',4, 'color', 'black'); plot(time, 120*ones(300,1),'LineWidth',4, 'color', 'black'); xlabel('Time [s]', 'interpreter', 'latex'); ylabel('$u_{R1} [lb \cdot mol]$', 'interpreter', 'latex'); ylim([80 120]); box off; xlim([1 300])
figure('DefaultAxesFontSize',44); plot(time, u_opt(101:400,1),'LineWidth',4); hold on; plot(time, 398*ones(300,1),'LineWidth',4, 'color', 'black'); plot(time, 402*ones(300,1),'LineWidth',4, 'color', 'black'); xlabel('Time [s]', 'interpreter', 'latex'); ylabel('$u_{C1} [lb \cdot mol]$', 'interpreter', 'latex'); ylim([397 403]); box off; xlim([1 300])

%%
y_R1_C1_A_eq = [ones(1,100)*y1(100) ones(1,100)*y1(200) ones(1,100)*y1(300) ones(1,100)*y1(400)];
y_C2_R2_D_eq = [ones(1,100)*y16(100) ones(1,100)*y16(200) ones(1,100)*y16(300) ones(1,100)*y16(400)];

time = 1:1:300;
figure('DefaultAxesFontSize',62); plot(time, y1(101:400,1),'LineWidth',5); hold on; plot(time, y_R1_C1_A_eq(1,101:400), ":", 'LineWidth',4, 'color', 'black'); xlabel('Time $[s]$', 'interpreter', 'latex'); ylabel('$[lb \cdot mol / h]$', 'interpreter', 'latex'); box off; ylim([80 120]); xlim([1 300])
figure('DefaultAxesFontSize',62); plot(time, y16(101:400,1),'LineWidth',5); hold on; plot(time, y_C2_R2_D_eq(1,101:400), ":", 'LineWidth',4, 'color', 'black'); xlabel('Time $[s]$', 'interpreter', 'latex'); ylabel('$[lb \cdot mol / h]$', 'interpreter', 'latex'); box off; ylim([6 15]); xlim([1 300])
