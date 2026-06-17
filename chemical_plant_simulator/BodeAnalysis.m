%%%%%%% Bode Gain Analysis
load Plant_completo_orig_mod_Timed_Based_Linearization_ss.mat
A = Plant_completo_orig_mod_Timed_Based_Linearization_nominal.a;
B = Plant_completo_orig_mod_Timed_Based_Linearization_nominal.b;
C = Plant_completo_orig_mod_Timed_Based_Linearization_nominal.c;
D = Plant_completo_orig_mod_Timed_Based_Linearization_nominal.d;
y_eq = y_eq;

%% R1 = 330, F0A = 100
load TimeBasedLinearization_R1_330_xd1in.mat
A_1 = Plant_completo_orig_mod_Timed_Based_Linearization_R1_330_xd1in.a;
B_1 = Plant_completo_orig_mod_Timed_Based_Linearization_R1_330_xd1in.b;
C_1 = Plant_completo_orig_mod_Timed_Based_Linearization_R1_330_xd1in.c;
D_1 = Plant_completo_orig_mod_Timed_Based_Linearization_R1_330_xd1in.d;
s1 = ss(A_1,B_1,C_1,D_1);
Gtf_1 = tf(s1);

%% R1 = 380, F0A = 150

load TimeBasedLinearization_R1piu70.mat
A_2 = Plant_completo_orig_mod_Timed_Based_Linearization_R1piu70.a;
B_2 = Plant_completo_orig_mod_Timed_Based_Linearization_R1piu70.b;
C_2 = Plant_completo_orig_mod_Timed_Based_Linearization_R1piu70.c;
D_2 = Plant_completo_orig_mod_Timed_Based_Linearization_R1piu70.d;
s2 = ss(A_2,B_2,C_2,D_2);
Gtf_2 = tf(s2);

%% R1 = 260
load TimeBasedLinearization_R1men70.mat
A_3 = Plant_completo_orig_mod_Timed_Based_Linearization_R1men70.a;
B_3 = Plant_completo_orig_mod_Timed_Based_Linearization_R1men70.b;
C_3 = Plant_completo_orig_mod_Timed_Based_Linearization_R1men70.c;
D_3 = Plant_completo_orig_mod_Timed_Based_Linearization_R1men70.d;
s3 = ss(A_3,B_3,C_3,D_3);
Gtf_3 = tf(s3);


%% STATIC GAIN


Gtf_1_static = dcgain(s1);
Gtf_2_static = dcgain(s2);
Gtf_3_static = dcgain(s3);

display(['Gains from xd1 to xf1 - R1/F1 = 260/50:   ', num2str(Gtf_3_static(1,5)),';  ', num2str(Gtf_3_static(2,5)),';  ',num2str(Gtf_3_static(3,5)),';  ',num2str(Gtf_3_static(4,5))])
display(['Gains from xd1 to xf1 - R1/F1 = 330/100:   ', num2str(Gtf_1_static(1,5)),';  ', num2str(Gtf_1_static(2,5)),';  ',num2str(Gtf_1_static(3,5)),';  ',num2str(Gtf_1_static(4,5))])
display(['Gains from xd1 to xf1 - R1/F1 = 400/150:   ', num2str(Gtf_2_static(1,5)),';  ', num2str(Gtf_2_static(2,5)),';  ',num2str(Gtf_2_static(3,5)),';  ',num2str(Gtf_2_static(4,5))])


display(['Gains from R1 to xf1 - R1/F1 = 260/50:   ', num2str(Gtf_3_static(1,2)),';  ', num2str(Gtf_3_static(2,2)),';  ',num2str(Gtf_3_static(3,2)),';  ',num2str(Gtf_3_static(4,2))])
display(['Gains from R1 to xf1 - R1/F1 = 330/100:   ', num2str(Gtf_1_static(1,2)),';  ', num2str(Gtf_1_static(2,2)),';  ',num2str(Gtf_1_static(3,2)),';  ',num2str(Gtf_1_static(4,2))])
display(['Gains from R1 to xf1 - R1/F1 = 400/150:   ', num2str(Gtf_2_static(1,2)),';  ', num2str(Gtf_2_static(2,2)),';  ',num2str(Gtf_2_static(3,2)),';  ',num2str(Gtf_2_static(4,2))])


display(['Gains from F1 to xf1 - R1/F1 = 260/50:   ', num2str(Gtf_3_static(1,1)),';  ', num2str(Gtf_3_static(2,1)),';  ',num2str(Gtf_3_static(3,1)),';  ',num2str(Gtf_3_static(4,1))])
display(['Gains from F1 to xf1 - R1/F1 = 330/100:   ', num2str(Gtf_1_static(1,1)),';  ', num2str(Gtf_1_static(2,1)),';  ',num2str(Gtf_1_static(3,1)),';  ',num2str(Gtf_1_static(4,1))])
display(['Gains from F1 to xf1 - R1/F1 = 400/150:   ', num2str(Gtf_2_static(1,1)),';  ', num2str(Gtf_2_static(2,1)),';  ',num2str(Gtf_2_static(3,1)),';  ',num2str(Gtf_2_static(4,1))])

