%% Initialization
yk2_0 = 0.5*ones(4,1);
yk6_0 = 0.5*ones(4,1);
xk0_obs = 0.5*ones(states_tot, 1);
xk0_mod = 0.5*ones(states_tot, 1);

len = 400;
F0A_inp = zeros(len,2);
for i = 1:len
    F0A_inp(i,1) = i;
end
for i = 1:100
        F0A_inp(i,2) = 100;
end
for i = 101:200
        F0A_inp(i,2) = 110;
end
for i = 201:300
        F0A_inp(i,2) = 90;
end
for i = 301:400
        F0A_inp(i,2) = 105;
end

R1_inp = zeros(len,2);
for i = 1:len
    R1_inp(i,1) = i;
end
for i = 1:100
        R1_inp(i,2) = 400;
end
for i = 101:200
        R1_inp(i,2) = 402;
end
for i = 201:300
        R1_inp(i,2) = 399;
end
for i = 301:400
        R1_inp(i,2) = 401;
end

R2_inp = zeros(len,2);
for i = 1:len
    R2_inp(i,1) = i;
end
for i = 1:100
        R2_inp(i,2) = 375;
end
for i = 101:200
        R2_inp(i,2) = 377;
end
for i = 201:300
        R2_inp(i,2) = 374;
end
for i = 301:400
        R2_inp(i,2) = 376;
end

R3_inp = zeros(len,2);
for i = 1:len
    R3_inp(i,1) = i;
end
for i = 1:100
        R3_inp(i,2) = 272;
end
for i = 101:200
        R3_inp(i,2) = 274;
end
for i = 201:300
        R3_inp(i,2) = 271;
end
for i = 301:400
        R3_inp(i,2) = 273;
end
%%
% Output
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

%%
R1_eq = [ones(1,100)*400 ones(1,100)*402 ones(1,100)*399 ones(1,100)*401];
R2_eq = [ones(1,100)*375 ones(1,100)*377 ones(1,100)*374 ones(1,100)*376];
R3_eq = [ones(1,100)*272 ones(1,100)*274 ones(1,100)*271 ones(1,100)*273];
F0A_eq = [ones(1,100)*100 ones(1,100)*110 ones(1,100)*90 ones(1,100)*105];
x_eq = zeros(18,len);

for i = 1:18
    x_eq(i,:) = [ones(1,100)*x_mod(i,1,100) ones(1,100)*x_mod(i,1,200) ones(1,100)*x_mod(i,1,300) ones(1,100)*x_mod(i,1,400)];
end
y_R1_C1_A_eq = [ones(1,100)*y1(100) ones(1,100)*y1(200) ones(1,100)*y1(300) ones(1,100)*y1(400)];
y_C2_R2_D_eq = [ones(1,100)*y16(100) ones(1,100)*y16(200) ones(1,100)*y16(300) ones(1,100)*y16(400)];
