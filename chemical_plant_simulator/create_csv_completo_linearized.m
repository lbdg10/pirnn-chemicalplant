%% Get data from linearization
y_eq = out_y_eq(99,:);

%% Load file and compute matrices
load Timed_Based_Linearization_nominal_1e50.mat
A = Timed_Based_Linearization_nominal_1e50.a;
B = Timed_Based_Linearization_nominal_1e50.b;
C = Timed_Based_Linearization_nominal_1e50.c;
D = Timed_Based_Linearization_nominal_1e50.d;
y_eq = y_eq;


%% Get data from simulation
in = 103; % CAMBIARE!!

out_u = out.out_u;
out_F0A = out.out_F0A;
out_y = out.out_y_lin;

% Input
u_R1 = out_u(in:end,1);
u_R2 = out_u(in:end,2);
u_R3 = out_u(in:end,3);
u_F0A = out_F0A(in:end,:);

% Output
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

%% Plots
figure
subplot(4,2,1); plot(u_R1, 'LineWidth', 1.1); hold on; plot(u_R2, 'LineWidth', 1.1); plot(u_R3, 'LineWidth', 1.1); plot(u_F0A, 'LineWidth', 1.1); title('Input'); legend('R1', 'R2', 'R3', 'F0A'); hold off
subplot(4,2,2); plot(y_xR1_1.*y_q_R1, 'LineWidth', 1.1); hold on; plot(y_xR1_2.*y_q_R1, 'LineWidth', 1.1); plot(y_xR1_3.*y_q_R1, 'LineWidth', 1.1); plot(y_xR1_4.*y_q_R1, 'LineWidth', 1.1); title('Stati*portata R1'); hold off
subplot(4,2,3); plot(y_xd1_1.*y_D1, 'LineWidth', 1.1); hold on; plot(y_xd1_2.*y_D1, 'LineWidth', 1.1); plot(y_xd1_3.*y_D1, 'LineWidth', 1.1); plot(y_xd1_4.*y_D1, 'LineWidth', 1.1); title('Stati*portata D1 di col 1'); hold off
subplot(4,2,4); plot(y_xb1_1.*y_B1, 'LineWidth', 1.1); hold on; plot(y_xb1_2.*y_B1, 'LineWidth', 1.1); plot(y_xb1_3.*y_B1, 'LineWidth', 1.1); plot(y_xb1_4.*y_B1, 'LineWidth', 1.1); title('Stati*portata B1 di col 1'); hold off
subplot(4,2,5); plot(y_xb2_1.*y_B2, 'LineWidth', 1.1); hold on; plot(y_xb2_2.*y_B2, 'LineWidth', 1.1); plot(y_xb2_3.*y_B2, 'LineWidth', 1.1); plot(y_xb2_4.*y_B2, 'LineWidth', 1.1); title('Stati*portata B2 di col 2'); hold off
subplot(4,2,6); plot(y_xR2_1.*y_q_R2, 'LineWidth', 1.1); hold on; plot(y_xR2_2.*y_q_R2, 'LineWidth', 1.1); plot(y_xR2_3.*y_q_R2, 'LineWidth', 1.1); plot(y_xR2_4.*y_q_R2, 'LineWidth', 1.1); title('Stati*portata R2'); hold off
subplot(4,2,7); plot(y_xR3_1.*y_q_R3, 'LineWidth', 1.1); hold on; plot(y_xR3_2.*y_q_R3, 'LineWidth', 1.1); plot(y_xR3_3.*y_q_R3, 'LineWidth', 1.1); plot(y_xR3_4.*y_q_R3, 'LineWidth', 1.1); title('Stati*portata R3'); hold off
subplot(4,2,8); plot(y_xd3_1.*y_D3, 'LineWidth', 1.1); hold on; plot(y_xd3_2.*y_D3, 'LineWidth', 1.1); plot(y_xd3_3.*y_D3, 'LineWidth', 1.1); plot(y_xd3_4.*y_D3, 'LineWidth', 1.1); title('Stati*portata D3 di col 3'); hold off

%% Save csv for training not normalized
i_train = 1;
f_train = 8000;
i_val = 8001; 
f_val = 9000; 
i_test = 9001;
f_test = 10000;

