import itertools
import torch
from ssnet import nn, data
import numpy as np
from typing import List

class PhysicsNet(nn.StateSpaceNN):
    
    def __init__(self, batch_first: bool = True, input_scaler: data.SequenceScaler = None, output_scaler: data.SequenceScaler = None):
        
        super(PhysicsNet, self).super_init()

        # Initialize parameters
        self.n_input = [11, 7, 7, 7, 7, 7]
        self.n_output = [4, 8, 4, 4, 4, 4]
        self.n_neurons = [3, 3, 3, 3, 3, 3]  
        self.n_rnn = 6

        # Initialize the GRU
        nnlist = [None] * self.n_rnn
        linlist =  [None] * self.n_rnn
        self.n_states = [0] * self.n_rnn

        # Define GRU
        for i in range(self.n_rnn):
            nnlist[i] = nn.StateSpaceGRU(in_features=int(self.n_input[i]), units=int(self.n_neurons[i]))
            linlist[i] = torch.nn.Linear(in_features=int(self.n_neurons[i]), out_features=self.n_output[i])
            self.n_states[i] = int(self.n_neurons[i])

        # Transform into ModuleList
        self.nn = torch.nn.ModuleList(nnlist)
        self.lin = torch.nn.ModuleList(linlist)
        self.layers = list(itertools.chain.from_iterable(zip(self.nn, self.lin)))

        # Initialize layers
        self.cell_states = [0 for x in range(2*self.n_rnn)]
        for i in range(self.n_rnn):
            self.cell_states[2*i] = int(self.n_neurons[i]) # [neurons, 0, neurons, 0, ...]
        self.n_layers = 2*self.n_rnn

        self.batch_first = batch_first
        self.optimizer = None
        self.input_scaler = input_scaler
        self.output_scaler = output_scaler
        self.trainable = True


    def _recurrence(self, u: torch.Tensor, x0, y2k_to1, y6k_to1): 

        # Initialize
        x0 = torch.split(x0, self.cell_states, dim=1)
        xkp = [None] * self.n_layers # inizializzo x_k+1 a 4 layer vuoti

        # Input
        u1 = u[:, torch.tensor([0,2,3], dtype=torch.long)] # R1, R3, F0A
        u2 = u[:, torch.tensor([0,2,3], dtype=torch.long)] # R1, R3, F0A
        u3 = u[:, torch.tensor([1,2,3], dtype=torch.long)] # R2, R3, F0A
        u4 = u[:, torch.tensor([1,2,3], dtype=torch.long)] # R2, R3, F0A
        u5 = u[:, torch.tensor([1,2,3], dtype=torch.long)] # R2, R3, F0A
        u6 = u[:, torch.tensor([1,2,3], dtype=torch.long)] # R2, R3, F0A
         
        # 1
        u1_tilde = torch.cat([u1, y2k_to1, y6k_to1], dim=-1) # input: R1, R3, F0A, 4*xd1, 4*xd3
        _, x1kp = self.nn[0](u1_tilde, x0[0]) # mi serve solo il primo layer quindi x0[0]
        y1k = self.lin[0](x0[0]) # per output applico linear agli stati
        Iy_1 = torch.tensor([0,1,2,3], dtype=torch.long)
        y1k_to2 = y1k[:, Iy_1] # a 2 devo dare tutti e quattro gli output come input

        # 2
        u2_tilde = torch.cat([u2, y1k_to2], dim=-1) # input: R1, V1, R3, V3, 4*yR1
        _, x2kp = self.nn[1](u2_tilde, x0[2]) # mi serve solo il primo layer quindi x0[2]
        y2k = self.lin[1](x0[2]) # per output applico linear agli stati
        Iy_2_to1 = torch.tensor([0,1,2,3], dtype=torch.long)
        Iy_2_to3 = torch.tensor([4,5,6,7], dtype=torch.long)
        y2k_to1 = y2k[:, Iy_2_to1] # a 1 devo dare i primi 4 output come input
        y2k_to3 = y2k[:, Iy_2_to3] # a 3 devo dare gli ultimi 4 output come input

        # 3
        u3_tilde = torch.cat([u3, y2k_to3], dim=-1) # input: R2, V2, R3, V3, 4*xb1
        _, x3kp = self.nn[2](u3_tilde, x0[4]) # mi serve solo il primo layer quindi x0[4]
        y3k = self.lin[2](x0[4]) # per output applico linear agli stati
        Iy_3_to4 = torch.tensor([0,1,2,3], dtype=torch.long)
        y3k_to4 = y3k[:, Iy_3_to4] # a 4 devo dare tutti e quattro gli output come input

        # 4
        u4_tilde = torch.cat([u4, y3k_to4], dim=-1) # input: R2, V2, R3, V3, 4*xb2
        _, x4kp = self.nn[3](u4_tilde, x0[6]) # mi serve solo il primo layer quindi x0[6]
        y4k = self.lin[3](x0[6]) # per output applico linear agli stati
        Iy_4_to5 = torch.tensor([0,1,2,3], dtype=torch.long)
        y4k_to5 = y4k[:, Iy_4_to5] # a 5 devo dare tutti e quattro gli output come input

        # 5
        u5_tilde = torch.cat([u5, y4k_to5], dim=-1) # input: R2, V2, R3, V3, 4*yR2
        _, x5kp = self.nn[4](u5_tilde, x0[8]) # mi serve solo il primo layer quindi x0[8]
        y5k = self.lin[4](x0[8]) # per output applico linear agli stati
        Iy_5_to6 = torch.tensor([0,1,2,3], dtype=torch.long)
        y5k_to6 = y5k[:, Iy_5_to6] # a 6 devo dare tutti e quattro gli output come input

        # 6
        u6_tilde = torch.cat([u6, y5k_to6], dim=-1) # input: R2, V2, R3, V3, 4*yR3
        _, x6kp = self.nn[5](u6_tilde, x0[10]) # mi serve solo il primo layer quindi x0[10]
        y6k = self.lin[5](x0[10]) # per output applico linear agli stati
        Iy_6_to1 = torch.tensor([0,1,2,3], dtype=torch.long)
        y6k_to1 = y6k[:, Iy_6_to1] # a 1 devo dare tutti e quattro gli output come input

        yk = torch.cat([y1k, y2k, y3k, y4k, y5k, y6k], dim=-1) # concateno tutti gli output
        xkp[0] = x1kp
        xkp[1] = torch.zeros_like(x0[1])
        xkp[2] = x2kp
        xkp[3] = torch.zeros_like(x0[3])
        xkp[4] = x3kp
        xkp[5] = torch.zeros_like(x0[5])
        xkp[6] = x4kp
        xkp[7] = torch.zeros_like(x0[7])
        xkp[8] = x5kp
        xkp[9] = torch.zeros_like(x0[9])
        xkp[10] = x6kp
        xkp[11] = torch.zeros_like(x0[11])
            
        xkp_ret = torch.cat(xkp, dim=1)

        return yk, xkp_ret, y2k_to1, y6k_to1
    
    # def iss_residuals(self):
    #     return []

    # def deltaiss_residuals(self):
    #     return []

    def save_model(self, path):
        raise NotImplementedError

    @staticmethod
    def load_model(path, disable_training):
        raise NotImplementedError