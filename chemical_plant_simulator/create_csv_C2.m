%% Get data from simulation
in = 30;
y_B2 = out_y(in:end,1);
y_xb2_1 = out_y(in:end,2);
y_xb2_2 = out_y(in:end,3);
y_xb2_3 = out_y(in:end,4);
y_xb2_4 = out_y(in:end,5);
y_real1 = y_B2.*y_xb2_1;
y_real2 = y_B2.*y_xb2_2;
y_real3 = y_B2.*y_xb2_3;
y_real4 = y_B2.*y_xb2_4;

y_mod1 = zeros(size(y_B2,1),1);
y_mod2 = zeros(size(y_B2,1),1);
y_mod3 = zeros(size(y_B2,1),1);
y_mod4 = zeros(size(y_B2,1),1);
for i = 1:size(y_B2,1)
    y_mod1(i,1) = y_mod(1,1,i+in-1);
    y_mod2(i,1) = y_mod(2,1,i+in-1);
    y_mod3(i,1) = y_mod(3,1,i+in-1);
    y_mod4(i,1) = y_mod(4,1,i+in-1);
end

figure; plot(y_real1); hold on; plot(y_mod1)
figure; plot(y_real2); hold on; plot(y_mod2)
figure; plot(y_real3); hold on; plot(y_mod3)
figure; plot(y_real4); hold on; plot(y_mod4)

%% FIT
y_id = [y_mod1.'; y_mod2.'; y_mod3.'; y_mod4.'];
y_real = [y_real1.'; y_real2.'; y_real3.'; y_real4.'];
num = zeros(1,size(y_id,2));
den = zeros(1,size(y_id,2));
for i = 1:size(y_id,2)
    num(1,i) = norm(y_id(:,i)-y_real(:,i), 2) ;
    den(1,i) = norm(y_real(:,i)-mean(y_real(:,i)), 2);
end

FIT_avg = 100 * (1-(sum(num)/sum(den)))

%% Save csv for training not normalized
i_train = 1;
f_train = 8000;
i_val = 8001; 
f_val = 8950; 
i_test = 8951;
f_test = 9900;

writematrix([y_D3(i_train:f_train), y_xd3_1(i_train:f_train), y_xd3_2(i_train:f_train), y_xd3_3(i_train:f_train), y_xd3_4(i_train:f_train)], 'Train_chemicalreactor_C3.csv')
writematrix([y_D3(i_val:f_val), y_xd3_1(i_val:f_val), y_xd3_2(i_val:f_val), y_xd3_3(i_val:f_val), y_xd3_4(i_val:f_val)], 'Val_chemicalreactor_C3.csv')
writematrix([y_D3(i_test:f_test), y_xd3_1(i_test:f_test), y_xd3_2(i_test:f_test), y_xd3_3(i_test:f_test), y_xd3_4(i_test:f_test)], 'Test_chemicalreactor_C3.csv')

%% Get data for normalization
data1 = readtable("Train_chemicalreactor_Tsampling1s_10000_varinput20perc.csv");
data2 = readtable("Val_chemicalreactor_Tsampling1s_10000_varinput20perc.csv");
data3 = readtable("Test_chemicalreactor_Tsampling1s_10000_varinput20perc.csv");
u_R2_notnorm    = [table2array(data1(1:end,"Var2")); table2array(data2(1:end,"Var2")); table2array(data3(1:end,"Var2"))];
u_R3_notnorm    = [table2array(data1(1:end,"Var3")); table2array(data2(1:end,"Var3")); table2array(data3(1:end,"Var3"))];
u_F0A_notnorm   = [table2array(data1(1:end,"Var4")); table2array(data2(1:end,"Var4")); table2array(data3(1:end,"Var4"))];
y_q_R3_notnorm  = [table2array(data1(1:end,"Var30")); table2array(data2(1:end,"Var30")); table2array(data3(1:end,"Var30"))];
y_xR3_1_notnorm = [table2array(data1(1:end,"Var31")); table2array(data2(1:end,"Var31")); table2array(data3(1:end,"Var31"))];
y_xR3_2_notnorm = [table2array(data1(1:end,"Var32")); table2array(data2(1:end,"Var32")); table2array(data3(1:end,"Var32"))];
y_xR3_3_notnorm = [table2array(data1(1:end,"Var33")); table2array(data2(1:end,"Var33")); table2array(data3(1:end,"Var33"))];
y_xR3_4_notnorm = [table2array(data1(1:end,"Var34")); table2array(data2(1:end,"Var34")); table2array(data3(1:end,"Var34"))];