writematrix([u_R1(i_train:f_train), u_R2(i_train:f_train), u_R3(i_train:f_train), u_F0A(i_train:f_train), y_q_R1(i_train:f_train), y_xR1_1(i_train:f_train), y_xR1_2(i_train:f_train), y_xR1_3(i_train:f_train), y_xR1_4(i_train:f_train), y_D1(i_train:f_train), y_xd1_1(i_train:f_train), y_xd1_2(i_train:f_train), y_xd1_3(i_train:f_train), y_xd1_4(i_train:f_train), y_B1(i_train:f_train), y_xb1_1(i_train:f_train), y_xb1_2(i_train:f_train), y_xb1_3(i_train:f_train), y_xb1_4(i_train:f_train), y_B2(i_train:f_train), y_xb2_1(i_train:f_train), y_xb2_2(i_train:f_train), y_xb2_3(i_train:f_train), y_xb2_4(i_train:f_train), y_q_R2(i_train:f_train), y_xR2_1(i_train:f_train), y_xR2_2(i_train:f_train), y_xR2_3(i_train:f_train), y_xR2_4(i_train:f_train), y_q_R3(i_train:f_train), y_xR3_1(i_train:f_train), y_xR3_2(i_train:f_train), y_xR3_3(i_train:f_train), y_xR3_4(i_train:f_train), y_D3(i_train:f_train), y_xd3_1(i_train:f_train), y_xd3_2(i_train:f_train), y_xd3_3(i_train:f_train), y_xd3_4(i_train:f_train)], 'Train_chemicalreactor_Tsampling1s_10000_nominal_1e50.csv')
writematrix([u_R1(i_val:f_val), u_R2(i_val:f_val), u_R3(i_val:f_val), u_F0A(i_val:f_val), y_q_R1(i_val:f_val), y_xR1_1(i_val:f_val), y_xR1_2(i_val:f_val), y_xR1_3(i_val:f_val), y_xR1_4(i_val:f_val), y_D1(i_val:f_val), y_xd1_1(i_val:f_val), y_xd1_2(i_val:f_val), y_xd1_3(i_val:f_val), y_xd1_4(i_val:f_val), y_B1(i_val:f_val), y_xb1_1(i_val:f_val), y_xb1_2(i_val:f_val), y_xb1_3(i_val:f_val), y_xb1_4(i_val:f_val), y_B2(i_val:f_val), y_xb2_1(i_val:f_val), y_xb2_2(i_val:f_val), y_xb2_3(i_val:f_val), y_xb2_4(i_val:f_val), y_q_R2(i_val:f_val), y_xR2_1(i_val:f_val), y_xR2_2(i_val:f_val), y_xR2_3(i_val:f_val), y_xR2_4(i_val:f_val), y_q_R3(i_val:f_val), y_xR3_1(i_val:f_val), y_xR3_2(i_val:f_val), y_xR3_3(i_val:f_val), y_xR3_4(i_val:f_val), y_D3(i_val:f_val), y_xd3_1(i_val:f_val), y_xd3_2(i_val:f_val), y_xd3_3(i_val:f_val), y_xd3_4(i_val:f_val)], 'Val_chemicalreactor_Tsampling1s_10000_nominal_1e50.csv')
writematrix([u_R1(i_test:f_test), u_R2(i_test:f_test), u_R3(i_test:f_test), u_F0A(i_test:f_test), y_q_R1(i_test:f_test), y_xR1_1(i_test:f_test), y_xR1_2(i_test:f_test), y_xR1_3(i_test:f_test), y_xR1_4(i_test:f_test), y_D1(i_test:f_test), y_xd1_1(i_test:f_test), y_xd1_2(i_test:f_test), y_xd1_3(i_test:f_test), y_xd1_4(i_test:f_test), y_B1(i_test:f_test), y_xb1_1(i_test:f_test), y_xb1_2(i_test:f_test), y_xb1_3(i_test:f_test), y_xb1_4(i_test:f_test), y_B2(i_test:f_test), y_xb2_1(i_test:f_test), y_xb2_2(i_test:f_test), y_xb2_3(i_test:f_test), y_xb2_4(i_test:f_test), y_q_R2(i_test:f_test), y_xR2_1(i_test:f_test), y_xR2_2(i_test:f_test), y_xR2_3(i_test:f_test), y_xR2_4(i_test:f_test), y_q_R3(i_test:f_test), y_xR3_1(i_test:f_test), y_xR3_2(i_test:f_test), y_xR3_3(i_test:f_test), y_xR3_4(i_test:f_test), y_D3(i_test:f_test), y_xd3_1(i_test:f_test), y_xd3_2(i_test:f_test), y_xd3_3(i_test:f_test), y_xd3_4(i_test:f_test)], 'Test_chemicalreactor_Tsampling1s_10000_nominal_1e50.csv')

%% Get data for normalization
data1 = readtable("Train_chemicalreactor_Tsampling1s_10000_nominal_1e50.csv");
data2 = readtable("Val_chemicalreactor_Tsampling1s_10000_nominal_1e50.csv");
data3 = readtable("Test_chemicalreactor_Tsampling1s_10000_nominal_1e50.csv");

