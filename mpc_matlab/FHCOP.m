function [u_opt, t_solver] = FHCOP(tau_s, N, T_s, T_b, t, xk)
    % FHCOP function solves the Finite Horizon Control Optimization Problem
    % Import the CasADi toolkit
    [N, N_b, states_tot, n_uopt, n_inp, M, R1, R2, R3, F0A, R1_min, R1_max, R2_min, R2_max, R3_min, R3_max, F0A_min, F0A_max] = set_dimension();

    % At the beginning MPC should not work
    if t < T_b
        u_opt = [R1; R2; R3; F0A];
        t_solver = 0;
    else        
        import casadi.*;
        tic
        display('*** Start optimization ***')
        opti = casadi.Opti();
        
        % Load files
        layers_file = load("layers_file.mat");
        input_scaler_bias = load("input_scaler_bias.mat");
        input_scaler_scale_common = load("input_scaler_scale_common.mat");

        equilibrium = load("equilibrium.mat");
        R1_eq = equilibrium.R1_eq(:,t);
        R2_eq = equilibrium.R2_eq(:,t);
        R3_eq = equilibrium.R3_eq(:,t);
        F0A_eq = equilibrium.F0A_eq(:,t);
        u_bar = [R1_eq; R2_eq; R3_eq; F0A_eq];
        x_bar = equilibrium.x_eq(:,t);

        % Declare the optimization variables
        u = opti.variable(n_inp, n_uopt);
        x = opti.variable(states_tot, N+1+M);
        J_x_N = opti.variable(1, N+1);
        J_u = opti.variable(1, N);
        J_M = opti.variable(1, M);
        J  = opti.variable(1, 1);
        
        % Input constraints
        opti.subject_to(u(:, ceil((N+1)/N_b):end) == u_bar); % u after N must be equal to the equilibrium
        opti.subject_to(R1_min <= u(1,:));
        opti.subject_to(R1_max >= u(1,:));
        opti.subject_to(R2_min <= u(2,:));
        opti.subject_to(R2_max >= u(2,:));
        opti.subject_to(R3_min <= u(3,:));
        opti.subject_to(R3_max >= u(3,:));
        opti.subject_to(F0A_min <= u(4,:));
        opti.subject_to(F0A_max >= u(4,:));

        % Initial state
        opti.subject_to(x(:, 1) == xk);
  
        % Cost function parameters
        q = 1;
        Q = q*eye(states_tot);
        R = 0.01*eye(n_inp);
        s = q*1.5;
        S = s*eye(states_tot);
        u_eq = u_bar*ones(1, n_uopt);
        x_eq = repmat(x_bar, 1, N+1+M);
        
        % System dynamics constraint
        yk2_to1_inp = 0.5*ones(4,1);
        yk6_inp = 0.5*ones(4,1);
        for j=1:N
            ii = min(floor(j/N_b)+1, N/N_b);
            [xkp1, yk2_to1, yk6] = model_step(x(:, j), u(:, ii), layers_file, input_scaler_bias, input_scaler_scale_common, yk2_to1_inp, yk6_inp);
            yk2_to1_inp = yk2_to1;
            yk6_inp = yk6;
            opti.subject_to(x(:, j+1) == xkp1);
            opti.subject_to( J_u(1,j) == (u(:,j)-u_eq(:,j))'*R*(u(:,j)-u_eq(:,j)) );
        end
        
        for j = 1:N+1
            opti.subject_to( J_x_N(1,j) == (x(:,j)-x_eq(:,j))'*Q*(x(:,j)-x_eq(:,j)) );
        end
     
        for j = 1:M
            opti.subject_to( J_M(1,j) == (x(:,j+N+1)-x_eq(:,j+N+1))'*S*(x(:,j+N+1)-x_eq(:,j+N+1)) );
        end
        
        opti.subject_to( J == ones(1,N+1)*J_x_N' + ones(1,N)*J_u' + ones(1,M)*J_M' );
        opti.minimize(J);
        
        % CASADI settings
        prob_opts = struct;
        prob_opts.expand = true;
        prob_opts.ipopt.print_level = 0;    % Disable printing
        prob_opts.print_time = false;       % Do not print the timestamp
        % IPOPT settings
        ip_opts = struct;
        ip_opts.print_level = 0;            % Disable printing
        ip_opts.max_iter = 1e4;             % Maximum iterations. 1e5
        ip_opts.compl_inf_tol = 1e-5;       % Desired threshold for the complementarity conditions. 1e-6

        % Set the solver
        opti.solver('ipopt', prob_opts, ip_opts);
        
        t_initialization = toc

       try
            % SOLVE THE FHOCP
            tic  
            sol = opti.solve();
            display('*** MPC solved ***')
            % Extract the optimal control action
            u_opt = sol.value(u(:, 1));
       catch EX
            display('*** MPC not solved ***')
            keyboard
            u_trial = opti.debug.value(u(4, 1));
       end
       t_solver = toc
    end
end