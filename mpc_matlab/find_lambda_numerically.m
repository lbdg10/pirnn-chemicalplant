% Initialize parameters
T = 100;
states_tot = 18;
mu = sqrt(states_tot);
layers_file = load("layers_file.mat");
input_scaler_bias = load("input_scaler_bias.mat");
input_scaler_scale_common = load("input_scaler_scale_common.mat");

%uk = [R1; R2; R3; F0A];
uk = zeros(4,1);
xk0_a = 0.9*ones(states_tot, 1); 
xk0_b = 0*ones(states_tot, 1); 
xkp_a = zeros(states_tot,T+1);
xkp_b = zeros(states_tot,T+1);
xkp_a(:,1) = xk0_a;
xkp_b(:,1) = xk0_b;
xk_norm2_diff = zeros(1,T+1);
lambda = 0.9;
xk_soglia = zeros(1,T+1); 

yk2_to1_inp = 0.5*ones(4,1);
yk6_inp = 0.5*ones(4,1);

% Call model
for k = 1:T
    [xkp_a(:,k+1), yk2_to1, yk6] = model_sim(xk0_a, uk, layers_file, input_scaler_bias, input_scaler_scale_common, yk2_to1_inp, yk6_inp);
    xk0_a = xkp_a(:,k+1);
    yk2_to1_inp = yk2_to1;
    yk6_inp = yk6;
end
for k = 1:T
    [xkp_b(:,k+1), yk2_to1, yk6] = model_sim(xk0_b, uk, layers_file, input_scaler_bias, input_scaler_scale_common, yk2_to1_inp, yk6_inp);
    xk0_b = xkp_b(:,k+1);
    yk2_to1_inp = yk2_to1;
    yk6_inp = yk6;
end

% Compute norm 2 and threshold
for k = 1:T+1
    xk_norm2_diff(1,k) = norm(xkp_a(:,k)-xkp_b(:,k), "inf");
    xk_soglia(1,k) = mu*lambda^k*norm(xk0_a, "inf"); 
end

%%
figure; plot(xk_norm2_diff); hold on; plot(xk_soglia); legend('xk norm2', 'threshold')