u_R1_notnorm    = [table2array(data1(1:end,"Var1")); table2array(data2(1:end,"Var1")); table2array(data3(1:end,"Var1"))];
u_R2_notnorm    = [table2array(data1(1:end,"Var2")); table2array(data2(1:end,"Var2")); table2array(data3(1:end,"Var2"))];
u_R3_notnorm    = [table2array(data1(1:end,"Var3")); table2array(data2(1:end,"Var3")); table2array(data3(1:end,"Var3"))];
u_F0A_notnorm   = [table2array(data1(1:end,"Var4")); table2array(data2(1:end,"Var4")); table2array(data3(1:end,"Var4"))];
y_q_R1_notnorm  = [table2array(data1(1:end,"Var5")); table2array(data2(1:end,"Var5")); table2array(data3(1:end,"Var5"))];
y_xR1_1_notnorm = [table2array(data1(1:end,"Var6")); table2array(data2(1:end,"Var6")); table2array(data3(1:end,"Var6"))];
y_xR1_2_notnorm = [table2array(data1(1:end,"Var7")); table2array(data2(1:end,"Var7")); table2array(data3(1:end,"Var7"))];
y_xR1_3_notnorm = [table2array(data1(1:end,"Var8")); table2array(data2(1:end,"Var8")); table2array(data3(1:end,"Var8"))];
y_xR1_4_notnorm = [table2array(data1(1:end,"Var9")); table2array(data2(1:end,"Var9")); table2array(data3(1:end,"Var9"))];
y_D1_notnorm    = [table2array(data1(1:end,"Var10")); table2array(data2(1:end,"Var10")); table2array(data3(1:end,"Var10"))];
y_xd1_1_notnorm = [table2array(data1(1:end,"Var11")); table2array(data2(1:end,"Var11")); table2array(data3(1:end,"Var11"))];
y_xd1_2_notnorm = [table2array(data1(1:end,"Var12")); table2array(data2(1:end,"Var12")); table2array(data3(1:end,"Var12"))];
y_xd1_3_notnorm = [table2array(data1(1:end,"Var13")); table2array(data2(1:end,"Var13")); table2array(data3(1:end,"Var13"))];
y_xd1_4_notnorm = [table2array(data1(1:end,"Var14")); table2array(data2(1:end,"Var14")); table2array(data3(1:end,"Var14"))];
y_B1_notnorm    = [table2array(data1(1:end,"Var15")); table2array(data2(1:end,"Var15")); table2array(data3(1:end,"Var15"))];
y_xb1_1_notnorm = [table2array(data1(1:end,"Var16")); table2array(data2(1:end,"Var16")); table2array(data3(1:end,"Var16"))];
y_xb1_2_notnorm = [table2array(data1(1:end,"Var17")); table2array(data2(1:end,"Var17")); table2array(data3(1:end,"Var17"))];
y_xb1_3_notnorm = [table2array(data1(1:end,"Var18")); table2array(data2(1:end,"Var18")); table2array(data3(1:end,"Var18"))];
y_xb1_4_notnorm = [table2array(data1(1:end,"Var19")); table2array(data2(1:end,"Var19")); table2array(data3(1:end,"Var19"))];
y_B2_notnorm    = [table2array(data1(1:end,"Var20")); table2array(data2(1:end,"Var20")); table2array(data3(1:end,"Var20"))];
y_xb2_1_notnorm = [table2array(data1(1:end,"Var21")); table2array(data2(1:end,"Var21")); table2array(data3(1:end,"Var21"))];
y_xb2_2_notnorm = [table2array(data1(1:end,"Var22")); table2array(data2(1:end,"Var22")); table2array(data3(1:end,"Var22"))];
y_xb2_3_notnorm = [table2array(data1(1:end,"Var23")); table2array(data2(1:end,"Var23")); table2array(data3(1:end,"Var23"))];
y_xb2_4_notnorm = [table2array(data1(1:end,"Var24")); table2array(data2(1:end,"Var24")); table2array(data3(1:end,"Var24"))];
y_q_R2_notnorm  = [table2array(data1(1:end,"Var25")); table2array(data2(1:end,"Var25")); table2array(data3(1:end,"Var25"))];
y_xR2_1_notnorm = [table2array(data1(1:end,"Var26")); table2array(data2(1:end,"Var26")); table2array(data3(1:end,"Var26"))];
y_xR2_2_notnorm = [table2array(data1(1:end,"Var27")); table2array(data2(1:end,"Var27")); table2array(data3(1:end,"Var27"))];
y_xR2_3_notnorm = [table2array(data1(1:end,"Var28")); table2array(data2(1:end,"Var28")); table2array(data3(1:end,"Var28"))];
y_xR2_4_notnorm = [table2array(data1(1:end,"Var29")); table2array(data2(1:end,"Var29")); table2array(data3(1:end,"Var29"))];
y_q_R3_notnorm  = [table2array(data1(1:end,"Var30")); table2array(data2(1:end,"Var30")); table2array(data3(1:end,"Var30"))];
y_xR3_1_notnorm = [table2array(data1(1:end,"Var31")); table2array(data2(1:end,"Var31")); table2array(data3(1:end,"Var31"))];
y_xR3_2_notnorm = [table2array(data1(1:end,"Var32")); table2array(data2(1:end,"Var32")); table2array(data3(1:end,"Var32"))];
y_xR3_3_notnorm = [table2array(data1(1:end,"Var33")); table2array(data2(1:end,"Var33")); table2array(data3(1:end,"Var33"))];
y_xR3_4_notnorm = [table2array(data1(1:end,"Var34")); table2array(data2(1:end,"Var34")); table2array(data3(1:end,"Var34"))];
y_D3_notnorm    = [table2array(data1(1:end,"Var35")); table2array(data2(1:end,"Var35")); table2array(data3(1:end,"Var35"))];
y_xd3_1_notnorm = [table2array(data1(1:end,"Var36")); table2array(data2(1:end,"Var36")); table2array(data3(1:end,"Var36"))];
y_xd3_2_notnorm = [table2array(data1(1:end,"Var37")); table2array(data2(1:end,"Var37")); table2array(data3(1:end,"Var37"))];
y_xd3_3_notnorm = [table2array(data1(1:end,"Var38")); table2array(data2(1:end,"Var38")); table2array(data3(1:end,"Var38"))];
y_xd3_4_notnorm = [table2array(data1(1:end,"Var39")); table2array(data2(1:end,"Var39")); table2array(data3(1:end,"Var39"))];

