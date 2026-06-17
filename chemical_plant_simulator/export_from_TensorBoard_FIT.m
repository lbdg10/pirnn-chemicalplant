%% Export from Ptyhon
output_scaler_bias = load("output_scaler_bias.mat");
output_scaler_scale_common = load("output_scaler_scale_common.mat");
size_out = 28;
washout = 30;

y_real = zeros(size_out,size(testing.y_test_gt(1,:,1),2));
y_id = zeros(size_out,size(testing.y_hat_nn(1,:,1),2));
FIT = zeros(size_out,1);

% Real values
for i = 1:size_out
    y_real(i,:) = testing.y_test_gt(1,:,i)*output_scaler_scale_common.output_scaler_scale_common+output_scaler_bias.output_scaler_bias(i);
    y_id(i,:) = testing.y_hat_nn(1,:,i)*output_scaler_scale_common.output_scaler_scale_common+output_scaler_bias.output_scaler_bias(i);
    % y_real(i,:) = testing.y_test_gt(1,:,i);
    % y_id(i,:) = testing.y_hat_nn(1,:,i);
    FIT(i) = 100 * ( 1 - (norm(y_real(i,washout:end)-y_id(i,washout:end), 2) / norm(y_real(i,washout:end)-mean(y_real(i,washout:end)), 2)) );
end

FIT_avg = mean(FIT)

%%
figure; plot(y_real(27,:)); hold on; plot(y_id(27,:));
figure; plot(y_real(28,:)); hold on; plot(y_id(28,:));
%%
% FIT_mfr = 100 * (1- (norm(mfr_rit_pred(in:end)-mfr_rit_Real(in:end), 2)/norm(mfr_rit_Real(in:end)-mean(mfr_rit_Real(in:end)), 2)) );
% FIT_avg  = (FIT_Ts1 + FIT_Ts2 + FIT_Ts3 + FIT_Ts4 + FIT_Ts5 + FIT_Tr + FIT_mfr) / 7
