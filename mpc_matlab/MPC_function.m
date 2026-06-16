classdef MPC_function < matlab.System
    % MPC Model Predictive Control Block

    % Tunable properties
    properties(Nontunable)
        % tau_s Sampling time
        tau_s = 1;
        % N Prediction Horizon
        N = 12; 
        % T_s Execution Time
        T_s = 1; 
        % T_b Blocking strategy time
        T_b = 1; 
    end

    methods(Access = protected)
        function [u_opt, t_solver] = stepImpl(obj, t, xk)
            % Solve the FHCOP
            [u_opt, t_solver] = FHCOP(obj.tau_s, obj.N, obj.T_s, obj.T_b, t, xk);
        end

        function num = getNumInputsImpl(~)
            % Define total number of inputs for system with optional inputs
            num = 2;
        end

        function num = getNumOutputsImpl(~)
            % Define total number of outputs for system with optional outputs: output of MPC is the control action, i.e. u
            num = 2;
        end

        function [out1, out2] = getOutputSizeImpl(obj)
            % Return size for each output port
            out1 = [4 1];
            out2 = [1 1];
        end

        function [out1, out2] = getOutputDataTypeImpl(~)
            % Return data type for each output port
            out1 = "double";
            out2 = "double";
        end

        function [out1, out2] = isOutputComplexImpl(~)
            % Return true for each output port with complex data
            out1 = false;
            out2 = false;
        end

        function [out1, out2] = isOutputFixedSizeImpl(~)
            % Return true for each output port with fixed size
            out1 = true;
            out2 = true;
        end

        function sts = getSampleTimeImpl(obj)
            % Define sample time type and parameters
            sts = obj.createSampleTime("Type", "Discrete", "SampleTime", obj.T_s);
        end
    end
end