%% Compute the product
y1 = y_q_R1_notnorm.*y_xR1_1_notnorm;
y2 = y_q_R1_notnorm.*y_xR1_2_notnorm;
y3 = y_q_R1_notnorm.*y_xR1_3_notnorm;
y4 = y_q_R1_notnorm.*y_xR1_4_notnorm;
y5 = y_D1_notnorm.*y_xd1_1_notnorm;
y6 = y_D1_notnorm.*y_xd1_2_notnorm;
y7 = y_D1_notnorm.*y_xd1_3_notnorm;
y8 = y_D1_notnorm.*y_xd1_4_notnorm;
y9 = y_B1_notnorm.*y_xb1_1_notnorm;
y10 = y_B1_notnorm.*y_xb1_2_notnorm;
y11 = y_B1_notnorm.*y_xb1_3_notnorm;
y12 = y_B1_notnorm.*y_xb1_4_notnorm;
y13 = y_B2_notnorm.*y_xb2_1_notnorm;
y14 = y_B2_notnorm.*y_xb2_2_notnorm;
y15 = y_B2_notnorm.*y_xb2_3_notnorm;
y16 = y_B2_notnorm.*y_xb2_4_notnorm;
y17 = y_q_R2_notnorm.*y_xR2_1_notnorm;
y18 = y_q_R2_notnorm.*y_xR2_2_notnorm;
y19 = y_q_R2_notnorm.*y_xR2_3_notnorm;
y20 = y_q_R2_notnorm.*y_xR2_4_notnorm;
y21 = y_q_R3_notnorm.*y_xR3_1_notnorm;
y22 = y_q_R3_notnorm.*y_xR3_2_notnorm;
y23 = y_q_R3_notnorm.*y_xR3_3_notnorm;
y24 = y_q_R3_notnorm.*y_xR3_4_notnorm;
y25 = y_D3_notnorm.*y_xd3_1_notnorm;
y26 = y_D3_notnorm.*y_xd3_2_notnorm;
y27 = y_D3_notnorm.*y_xd3_3_notnorm;
y28 = y_D3_notnorm.*y_xd3_4_notnorm;

%% Only concentrations
y1 = y_xR1_1_notnorm;
y2 = y_xR1_2_notnorm;
y3 = y_xR1_3_notnorm;
y4 = y_xR1_4_notnorm;
y5 = y_xd1_1_notnorm;
y6 = y_xd1_2_notnorm;
y7 = y_xd1_3_notnorm;
y8 = y_xd1_4_notnorm;
y9 = y_xb1_1_notnorm;
y10 = y_xb1_2_notnorm;
y11 = y_xb1_3_notnorm;
y12 = y_xb1_4_notnorm;
y13 = y_xb2_1_notnorm;
y14 = y_xb2_2_notnorm;
y15 = y_xb2_3_notnorm;
y16 = y_xb2_4_notnorm;
y17 = y_xR2_1_notnorm;
y18 = y_xR2_2_notnorm;
y19 = y_xR2_3_notnorm;
y20 = y_xR2_4_notnorm;
y21 = y_xR3_1_notnorm;
y22 = y_xR3_2_notnorm;
y23 = y_xR3_3_notnorm;
y24 = y_xR3_4_notnorm;
y25 = y_xd3_1_notnorm;
y26 = y_xd3_2_notnorm;
y27 = y_xd3_3_notnorm;
y28 = y_xd3_4_notnorm;

