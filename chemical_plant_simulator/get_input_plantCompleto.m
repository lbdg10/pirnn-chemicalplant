%%
% Delta_feedback = 1;
% Delta_feedforward = 50;

Delta_feedback = 0.2*D1;
Delta_feedforward = 0.2*F0A;

%% R1 equilibrio 410 INTORNO A EQUILIBRIO DI V1
R1_eq = R1;
total_time = 13000; % simulation time
freq_range = [0 3e-2]; % frequency range 
ampl_range = [0.99999, 1.00001]; % amplitude range (multiplied by a and b)
a = R1_eq-Delta_feedback; % lower amplitude limit
b = R1_eq+Delta_feedback; % upper amplitude limit
rng(1);
% Generate input signal of type prbs
R1_inp = idinput(total_time, 'prbs', freq_range, ampl_range);
d = diff(R1_inp); % difference: [u(2)-u(1)  u(3)-u(2)...]
idx = find(d) + 1; % returns the linear indices corresponding to the nonzero entries of the array d
idx = [1; idx];
for j = 1 : (length(idx)-1)
     amp = (b - a).*rand + a; % rand: uniformly distributed pseudorandom numbers
     R1_inp(idx(j):idx(j+1)-1) = amp * R1_inp(idx(j));
end
%R1_inp = awgn(u_T, 70, 'measured'); % add random WGN: the value is the signal-to-noise ratio in dB, specified as a scalar
% Create an iddata object from the generated signal u
R1_inp = iddata([],R1_inp(1:12000),1); % al posto di 1 metto 60 se voglio Ts=60, ma tanto poi su Simulink devo rimettere Ts a 60
for i=2001:8000
    R1_inp(i,:,:) = iddata([],R1_eq,1);
end

%% R2 equilibrio 283
R2_eq = R2;
total_time = 13000; % simulation time
freq_range = [0 3e-2]; % frequency range 
ampl_range = [0.99999, 1.00001]; % amplitude range (multiplied by a and b)
a = R2_eq-Delta_feedback; % lower amplitude limit
b = R2_eq+Delta_feedback; % upper amplitude limit
rng(1);
% Generate input signal of type prbs
R2_inp = idinput(total_time, 'prbs', freq_range, ampl_range);
d = diff(R2_inp); % difference: [u(2)-u(1)  u(3)-u(2)...]
idx = find(d) + 1; % returns the linear indices corresponding to the nonzero entries of the array d
idx = [1; idx];
for j = 1 : (length(idx)-1)
     amp = (b - a).*rand + a; % rand: uniformly distributed pseudorandom numbers
     R2_inp(idx(j):idx(j+1)-1) = amp * R2_inp(idx(j));
end
%R2_inp = awgn(u_T, 70, 'measured'); % add random WGN: the value is the signal-to-noise ratio in dB, specified as a scalar
% Create an iddata object from the generated signal u
R2_inp = iddata([],R2_inp(1:12000),1); % al posto di 1 metto 60 se voglio Ts=60, ma tanto poi su Simulink devo rimettere Ts a 60
for i=1:2000
    R2_inp(i,:,:) = iddata([],R2_eq,1);
end
for i=4001:8000
    R2_inp(i,:,:) = iddata([],R2_eq,1);
end


%% R3 
R3_eq = R3;
total_time = 13000; % simulation time
freq_range = [0 3e-2]; % frequency range 
ampl_range = [0.99999, 1.00001]; % amplitude range (multiplied by a and b)
a = R3_eq-Delta_feedback; % lower amplitude limit
b = R3_eq+Delta_feedback; % upper amplitude limit
rng(1);
% Generate input signal of type prbs
R3_inp = idinput(total_time, 'prbs', freq_range, ampl_range);
d = diff(R3_inp); % difference: [u(2)-u(1)  u(3)-u(2)...]
idx = find(d) + 1; % returns the linear indices corresponding to the nonzero entries of the array d
idx = [1; idx];
for j = 1 : (length(idx)-1)
     amp = (b - a).*rand + a; % rand: uniformly distributed pseudorandom numbers
     R3_inp(idx(j):idx(j+1)-1) = amp * R3_inp(idx(j));
end
%R3_inp = awgn(u_T, 70, 'measured'); % add random WGN: the value is the signal-to-noise ratio in dB, specified as a scalar
% Create an iddata object from the generated signal u
R3_inp = iddata([],R3_inp(1:12000),1); % al posto di 1 metto 60 se voglio Ts=60, ma tanto poi su Simulink devo rimettere Ts a 60
for i=1:4000
    R3_inp(i,:,:) = iddata([],R3_eq,1);
end
for i=6001:8000
    R3_inp(i,:,:) = iddata([],R3_eq,1);
end

%% F0A equilibrio 100
F0A_eq = F0A;
total_time = 13000; % simulation time
freq_range = [0 3e-2]; % frequency range 
ampl_range = [0.99999, 1.00001]; % amplitude range (multiplied by a and b)
a = F0A_eq-Delta_feedforward; % lower amplitude limit
b = F0A_eq+Delta_feedforward; % upper amplitude limit
rng(1000);
% Generate input signal of type prbs
F0A_inp = idinput(total_time, 'prbs', freq_range, ampl_range);
d = diff(F0A_inp); % difference: [u(2)-u(1)  u(3)-u(2)...]
idx = find(d) + 1; % returns the linear indices corresponding to the nonzero entries of the array d
idx = [1; idx];
for j = 1 : (length(idx)-1)
     amp = (b - a).*rand + a; % rand: uniformly distributed pseudorandom numbers
     F0A_inp(idx(j):idx(j+1)-1) = amp * F0A_inp(idx(j));
end
%F0A_inp = awgn(u_T, 70, 'measured'); % add random WGN: the value is the signal-to-noise ratio in dB, specified as a scalar
% Create an iddata object from the generated signal u
F0A_inp = iddata([],F0A_inp(1:12000),1); % al posto di 1 metto 60 se voglio Ts=60, ma tanto poi su Simulink devo rimettere Ts a 60
for i=1:6000
    F0A_inp(i,:,:) = iddata([],F0A_eq,1);
end


%%
figure('DefaultAxesFontSize',18); 
subplot(4,1,1); plot(R1_inp); xlim([1 12000])
subplot(4,1,2); plot(R2_inp); xlim([1 12000])
subplot(4,1,3); plot(R3_inp); xlim([1 12000])
subplot(4,1,4); plot(F0A_inp); xlim([1 12000])