%%
function [xkp, yk2_to1, yk6] = model_sim(xk, uk, layers_file, input_scaler_bias, input_scaler_scale_common, yk2_to1, yk6)
    
    n_states = [3,3,3,3,3,3];
    layers_file = layers_file.layers_file;

    % Scale input and output
    %uk = (uk  - (input_scaler_bias.input_scaler_bias).') ./ (input_scaler_scale_common.input_scaler_scale_common).';
 
    % GRU 1
    uk1 = [uk(1,:); uk(3:4,:); yk2_to1; yk6];
    xk1 = xk(1:n_states(1),:); 
    zk1 = sigmoidfunction((layers_file.layers{1,1}.weights.Wzf(:,1:n_states(1))).' * uk1 + (layers_file.layers{1,1}.weights.Uzf(:,1:n_states(1))).' * xk1 + (layers_file.layers{1,1}.weights.bzf(:,1:n_states(1))).');
    fk1 = sigmoidfunction((layers_file.layers{1,1}.weights.Wzf(:,n_states(1)+1:end)).' * uk1 + (layers_file.layers{1,1}.weights.Uzf(:,n_states(1)+1:end)).' * xk1 + (layers_file.layers{1,1}.weights.bzf(:,n_states(1)+1:end)).');
    phi1 = tanh((layers_file.layers{1,1}.weights.Wr).' * uk1 + (layers_file.layers{1,1}.weights.Ur).' * (fk1.* xk1) + (layers_file.layers{1,1}.weights.br).');
    xkp1 = zk1 .* xk1 + (1-zk1) .* phi1;
    yk1 = layers_file.layers{1,2}.weights.weight * xk1 + (layers_file.layers{1,2}.weights.bias).';
    
    % GRU 2
    uk2 = [uk(1,:); uk(3:4,:); yk1];
    xk2 = xk(n_states(1)+1:n_states(1)+n_states(2),:);
    zk2 = sigmoidfunction((layers_file.layers{1,3}.weights.Wzf(:,1:n_states(2))).' * uk2 + (layers_file.layers{1,3}.weights.Uzf(:,1:n_states(2))).' * xk2 + (layers_file.layers{1,3}.weights.bzf(:,1:n_states(2))).');
    fk2 = sigmoidfunction((layers_file.layers{1,3}.weights.Wzf(:,n_states(2)+1:end)).' * uk2 + (layers_file.layers{1,3}.weights.Uzf(:,n_states(2)+1:end)).' * xk2 + (layers_file.layers{1,3}.weights.bzf(:,n_states(2)+1:end)).');
    phi2 = tanh((layers_file.layers{1,3}.weights.Wr).' * uk2 + (layers_file.layers{1,3}.weights.Ur).' * (fk2.* xk2) + (layers_file.layers{1,3}.weights.br).');
    xkp2 = zk2 .* xk2 + (1-zk2) .* phi2;
    yk2 = layers_file.layers{1,4}.weights.weight * xk2 + (layers_file.layers{1,4}.weights.bias).';
    yk2_to1 = yk2(1:4,:);
    yk2_to3 = yk2(5:8,:); 
     
    % GRU 3
    uk3 = [uk(2:4,:); yk2_to3];
    xk3 = xk(n_states(1)+n_states(2)+1:n_states(1)+n_states(2)+n_states(3),:);
    zk3 = sigmoidfunction((layers_file.layers{1,5}.weights.Wzf(:,1:n_states(3))).' * uk3 + (layers_file.layers{1,5}.weights.Uzf(:,1:n_states(3))).' * xk3 + (layers_file.layers{1,5}.weights.bzf(:,1:n_states(3))).');
    fk3 = sigmoidfunction((layers_file.layers{1,5}.weights.Wzf(:,n_states(3)+1:end)).' * uk3 + (layers_file.layers{1,5}.weights.Uzf(:,n_states(3)+1:end)).' * xk3 + (layers_file.layers{1,5}.weights.bzf(:,n_states(3)+1:end)).');
    phi3 = tanh((layers_file.layers{1,5}.weights.Wr).' * uk3 + (layers_file.layers{1,5}.weights.Ur).' * (fk3.* xk3) + (layers_file.layers{1,5}.weights.br).');
    xkp3 = zk3 .* xk3 + (1-zk3) .* phi3;
    yk3 = layers_file.layers{1,6}.weights.weight * xk3 + (layers_file.layers{1,6}.weights.bias).';

    % GRU 4
    uk4 = [uk(2:4,:); yk3];
    xk4 = xk(n_states(1)+n_states(2)+n_states(3)+1:n_states(1)+n_states(2)+n_states(3)+n_states(4),:);
    zk4 = sigmoidfunction((layers_file.layers{1,7}.weights.Wzf(:,1:n_states(4))).' * uk4 + (layers_file.layers{1,7}.weights.Uzf(:,1:n_states(4))).' * xk4 + (layers_file.layers{1,7}.weights.bzf(:,1:n_states(4))).');
    fk4 = sigmoidfunction((layers_file.layers{1,7}.weights.Wzf(:,n_states(4)+1:end)).' * uk4 + (layers_file.layers{1,7}.weights.Uzf(:,n_states(4)+1:end)).' * xk4 + (layers_file.layers{1,7}.weights.bzf(:,n_states(4)+1:end)).');
    phi4 = tanh((layers_file.layers{1,7}.weights.Wr).' * uk4 + (layers_file.layers{1,7}.weights.Ur).' * (fk4.* xk4) + (layers_file.layers{1,7}.weights.br).');
    xkp4 = zk4 .* xk4 + (1-zk4) .* phi4;
    yk4 = layers_file.layers{1,8}.weights.weight * xk4 + (layers_file.layers{1,8}.weights.bias).';
    
    % GRU 5
    uk5 = [uk(2:4,:); yk4];
    xk5 = xk(n_states(1)+n_states(2)+n_states(3)+n_states(4)+1:n_states(1)+n_states(2)+n_states(3)+n_states(4)+n_states(5),:);
    zk5 = sigmoidfunction((layers_file.layers{1,9}.weights.Wzf(:,1:n_states(5))).' * uk5 + (layers_file.layers{1,9}.weights.Uzf(:,1:n_states(5))).' * xk5 + (layers_file.layers{1,9}.weights.bzf(:,1:n_states(5))).');
    fk5 = sigmoidfunction((layers_file.layers{1,9}.weights.Wzf(:,n_states(5)+1:end)).' * uk5 + (layers_file.layers{1,9}.weights.Uzf(:,n_states(5)+1:end)).' * xk5 + (layers_file.layers{1,9}.weights.bzf(:,n_states(5)+1:end)).');
    phi5 = tanh((layers_file.layers{1,9}.weights.Wr).' * uk5 + (layers_file.layers{1,9}.weights.Ur).' * (fk5.* xk5) + (layers_file.layers{1,9}.weights.br).');
    xkp5 = zk5 .* xk5 + (1-zk5) .* phi5;
    yk5 = layers_file.layers{1,10}.weights.weight * xk5 + (layers_file.layers{1,10}.weights.bias).';
    
    % GRU 6
    uk6 = [uk(2:4,:); yk5];
    xk6 = xk(n_states(1)+n_states(2)+n_states(3)+n_states(4)+n_states(5)+1:n_states(1)+n_states(2)+n_states(3)+n_states(4)+n_states(5)+n_states(6),:);
    zk6 = sigmoidfunction((layers_file.layers{1,11}.weights.Wzf(:,1:n_states(6))).' * uk6 + (layers_file.layers{1,11}.weights.Uzf(:,1:n_states(6))).' * xk6 + (layers_file.layers{1,11}.weights.bzf(:,1:n_states(6))).');
    fk6 = sigmoidfunction((layers_file.layers{1,11}.weights.Wzf(:,n_states(6)+1:end)).' * uk6 + (layers_file.layers{1,11}.weights.Uzf(:,n_states(6)+1:end)).' * xk6 + (layers_file.layers{1,11}.weights.bzf(:,n_states(6)+1:end)).');
    phi6 = tanh((layers_file.layers{1,11}.weights.Wr).' * uk6 + (layers_file.layers{1,11}.weights.Ur).' * (fk6.* xk6) + (layers_file.layers{1,11}.weights.br).');
    xkp6 = zk6 .* xk6 + (1-zk6) .* phi6;
    yk6 = layers_file.layers{1,12}.weights.weight * xk6 + (layers_file.layers{1,12}.weights.bias).';
    
    % Overall
    xkp = [xkp1; xkp2; xkp3; xkp4; xkp5; xkp6];          
end