%%
figure; 
subplot(4,2,1); plot(u_R1_notnorm)
subplot(4,2,2); plot(u1_norm)
subplot(4,2,3); plot(u_R2_notnorm)
subplot(4,2,4); plot(u2_norm)
subplot(4,2,5); plot(u_R3_notnorm)
subplot(4,2,6); plot(u3_norm)
subplot(4,2,7); plot(u_F0A_notnorm)
subplot(4,2,8); plot(u4_norm)

%% Normalization of the products with different amplitudes
input_scaler_bias = [mean(u_R1_notnorm), mean(u_R2_notnorm), mean(u_R3_notnorm), mean(u_F0A_notnorm)];
input_scaler_scale = [max(abs(u_R1_notnorm - input_scaler_bias(1))), max(abs(u_R2_notnorm - input_scaler_bias(2))), max(abs(u_R3_notnorm - input_scaler_bias(3))), max(abs(u_F0A_notnorm - input_scaler_bias(4)))];
u1_norm = (u_R1_notnorm - input_scaler_bias(1)) ./ input_scaler_scale(1);
u2_norm = (u_R2_notnorm - input_scaler_bias(2)) ./ input_scaler_scale(2);
u3_norm = (u_R3_notnorm - input_scaler_bias(3)) ./ input_scaler_scale(3);
u4_norm = (u_F0A_notnorm - input_scaler_bias(4)) ./ input_scaler_scale(4);

