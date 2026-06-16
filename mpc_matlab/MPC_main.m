%% Main
[N, N_b, states_tot, n_uopt, n_inp, M, R1, R2, R3, F0A, R1_min, R1_max, R2_min, R2_max, R3_min, R3_max, F0A_min, F0A_max] = set_dimension();
xk0_obs = 0.5*ones(states_tot, 1);