% Upload files
layers_file = load("layers_file.mat");
layers_file = layers_file.layers_file;
n_states = [3,3,3,3,3,3];
    
% 1
mu1 = sqrt(n_states(1));
Wz1 = (layers_file.layers{1,1}.weights.Wzf(:,1:n_states(1))).';
Uz1 = (layers_file.layers{1,1}.weights.Uzf(:,1:n_states(1))).';
bz1 = (layers_file.layers{1,1}.weights.bzf(:,1:n_states(1))).';
Wf1 = (layers_file.layers{1,1}.weights.Wzf(:,n_states(1)+1:end)).';
Uf1 = (layers_file.layers{1,1}.weights.Uzf(:,n_states(1)+1:end)).';
bf1 = (layers_file.layers{1,1}.weights.bzf(:,n_states(1)+1:end)).';
Wr1 = (layers_file.layers{1,1}.weights.Wr).';
Ur1 = (layers_file.layers{1,1}.weights.Ur).';
br1 = (layers_file.layers{1,1}.weights.br).';
x_hatinv = 1;
sigma_z_hatinv1  = sigmoidfunction(norm([Wz1 Uz1*x_hatinv bz1], "inf"));
sigma_f_hatinv1  = sigmoidfunction(norm([Wf1 Uf1*x_hatinv bf1], "inf"));
phi_r_hatinv1   = tanh(norm([Wr1 Ur1*x_hatinv br1], "inf"));
k_sigma1 = sigma_z_hatinv1 + (1-sigma_z_hatinv1)*(1/4*x_hatinv*norm(Uf1,"inf")+sigma_f_hatinv1)*norm(Ur1,"inf")+1/4*(phi_r_hatinv1+x_hatinv)*norm(Uz1,"inf");
k_1menosigma1 = 1 - sigma_z_hatinv1 + sigma_z_hatinv1*(1/4*x_hatinv*norm(Uf1,"inf")+sigma_f_hatinv1)*norm(Ur1,"inf")+1/4*(phi_r_hatinv1+x_hatinv)*norm(Uz1,"inf");
lambda1 = max(k_sigma1, k_1menosigma1);

% 2
mu2 = sqrt(n_states(2));
Wz2 = (layers_file.layers{1,3}.weights.Wzf(:,1:n_states(2))).';
Uz2 = (layers_file.layers{1,3}.weights.Uzf(:,1:n_states(2))).';
bz2 = (layers_file.layers{1,3}.weights.bzf(:,1:n_states(2))).';
Wf2 = (layers_file.layers{1,3}.weights.Wzf(:,n_states(2)+1:end)).';
Uf2 = (layers_file.layers{1,3}.weights.Uzf(:,n_states(2)+1:end)).';
bf2 = (layers_file.layers{1,3}.weights.bzf(:,n_states(2)+1:end)).';
Wr2 = (layers_file.layers{1,3}.weights.Wr).';
Ur2 = (layers_file.layers{1,3}.weights.Ur).';
br2 = (layers_file.layers{1,3}.weights.br).';
x_hatinv = 1;
sigma_z_hatinv2  = sigmoidfunction(norm([Wz2 Uz2*x_hatinv bz2], "inf"));
sigma_f_hatinv2  = sigmoidfunction(norm([Wf2 Uf2*x_hatinv bf2], "inf"));
phi_r_hatinv2   = tanh(norm([Wr2 Ur2*x_hatinv br2], "inf"));
k_sigma2 = sigma_z_hatinv2 + (1-sigma_z_hatinv2)*(1/4*x_hatinv*norm(Uf2,"inf")+sigma_f_hatinv2)*norm(Ur2,"inf")+1/4*(phi_r_hatinv2+x_hatinv)*norm(Uz2,"inf");
k_1menosigma2 = 1 - sigma_z_hatinv2 + sigma_z_hatinv2*(1/4*x_hatinv*norm(Uf2,"inf")+sigma_f_hatinv2)*norm(Ur2,"inf")+1/4*(phi_r_hatinv2+x_hatinv)*norm(Uz2,"inf");
lambda2 = max(k_sigma2, k_1menosigma2);