output_scaler_bias = [mean(y1), mean(y2), mean(y3), mean(y4), mean(y5), mean(y6), mean(y7), mean(y8), mean(y9), mean(y10), mean(y11), mean(y12), mean(y13), mean(y14), mean(y15), mean(y16), mean(y17), mean(y18), mean(y19), mean(y20), mean(y21), mean(y22), mean(y23), mean(y24), mean(y25), mean(y26), mean(y27), mean(y28)];
output_scaler_scale = [max(abs(y1-output_scaler_bias(1))), max(abs(y2-output_scaler_bias(2))), max(abs(y3-output_scaler_bias(3))), max(abs(y4-output_scaler_bias(4))), max(abs(y5-output_scaler_bias(5))), max(abs(y6-output_scaler_bias(6))), max(abs(y7-output_scaler_bias(7))), max(abs(y8-output_scaler_bias(8))), max(abs(y9-output_scaler_bias(9))), max(abs(y10-output_scaler_bias(10))), max(abs(y11-output_scaler_bias(11))), max(abs(y12-output_scaler_bias(12))), max(abs(y13-output_scaler_bias(13))), max(abs(y14-output_scaler_bias(14))), max(abs(y15-output_scaler_bias(15))), max(abs(y16-output_scaler_bias(16))), max(abs(y17-output_scaler_bias(17))), max(abs(y18-output_scaler_bias(18))), max(abs(y19-output_scaler_bias(19))), max(abs(y20-output_scaler_bias(20))), max(abs(y21-output_scaler_bias(21))), max(abs(y22-output_scaler_bias(22))), max(abs(y23-output_scaler_bias(23))), max(abs(y24-output_scaler_bias(24))), max(abs(y25-output_scaler_bias(25))), max(abs(y26-output_scaler_bias(26))), max(abs(y27-output_scaler_bias(27))), max(abs(y28-output_scaler_bias(28)))];
output_scaler_scale(1) = max([output_scaler_scale(1) output_scaler_scale(5) output_scaler_scale(9) output_scaler_scale(13) output_scaler_scale(17) output_scaler_scale(21)  output_scaler_scale(25)]);
output_scaler_scale(5) = output_scaler_scale(1);
output_scaler_scale(9) = output_scaler_scale(1);
output_scaler_scale(13) = output_scaler_scale(1);
output_scaler_scale(17) = output_scaler_scale(1);
output_scaler_scale(21) = output_scaler_scale(1);
output_scaler_scale(25) = output_scaler_scale(1);
output_scaler_scale(2) = max([output_scaler_scale(2) output_scaler_scale(6) output_scaler_scale(10) output_scaler_scale(14) output_scaler_scale(18) output_scaler_scale(22)  output_scaler_scale(26)]);
output_scaler_scale(6) = output_scaler_scale(2);
output_scaler_scale(10) = output_scaler_scale(2);
output_scaler_scale(14) = output_scaler_scale(2);
output_scaler_scale(18) = output_scaler_scale(2);
output_scaler_scale(22) = output_scaler_scale(2);
output_scaler_scale(26) = output_scaler_scale(2);
output_scaler_scale(3) = max([output_scaler_scale(3) output_scaler_scale(7) output_scaler_scale(11) output_scaler_scale(15) output_scaler_scale(19) output_scaler_scale(23)  output_scaler_scale(27)]);
output_scaler_scale(7) = output_scaler_scale(3);
output_scaler_scale(11) = output_scaler_scale(3);
output_scaler_scale(15) = output_scaler_scale(3);
output_scaler_scale(19) = output_scaler_scale(3);
output_scaler_scale(23) = output_scaler_scale(3);
output_scaler_scale(27) = output_scaler_scale(3);
output_scaler_scale(4) = max([output_scaler_scale(4) output_scaler_scale(8) output_scaler_scale(12) output_scaler_scale(16) output_scaler_scale(20) output_scaler_scale(24)  output_scaler_scale(28)]);
output_scaler_scale(8) = output_scaler_scale(4);
output_scaler_scale(12) = output_scaler_scale(4);
output_scaler_scale(16) = output_scaler_scale(4);
output_scaler_scale(20) = output_scaler_scale(4);
output_scaler_scale(24) = output_scaler_scale(4);
output_scaler_scale(28) = output_scaler_scale(4);
y1_norm = (y1 - output_scaler_bias(1)) ./ output_scaler_scale(1);
y2_norm = (y2 - output_scaler_bias(2)) ./ output_scaler_scale(2);
y3_norm = (y3 - output_scaler_bias(3)) ./ output_scaler_scale(3);
y4_norm = (y4 - output_scaler_bias(4)) ./ output_scaler_scale(4);
y5_norm = (y5 - output_scaler_bias(5)) ./ output_scaler_scale(5);
y6_norm = (y6 - output_scaler_bias(6)) ./ output_scaler_scale(6);
y7_norm = (y7 - output_scaler_bias(7)) ./ output_scaler_scale(7);
y8_norm = (y8 - output_scaler_bias(8)) ./ output_scaler_scale(8);
y9_norm = (y9 - output_scaler_bias(9)) ./ output_scaler_scale(9);
y10_norm = (y10 - output_scaler_bias(10)) ./ output_scaler_scale(10);
y11_norm = (y11 - output_scaler_bias(11)) ./ output_scaler_scale(11);
y12_norm = (y12 - output_scaler_bias(12)) ./ output_scaler_scale(12);
y13_norm = (y13 - output_scaler_bias(13)) ./ output_scaler_scale(13);
y14_norm = (y14 - output_scaler_bias(14)) ./ output_scaler_scale(14);
y15_norm = (y15 - output_scaler_bias(15)) ./ output_scaler_scale(15);
y16_norm = (y16 - output_scaler_bias(16)) ./ output_scaler_scale(16);
y17_norm = (y17 - output_scaler_bias(17)) ./ output_scaler_scale(17);
y18_norm = (y18 - output_scaler_bias(18)) ./ output_scaler_scale(18);
y19_norm = (y19 - output_scaler_bias(19)) ./ output_scaler_scale(19);
y20_norm = (y20 - output_scaler_bias(20)) ./ output_scaler_scale(20);
y21_norm = (y21 - output_scaler_bias(21)) ./ output_scaler_scale(21);
y22_norm = (y22 - output_scaler_bias(22)) ./ output_scaler_scale(22);
y23_norm = (y23 - output_scaler_bias(23)) ./ output_scaler_scale(23);
y24_norm = (y24 - output_scaler_bias(24)) ./ output_scaler_scale(24);
y25_norm = (y25 - output_scaler_bias(25)) ./ output_scaler_scale(25);
y26_norm = (y26 - output_scaler_bias(26)) ./ output_scaler_scale(26);
y27_norm = (y27 - output_scaler_bias(27)) ./ output_scaler_scale(27);
y28_norm = (y28 - output_scaler_bias(28)) ./ output_scaler_scale(28);


%% Normalization of the products with same amplitudes
input_scaler_bias = [mean(u_R1_notnorm), mean(u_R2_notnorm), mean(u_R3_notnorm), mean(u_F0A_notnorm)];
input_scaler_scale = [max(abs(u_R1_notnorm - input_scaler_bias(1))), max(abs(u_R2_notnorm - input_scaler_bias(2))), max(abs(u_R3_notnorm - input_scaler_bias(3))), max(abs(u_F0A_notnorm - input_scaler_bias(4)))];
input_scaler_scale_common = max(input_scaler_scale);
u1_norm = (u_R1_notnorm - input_scaler_bias(1)) ./ input_scaler_scale_common;
u2_norm = (u_R2_notnorm - input_scaler_bias(2)) ./ input_scaler_scale_common;
u3_norm = (u_R3_notnorm - input_scaler_bias(3)) ./ input_scaler_scale_common;
u4_norm = (u_F0A_notnorm - input_scaler_bias(4)) ./ input_scaler_scale_common;