%% Plot

%%%%% da R1 a xf1
figure
subplot 221
bodemag(Gtf_1(1,2))
hold on
bodemag(Gtf_2(1,2))
hold on
bodemag(Gtf_3(1,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xf11')
subplot 222
bodemag(Gtf_1(2,2))
hold on
bodemag(Gtf_2(2,2))
hold on
bodemag(Gtf_3(2,2))
title('Da R1 a xf12')
legend('R1 330', 'R1 400','R1 260')
subplot 223
bodemag(Gtf_1(3,2))
hold on
bodemag(Gtf_2(3,2))
hold on
bodemag(Gtf_3(3,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xf21')
subplot 224
bodemag(Gtf_1(4,2))
hold on
bodemag(Gtf_2(4,2))
hold on
bodemag(Gtf_3(4,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xf22')


%%%%% da R1 a xd1
figure
subplot 221
bodemag(Gtf_1(5,2))
hold on
bodemag(Gtf_2(5,2))
hold on
bodemag(Gtf_3(5,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xd11')
subplot 222
bodemag(Gtf_1(6,2))
hold on
bodemag(Gtf_2(6,2))
hold on
bodemag(Gtf_3(6,2))
title('Da R1 a xd12')
legend('R1 330', 'R1 400','R1 260')
subplot 223
bodemag(Gtf_1(7,2))
hold on
bodemag(Gtf_2(7,2))
hold on
bodemag(Gtf_3(7,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xd21')
subplot 224
bodemag(Gtf_1(8,2))
hold on
bodemag(Gtf_2(8,2))
hold on
bodemag(Gtf_3(8,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xd22')

%% da xd1 a xf1
figure
subplot 221
bodemag(Gtf_1(1,5))
hold on
bodemag(Gtf_2(1,5))
hold on
bodemag(Gtf_3(1,5))
legend('R1 330', 'R1 400','R1 260')
title('Da xd1 a xf11')
subplot 222
bodemag(Gtf_1(2,5))
hold on
bodemag(Gtf_2(2,5))
hold on
bodemag(Gtf_3(2,5))
title('Da xd1 a xf12')
legend('R1 330', 'R1 400','R1 260')
subplot 223
bodemag(Gtf_1(3,5))
hold on
bodemag(Gtf_2(3,5))
hold on
bodemag(Gtf_3(3,5))
legend('R1 330', 'R1 400','R1 260')
title('Da xd1 a xf21')
subplot 224
bodemag(Gtf_1(4,5))
hold on
bodemag(Gtf_2(4,5))
hold on
bodemag(Gtf_3(4,5))
legend('R1 330', 'R1 400','R1 260')
title('Da xd1 a xf22')

%% da xd1 a xb1
figure
subplot 221
bodemag(Gtf_1(9,5))
hold on
bodemag(Gtf_2(9,5))
hold on
bodemag(Gtf_3(9,5))
legend('R1 330', 'R1 400','R1 260')
title('Da xd1 a xf11')
subplot 222
bodemag(Gtf_1(10,5))
hold on
bodemag(Gtf_2(10,5))
hold on
bodemag(Gtf_3(10,5))
title('Da xd1 a xf12')
legend('R1 330', 'R1 400','R1 260')
subplot 223
bodemag(Gtf_1(11,5))
hold on
bodemag(Gtf_2(11,5))
hold on
bodemag(Gtf_3(11,5))
legend('R1 330', 'R1 400','R1 260')
title('Da xd1 a xf21')
subplot 224
bodemag(Gtf_1(12,5))
hold on
bodemag(Gtf_2(12,5))
hold on
bodemag(Gtf_3(12,5))
legend('R1 330', 'R1 400','R1 260')
title('Da xd1 a xf22')


%% F1 = 150
load Timed_Based_Linearization_F0A_150.mat
A_11 = Plant_completo_orig_mod_Timed_Based_Linearization_F0A_150.a;
B_11 = Plant_completo_orig_mod_Timed_Based_Linearization_F0A_150.b;
C_11 = Plant_completo_orig_mod_Timed_Based_Linearization_F0A_150.c;
D_11 = Plant_completo_orig_mod_Timed_Based_Linearization_F0A_150.d;
s11 = ss(A_11,B_11,C_11,D_11);
Gtf_11 = tf(s11);



Gtf_11_static = dcgain(s11);

display(['Gains from xd1 to xf1 - R1 = 260:   ', num2str(Gtf_3_static(1,5)),';  ', num2str(Gtf_3_static(2,5)),';  ',num2str(Gtf_3_static(3,5)),';  ',num2str(Gtf_3_static(4,5))])
display(['Gains from xd1 to xf1 - R1 = 330:   ', num2str(Gtf_1_static(1,5)),';  ', num2str(Gtf_1_static(2,5)),';  ',num2str(Gtf_1_static(3,5)),';  ',num2str(Gtf_1_static(4,5))])
display(['Gains from xd1 to xf1 - R1 = 400:   ', num2str(Gtf_2_static(1,5)),';  ', num2str(Gtf_2_static(2,5)),';  ',num2str(Gtf_2_static(3,5)),';  ',num2str(Gtf_2_static(4,5))])


display(['Gains from R1 to xf1 - R1 = 260:   ', num2str(Gtf_3_static(1,2)),';  ', num2str(Gtf_3_static(2,2)),';  ',num2str(Gtf_3_static(3,2)),';  ',num2str(Gtf_3_static(4,2))])
display(['Gains from R1 to xf1 - R1 = 330:   ', num2str(Gtf_1_static(1,2)),';  ', num2str(Gtf_1_static(2,2)),';  ',num2str(Gtf_1_static(3,2)),';  ',num2str(Gtf_1_static(4,2))])
display(['Gains from R1 to xf1 - R1 = 400:   ', num2str(Gtf_2_static(1,2)),';  ', num2str(Gtf_2_static(2,2)),';  ',num2str(Gtf_2_static(3,2)),';  ',num2str(Gtf_2_static(4,2))])


display(['Gains from F1 to xf1 - R1 = 260:   ', num2str(Gtf_3_static(1,1)),';  ', num2str(Gtf_3_static(2,1)),';  ',num2str(Gtf_3_static(3,1)),';  ',num2str(Gtf_3_static(4,1))])
display(['Gains from F1 to xf1 - R1 = 330:   ', num2str(Gtf_1_static(1,1)),';  ', num2str(Gtf_1_static(2,1)),';  ',num2str(Gtf_1_static(3,1)),';  ',num2str(Gtf_1_static(4,1))])
display(['Gains from F1 to xf1 - R1 = 400:   ', num2str(Gtf_2_static(1,1)),';  ', num2str(Gtf_2_static(2,1)),';  ',num2str(Gtf_2_static(3,1)),';  ',num2str(Gtf_2_static(4,1))])

%% F1 = 50
load TimeBasedLinearization_F1_50.mat
A_2 = Plant_completo_orig_mod_TimeBasedLinearization_F1_50.a;
B_2 = Plant_completo_orig_mod_TimeBasedLinearization_F1_50.b;
C_2 = Plant_completo_orig_mod_TimeBasedLinearization_F1_50.c;
D_2 = Plant_completo_orig_mod_TimeBasedLinearization_F1_50.d;
s2 = ss(A_2,B_2,C_2,D_2);
Gtf_2 = tf(s2);


%% Plot

%%%%% da F0A a xf1
figure
subplot 221
bodemag(Gtf_1(1,1))
hold on
bodemag(Gtf_2(1,1))
hold on
bodemag(Gtf_3(1,1))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xf11')
subplot 222
bodemag(Gtf_1(2,1))
hold on
bodemag(Gtf_2(2,1))
hold on
bodemag(Gtf_3(2,1))
title('Da R1 a xf12')
legend('R1 330', 'R1 400','R1 260')
subplot 223
bodemag(Gtf_1(3,1))
hold on
bodemag(Gtf_2(3,1))
hold on
bodemag(Gtf_3(3,1))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xf21')
subplot 224
bodemag(Gtf_1(4,1))
hold on
bodemag(Gtf_2(4,1))
hold on
bodemag(Gtf_3(4,1))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xf22')


%%%%% da R1 a xd1
figure
subplot 221
bodemag(Gtf_1(5,2))
hold on
bodemag(Gtf_2(5,2))
hold on
bodemag(Gtf_3(5,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xd11')
subplot 222
bodemag(Gtf_1(6,2))
hold on
bodemag(Gtf_2(6,2))
hold on
bodemag(Gtf_3(6,2))
title('Da R1 a xd12')
legend('R1 330', 'R1 400','R1 260')
subplot 223
bodemag(Gtf_1(7,2))
hold on
bodemag(Gtf_2(7,2))
hold on
bodemag(Gtf_3(7,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xd21')
subplot 224
bodemag(Gtf_1(8,2))
hold on
bodemag(Gtf_2(8,2))
hold on
bodemag(Gtf_3(8,2))
legend('R1 330', 'R1 400','R1 260')
title('Da R1 a xd22')