% 3
mu3 = sqrt(n_states(3));
Wz3 = (layers_file.layers{1,5}.weights.Wzf(:,1:n_states(3))).';
Uz3 = (layers_file.layers{1,5}.weights.Uzf(:,1:n_states(3))).';
bz3 = (layers_file.layers{1,5}.weights.bzf(:,1:n_states(3))).';
Wf3 = (layers_file.layers{1,5}.weights.Wzf(:,n_states(3)+1:end)).';
Uf3 = (layers_file.layers{1,5}.weights.Uzf(:,n_states(3)+1:end)).';
bf3 = (layers_file.layers{1,5}.weights.bzf(:,n_states(3)+1:end)).';
Wr3 = (layers_file.layers{1,5}.weights.Wr).';
Ur3 = (layers_file.layers{1,5}.weights.Ur).';
br3 = (layers_file.layers{1,5}.weights.br).';
x_hatinv = 1;
sigma_z_hatinv3  = sigmoidfunction(norm([Wz3 Uz3*x_hatinv bz3], "inf"));
sigma_f_hatinv3  = sigmoidfunction(norm([Wf3 Uf3*x_hatinv bf3], "inf"));
phi_r_hatinv3   = tanh(norm([Wr3 Ur3*x_hatinv br3], "inf"));
k_sigma3 = sigma_z_hatinv3 + (1-sigma_z_hatinv3)*(1/4*x_hatinv*norm(Uf3,"inf")+sigma_f_hatinv3)*norm(Ur3,"inf")+1/4*(phi_r_hatinv3+x_hatinv)*norm(Uz3,"inf");
k_1menosigma3 = 1 - sigma_z_hatinv3 + sigma_z_hatinv3*(1/4*x_hatinv*norm(Uf3,"inf")+sigma_f_hatinv3)*norm(Ur3,"inf")+1/4*(phi_r_hatinv3+x_hatinv)*norm(Uz3,"inf");
lambda3 = max(k_sigma3, k_1menosigma3);

% 4
mu4 = sqrt(n_states(4));
Wz4 = (layers_file.layers{1,7}.weights.Wzf(:,1:n_states(4))).';
Uz4 = (layers_file.layers{1,7}.weights.Uzf(:,1:n_states(4))).';
bz4 = (layers_file.layers{1,7}.weights.bzf(:,1:n_states(4))).';
Wf4 = (layers_file.layers{1,7}.weights.Wzf(:,n_states(4)+1:end)).';
Uf4 = (layers_file.layers{1,7}.weights.Uzf(:,n_states(4)+1:end)).';
bf4 = (layers_file.layers{1,7}.weights.bzf(:,n_states(4)+1:end)).';
Wr4 = (layers_file.layers{1,7}.weights.Wr).';
Ur4 = (layers_file.layers{1,7}.weights.Ur).';
br4 = (layers_file.layers{1,7}.weights.br).';
x_hatinv = 1;
sigma_z_hatinv4  = sigmoidfunction(norm([Wz4 Uz4*x_hatinv bz4], "inf"));
sigma_f_hatinv4  = sigmoidfunction(norm([Wf4 Uf4*x_hatinv bf4], "inf"));
phi_r_hatinv4   = tanh(norm([Wr4 Ur4*x_hatinv br4], "inf"));
k_sigma4 = sigma_z_hatinv4 + (1-sigma_z_hatinv4)*(1/4*x_hatinv*norm(Uf4,"inf")+sigma_f_hatinv4)*norm(Ur4,"inf")+1/4*(phi_r_hatinv4+x_hatinv)*norm(Uz4,"inf");
k_1menosigma4 = 1 - sigma_z_hatinv4 + sigma_z_hatinv4*(1/4*x_hatinv*norm(Uf4,"inf")+sigma_f_hatinv4)*norm(Ur4,"inf")+1/4*(phi_r_hatinv4+x_hatinv)*norm(Uz4,"inf");
lambda4 = max(k_sigma4, k_1menosigma4);