output_scaler_bias = [mean(y1), mean(y2), mean(y3), mean(y4), mean(y5), mean(y6), mean(y7), mean(y8), mean(y9), mean(y10), mean(y11), mean(y12), mean(y13), mean(y14), mean(y15), mean(y16), mean(y17), mean(y18), mean(y19), mean(y20), mean(y21), mean(y22), mean(y23), mean(y24), mean(y25), mean(y26), mean(y27), mean(y28)];
output_scaler_scale = [max(abs(y1-output_scaler_bias(1))), max(abs(y2-output_scaler_bias(2))), max(abs(y3-output_scaler_bias(3))), max(abs(y4-output_scaler_bias(4))), max(abs(y5-output_scaler_bias(5))), max(abs(y6-output_scaler_bias(6))), max(abs(y7-output_scaler_bias(7))), max(abs(y8-output_scaler_bias(8))), max(abs(y9-output_scaler_bias(9))), max(abs(y10-output_scaler_bias(10))), max(abs(y11-output_scaler_bias(11))), max(abs(y12-output_scaler_bias(12))), max(abs(y13-output_scaler_bias(13))), max(abs(y14-output_scaler_bias(14))), max(abs(y15-output_scaler_bias(15))), max(abs(y16-output_scaler_bias(16))), max(abs(y17-output_scaler_bias(17))), max(abs(y18-output_scaler_bias(18))), max(abs(y19-output_scaler_bias(19))), max(abs(y20-output_scaler_bias(20))), max(abs(y21-output_scaler_bias(21))), max(abs(y22-output_scaler_bias(22))), max(abs(y23-output_scaler_bias(23))), max(abs(y24-output_scaler_bias(24))), max(abs(y25-output_scaler_bias(25))), max(abs(y26-output_scaler_bias(26))), max(abs(y27-output_scaler_bias(27))), max(abs(y28-output_scaler_bias(28)))];
output_scaler_scale_common = max(output_scaler_scale);
y1_norm = (y1 - output_scaler_bias(1)) ./ output_scaler_scale_common;
y2_norm = (y2 - output_scaler_bias(2)) ./ output_scaler_scale_common;
y3_norm = (y3 - output_scaler_bias(3)) ./ output_scaler_scale_common;
y4_norm = (y4 - output_scaler_bias(4)) ./ output_scaler_scale_common;
y5_norm = (y5 - output_scaler_bias(5)) ./ output_scaler_scale_common;
y6_norm = (y6 - output_scaler_bias(6)) ./ output_scaler_scale_common;
y7_norm = (y7 - output_scaler_bias(7)) ./ output_scaler_scale_common;
y8_norm = (y8 - output_scaler_bias(8)) ./ output_scaler_scale_common;
y9_norm = (y9 - output_scaler_bias(9)) ./ output_scaler_scale_common;
y10_norm = (y10 - output_scaler_bias(10)) ./ output_scaler_scale_common;
y11_norm = (y11 - output_scaler_bias(11)) ./ output_scaler_scale_common;
y12_norm = (y12 - output_scaler_bias(12)) ./ output_scaler_scale_common;
y13_norm = (y13 - output_scaler_bias(13)) ./ output_scaler_scale_common;
y14_norm = (y14 - output_scaler_bias(14)) ./ output_scaler_scale_common;
y15_norm = (y15 - output_scaler_bias(15)) ./ output_scaler_scale_common;
y16_norm = (y16 - output_scaler_bias(16)) ./ output_scaler_scale_common;
y17_norm = (y17 - output_scaler_bias(17)) ./ output_scaler_scale_common;
y18_norm = (y18 - output_scaler_bias(18)) ./ output_scaler_scale_common;
y19_norm = (y19 - output_scaler_bias(19)) ./ output_scaler_scale_common;
y20_norm = (y20 - output_scaler_bias(20)) ./ output_scaler_scale_common;
y21_norm = (y21 - output_scaler_bias(21)) ./ output_scaler_scale_common;
y22_norm = (y22 - output_scaler_bias(22)) ./ output_scaler_scale_common;
y23_norm = (y23 - output_scaler_bias(23)) ./ output_scaler_scale_common;
y24_norm = (y24 - output_scaler_bias(24)) ./ output_scaler_scale_common;
y25_norm = (y25 - output_scaler_bias(25)) ./ output_scaler_scale_common;
y26_norm = (y26 - output_scaler_bias(26)) ./ output_scaler_scale_common;
y27_norm = (y27 - output_scaler_bias(27)) ./ output_scaler_scale_common;
y28_norm = (y28 - output_scaler_bias(28)) ./ output_scaler_scale_common;

