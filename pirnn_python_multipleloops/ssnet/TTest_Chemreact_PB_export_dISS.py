#%% Import libraries
from datetime import datetime
from typing import Callable, List, NamedTuple
import numpy as np
import torch
from torch.utils.data import DataLoader
import ssnet
from ssnet import Physics_based_chemicreact

TrainTBTT = NamedTuple('TrainTBTT', Ts=int, Ns=int) # to create tuples

# %% Load data
def ensure2D(x: np.ndarray):
    if x.ndim == 1:
        return np.expand_dims(x, axis=1)
    return x

# Normalized 6x6 system
U_train = ensure2D(np.genfromtxt('Datasets/Chemicalreactor/Train_chemicalreactor_Tsampling1s_10000samples_normalized_varinput20perc_prod.csv', delimiter=',',  usecols = (0,1,2,3)))
Y_train = ensure2D(np.genfromtxt('Datasets/Chemicalreactor/Train_chemicalreactor_Tsampling1s_10000samples_normalized_varinput20perc_prod.csv', delimiter=',', usecols = (4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)))
U_val = ensure2D(np.genfromtxt('Datasets/Chemicalreactor/Val_chemicalreactor_Tsampling1s_10000samples_normalized_varinput20perc_prod.csv', delimiter=',',  usecols = (0,1,2,3)))
Y_val = ensure2D(np.genfromtxt('Datasets/Chemicalreactor/Val_chemicalreactor_Tsampling1s_10000samples_normalized_varinput20perc_prod.csv', delimiter=',',  usecols = (4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)))
U_test = ensure2D(np.genfromtxt('Datasets/Chemicalreactor/Test_chemicalreactor_Tsampling1s_10000samples_normalized_varinput20perc_prod.csv', delimiter=',',  usecols = (0,1,2,3)))
Y_test = ensure2D(np.genfromtxt('Datasets/Chemicalreactor/Test_chemicalreactor_Tsampling1s_10000samples_normalized_varinput20perc_prod.csv', delimiter=',',  usecols = (4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)))


# %% Create model: RNN

size_inp = 4
size_out = 28

# Ns: number of subsequences we want to extract for training/validation/testing
# Ts: length of each training/validation/testing subsequence 

def train_rnn_model(deltaiss_regularizer: torch.nn.Module, train_batch_size: int, Ts: int = 200, Ns: int = 200, 
                    iss_regularizer: torch.nn.Module = None, lr: float = 1e-3):
    input_scaler = ssnet.data.MinMaxSequenceScaler()
    output_scaler = ssnet.data.MinMaxSequenceScaler()

    dataset = ssnet.data.tbptt(training=(U_train, Y_train), validation=(U_val, Y_val), testing=(U_test, Y_test),
                               Ts_train=Ts, Ns_train=Ns, Ts_val=300, Ns_val=10,
                               input_scaler=None, output_scaler=None)

    train_loader = DataLoader(dataset.training, batch_size=train_batch_size, shuffle=True)
    val_loader = DataLoader(dataset.validation, batch_size=10, shuffle=False)
    test_loader = DataLoader(dataset.testing, batch_size=1, shuffle=False)

    net = Physics_based_chemicreact.PhysicsNet(batch_first=True, input_scaler=input_scaler, output_scaler=output_scaler)
    
    net.init_optimizer(torch.optim.Adam, lr=lr)

    current_time = datetime.now().strftime("%Y%m%d_%H%M%S")
    rnn_str = 'GRU'
    descr_str = f'{rnn_str}_physics_bs{train_batch_size}_Ts{Ts}_Ns{Ns}time_{current_time}'

    callbacks = ssnet.callbacks.CallbacksWrapper(tensorboard_instance=f'training_output/CR/{descr_str}', 
                                             matfile_instance=f'training_output/CR/{descr_str}/net.mat',
                                             callbacks=[ssnet.callbacks.SigIntCallback(), 
                                                        ssnet.callbacks.TargetMetricCallback(1e-5), 
                                                        ssnet.callbacks.EarlyStoppingCallback(patience=2000),
                                                        ssnet.callbacks.LoggingCallback(),
                                                        ssnet.callbacks.PerformanceTestingCallback(test_loader, plot_fequency=50),
                                                        ssnet.callbacks.MatlabExportCallback()])

    training_results = net.fit(criterion=torch.nn.MSELoss(), 
                               train_loader=train_loader, 
                               val_loader=val_loader, 
                               val_metric=torch.nn.MSELoss(),
                               iss_regularizer=iss_regularizer if deltaiss_regularizer is None else None, 
                               deltaiss_regularizer=deltaiss_regularizer,
                               callbacks=callbacks,
                               washout=30,
                               epochs=2000)

    return training_results, descr_str

# %% Train the model

# RNN model
diss = ssnet.nn.SoftPieceWiseRegularizer(clearance=0.04, omega_plus=1e-3, omega_minus=1e-9, steepness=10.0)
training_results, descr_str = train_rnn_model(Ts=200, Ns=200, train_batch_size=20, lr=3e-3, deltaiss_regularizer=diss)

print('Average FIT:') 
print(training_results["FIT"])