% 5
mu5 = sqrt(n_states(5));
Wz5 = (layers_file.layers{1,9}.weights.Wzf(:,1:n_states(5))).';
Uz5 = (layers_file.layers{1,9}.weights.Uzf(:,1:n_states(5))).';
bz5 = (layers_file.layers{1,9}.weights.bzf(:,1:n_states(5))).';
Wf5 = (layers_file.layers{1,9}.weights.Wzf(:,n_states(5)+1:end)).';
Uf5 = (layers_file.layers{1,9}.weights.Uzf(:,n_states(5)+1:end)).';
bf5 = (layers_file.layers{1,9}.weights.bzf(:,n_states(5)+1:end)).';
Wr5 = (layers_file.layers{1,9}.weights.Wr).';
Ur5 = (layers_file.layers{1,9}.weights.Ur).';
br5 = (layers_file.layers{1,9}.weights.br).';
x_hatinv = 1;
sigma_z_hatinv5  = sigmoidfunction(norm([Wz5 Uz5*x_hatinv bz5], "inf"));
sigma_f_hatinv5  = sigmoidfunction(norm([Wf5 Uf5*x_hatinv bf5], "inf"));
phi_r_hatinv5   = tanh(norm([Wr5 Ur5*x_hatinv br5], "inf"));
k_sigma5 = sigma_z_hatinv5 + (1-sigma_z_hatinv5)*(1/4*x_hatinv*norm(Uf5,"inf")+sigma_f_hatinv5)*norm(Ur5,"inf")+1/4*(phi_r_hatinv5+x_hatinv)*norm(Uz5,"inf");
k_1menosigma5 = 1 - sigma_z_hatinv5 + sigma_z_hatinv5*(1/4*x_hatinv*norm(Uf5,"inf")+sigma_f_hatinv5)*norm(Ur5,"inf")+1/4*(phi_r_hatinv5+x_hatinv)*norm(Uz5,"inf");
lambda5 = max(k_sigma5, k_1menosigma5);

% 6
mu6 = sqrt(n_states(6));
Wz6 = (layers_file.layers{1,11}.weights.Wzf(:,1:n_states(6))).';
Uz6 = (layers_file.layers{1,11}.weights.Uzf(:,1:n_states(6))).';
bz6 = (layers_file.layers{1,11}.weights.bzf(:,1:n_states(6))).';
Wf6 = (layers_file.layers{1,11}.weights.Wzf(:,n_states(6)+1:end)).';
Uf6 = (layers_file.layers{1,11}.weights.Uzf(:,n_states(6)+1:end)).';
bf6 = (layers_file.layers{1,11}.weights.bzf(:,n_states(6)+1:end)).';
Wr6 = (layers_file.layers{1,11}.weights.Wr).';
Ur6 = (layers_file.layers{1,11}.weights.Ur).';
br6 = (layers_file.layers{1,11}.weights.br).';
x_hatinv = 1;
sigma_z_hatinv6  = sigmoidfunction(norm([Wz6 Uz6*x_hatinv bz6], "inf"));
sigma_f_hatinv6  = sigmoidfunction(norm([Wf6 Uf6*x_hatinv bf6], "inf"));
phi_r_hatinv6   = tanh(norm([Wr6 Ur6*x_hatinv br6], "inf"));
k_sigma6 = sigma_z_hatinv6 + (1-sigma_z_hatinv6)*(1/4*x_hatinv*norm(Uf6,"inf")+sigma_f_hatinv6)*norm(Ur6,"inf")+1/4*(phi_r_hatinv6+x_hatinv)*norm(Uz6,"inf");
k_1menosigma6 = 1 - sigma_z_hatinv6 + sigma_z_hatinv6*(1/4*x_hatinv*norm(Uf6,"inf")+sigma_f_hatinv6)*norm(Ur6,"inf")+1/4*(phi_r_hatinv6+x_hatinv)*norm(Uz6,"inf");
lambda6 = max(k_sigma6, k_1menosigma6);

% Overall
mu = max([mu1, mu2, mu3, mu4, mu5, mu6])
lambda = max([lambda1, lambda2, lambda3, lambda4, lambda5, lambda6])

%%
q = 1;
Q = q*eye(states_tot);
s = q*1.5;
S = s*eye(states_tot);
sigma_Q_max = max(svd(Q));
sigma_S_min = min(svd(S));
sigma_S_max = max(svd(S));

soglia_M = (1/2*log((sigma_S_min-sigma_Q_max)/(mu^2*sigma_S_max))/log(lambda))-1