%% Plots
figure; title('Pre vs post normalizzazione');
subplot(4,2,1); plot(y9); hold on; plot(y17); plot(y25); legend('NN1', 'NN2', 'NN3')
subplot(4,2,3); plot(y10); hold on; plot(y18); plot(y26); legend('NN1', 'NN2', 'NN3')
subplot(4,2,5); plot(y11); hold on; plot(y19); plot(y27); legend('NN1', 'NN2', 'NN3')
subplot(4,2,7); plot(y12); hold on; plot(y20); plot(y28); legend('NN1', 'NN2', 'NN3')
subplot(4,2,2); plot(y9_norm); hold on; plot(y17_norm); plot(y25_norm); legend('NN1', 'NN2', 'NN3')
subplot(4,2,4); plot(y10_norm); hold on; plot(y18_norm); plot(y26_norm); legend('NN1', 'NN2', 'NN3')
subplot(4,2,6); plot(y11_norm); hold on; plot(y19_norm); plot(y27_norm); legend('NN1', 'NN2', 'NN3')
subplot(4,2,8); plot(y12_norm); hold on; plot(y20_norm); plot(y28_norm); legend('NN1', 'NN2', 'NN3')

%% Save csv for training normalized
i_train = 1;
f_train = 8000;
i_val = 8001; 
f_val = 9000; 
i_test = 9001;
f_test = 10000;

writematrix([u1_norm(i_train:f_train), u2_norm(i_train:f_train), u3_norm(i_train:f_train), u4_norm(i_train:f_train), y1_norm(i_train:f_train), y2_norm(i_train:f_train), y3_norm(i_train:f_train), y4_norm(i_train:f_train), y5_norm(i_train:f_train), y6_norm(i_train:f_train), y7_norm(i_train:f_train), y8_norm(i_train:f_train), y9_norm(i_train:f_train), y10_norm(i_train:f_train), y11_norm(i_train:f_train), y12_norm(i_train:f_train), y13_norm(i_train:f_train), y14_norm(i_train:f_train), y15_norm(i_train:f_train), y16_norm(i_train:f_train), y17_norm(i_train:f_train), y18_norm(i_train:f_train), y19_norm(i_train:f_train), y20_norm(i_train:f_train), y21_norm(i_train:f_train), y22_norm(i_train:f_train), y23_norm(i_train:f_train), y24_norm(i_train:f_train), y25_norm(i_train:f_train), y26_norm(i_train:f_train), y27_norm(i_train:f_train), y28_norm(i_train:f_train)], 'Train_chemicalreactor_Tsampling1s_10000samples_normalized_linnominal_1e50_conc.csv')
writematrix([u1_norm(i_val:f_val), u2_norm(i_val:f_val), u3_norm(i_val:f_val), u4_norm(i_val:f_val), y1_norm(i_val:f_val), y2_norm(i_val:f_val), y3_norm(i_val:f_val), y4_norm(i_val:f_val), y5_norm(i_val:f_val), y6_norm(i_val:f_val), y7_norm(i_val:f_val), y8_norm(i_val:f_val), y9_norm(i_val:f_val), y10_norm(i_val:f_val), y11_norm(i_val:f_val), y12_norm(i_val:f_val), y13_norm(i_val:f_val), y14_norm(i_val:f_val), y15_norm(i_val:f_val), y16_norm(i_val:f_val), y17_norm(i_val:f_val), y18_norm(i_val:f_val), y19_norm(i_val:f_val), y20_norm(i_val:f_val), y21_norm(i_val:f_val), y22_norm(i_val:f_val), y23_norm(i_val:f_val), y24_norm(i_val:f_val), y25_norm(i_val:f_val), y26_norm(i_val:f_val), y27_norm(i_val:f_val), y28_norm(i_val:f_val)], 'Val_chemicalreactor_Tsampling1s_10000samples_normalized_linnominal_1e50_conc.csv')
writematrix([u1_norm(i_test:f_test), u2_norm(i_test:f_test), u3_norm(i_test:f_test), u4_norm(i_test:f_test), y1_norm(i_test:f_test), y2_norm(i_test:f_test), y3_norm(i_test:f_test), y4_norm(i_test:f_test), y5_norm(i_test:f_test), y6_norm(i_test:f_test), y7_norm(i_test:f_test), y8_norm(i_test:f_test), y9_norm(i_test:f_test), y10_norm(i_test:f_test), y11_norm(i_test:f_test), y12_norm(i_test:f_test), y13_norm(i_test:f_test), y14_norm(i_test:f_test), y15_norm(i_test:f_test), y16_norm(i_test:f_test), y17_norm(i_test:f_test), y18_norm(i_test:f_test), y19_norm(i_test:f_test), y20_norm(i_test:f_test), y21_norm(i_test:f_test), y22_norm(i_test:f_test), y23_norm(i_test:f_test), y24_norm(i_test:f_test), y25_norm(i_test:f_test), y26_norm(i_test:f_test), y27_norm(i_test:f_test), y28_norm(i_test:f_test)], 'Test_chemicalreactor_Tsampling1s_10000samples_normalized_linnominal_1e50_conc.csv')