data1 = readtable("Train_chemicalreactor_C3.csv");
data2 = readtable("Val_chemicalreactor_C3.csv");
data3 = readtable("Test_chemicalreactor_C3.csv");
y_D3_notnorm    = [table2array(data1(1:end,"Var1")); table2array(data2(1:end,"Var1")); table2array(data3(1:end,"Var1"))];
y_xd3_1_notnorm = [table2array(data1(1:end,"Var2")); table2array(data2(1:end,"Var2")); table2array(data3(1:end,"Var2"))];
y_xd3_2_notnorm = [table2array(data1(1:end,"Var3")); table2array(data2(1:end,"Var3")); table2array(data3(1:end,"Var3"))];
y_xd3_3_notnorm = [table2array(data1(1:end,"Var4")); table2array(data2(1:end,"Var4")); table2array(data3(1:end,"Var4"))];
y_xd3_4_notnorm = [table2array(data1(1:end,"Var5")); table2array(data2(1:end,"Var5")); table2array(data3(1:end,"Var5"))];


%% Compute the product
y21 = y_q_R3_notnorm.*y_xR3_1_notnorm;
y22 = y_q_R3_notnorm.*y_xR3_2_notnorm;
y23 = y_q_R3_notnorm.*y_xR3_3_notnorm;
y24 = y_q_R3_notnorm.*y_xR3_4_notnorm;
y25 = y_D3_notnorm.*y_xd3_1_notnorm;
y26 = y_D3_notnorm.*y_xd3_2_notnorm;
y27 = y_D3_notnorm.*y_xd3_3_notnorm;
y28 = y_D3_notnorm.*y_xd3_4_notnorm;

%% Normalization with same amplitudes
input_scaler_bias = load("input_scaler_bias.mat");
input_scaler_scale_common = load("input_scaler_scale_common.mat");
output_scaler_bias = load("output_scaler_bias.mat");
output_scaler_scale_common = load("output_scaler_scale_common.mat");

u2_norm = (u_R2_notnorm - input_scaler_bias.input_scaler_bias(2)) ./ input_scaler_scale_common.input_scaler_scale_common;
u3_norm = (u_R3_notnorm - input_scaler_bias.input_scaler_bias(3)) ./ input_scaler_scale_common.input_scaler_scale_common;
u4_norm = (u_F0A_notnorm - input_scaler_bias.input_scaler_bias(4)) ./ input_scaler_scale_common.input_scaler_scale_common;

y21_norm = (y21 - output_scaler_bias.output_scaler_bias(21)) ./ output_scaler_scale_common.output_scaler_scale_common;
y22_norm = (y22 - output_scaler_bias.output_scaler_bias(22)) ./ output_scaler_scale_common.output_scaler_scale_common;
y23_norm = (y23 - output_scaler_bias.output_scaler_bias(23)) ./ output_scaler_scale_common.output_scaler_scale_common;
y24_norm = (y24 - output_scaler_bias.output_scaler_bias(24)) ./ output_scaler_scale_common.output_scaler_scale_common;
y25_norm = (y25 - output_scaler_bias.output_scaler_bias(25)) ./ output_scaler_scale_common.output_scaler_scale_common;
y26_norm = (y26 - output_scaler_bias.output_scaler_bias(26)) ./ output_scaler_scale_common.output_scaler_scale_common;
y27_norm = (y27 - output_scaler_bias.output_scaler_bias(27)) ./ output_scaler_scale_common.output_scaler_scale_common;
y28_norm = (y28 - output_scaler_bias.output_scaler_bias(28)) ./ output_scaler_scale_common.output_scaler_scale_common;

%% Save csv for training normalized
i_train = 1;
f_train = 8000;
i_val = 8001; 
f_val = 8950; 
i_test = 8951;
f_test = 9900;

writematrix([u2_norm(i_train:f_train), u3_norm(i_train:f_train), u4_norm(i_train:f_train), y21_norm(i_train:f_train), y22_norm(i_train:f_train), y23_norm(i_train:f_train), y24_norm(i_train:f_train), y25_norm(i_train:f_train), y26_norm(i_train:f_train), y27_norm(i_train:f_train), y28_norm(i_train:f_train)], 'Train_chemicalreactor_C3_norm_prod.csv')
writematrix([u2_norm(i_val:f_val), u3_norm(i_val:f_val), u4_norm(i_val:f_val), y21_norm(i_val:f_val), y22_norm(i_val:f_val), y23_norm(i_val:f_val), y24_norm(i_val:f_val), y25_norm(i_val:f_val), y26_norm(i_val:f_val), y27_norm(i_val:f_val), y28_norm(i_val:f_val)], 'Val_chemicalreactor_C3_norm_prod.csv')
writematrix([u2_norm(i_test:f_test), u3_norm(i_test:f_test), u4_norm(i_test:f_test), y21_norm(i_test:f_test), y22_norm(i_test:f_test), y23_norm(i_test:f_test), y24_norm(i_test:f_test), y25_norm(i_test:f_test), y26_norm(i_test:f_test), y27_norm(i_test:f_test), y28_norm(i_test:f_test)], 'Test_chemicalreactor_C3_norm_prod.csv')
