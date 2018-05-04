classdef Model < handle
    properties
        inputs
        outputs
        weights
        biases
        activation_functions
        feature_ranges
        label_ranges
    end
    methods
        function obj = Model(inputs, outputs, weights, biases, activation_functions, feature_ranges, label_ranges)
            obj.inputs = inputs;
            obj.outputs = outputs;
            obj.weights = weights;
            obj.biases = biases;
            obj.activation_functions = activation_functions;
            obj.feature_ranges = feature_ranges;
            obj.label_ranges = label_ranges;
        end

        % send features through the model to predict the labels
        % this is where we tap into PhotonMind
        function y = infer(obj, features)
            y = obj.scale_features(features);
            for n = 1:length(obj.weights)
                y = y*obj.weights{n} + obj.biases{n};
                y = obj.ACT(y, obj.activation_functions{n + 1});
            end
            y = obj.descale_labels(y);
        end

        % quickly display information about the model
        function about(obj)
            disp('Inputs');
            for n = 1:length(obj.inputs)
                disp([obj.inputs(n).structure, ' ', obj.inputs(n).parameter, ' range = ',...
                    num2str(obj.inputs(n).range(1)), ' to ', num2str(obj.inputs(n).range(2))]);
            end
            fprintf('\n');
            disp('Outputs');
            for n = 1:length(obj.outputs)
                disp([obj.outputs(n).port, ': ', obj.outputs(n).attribute]);
            end
        end
    end
    methods (Access = private)
        % inference requires values from 0 to 1
        function y = scale_features(obj, x)
            y = (x - obj.feature_ranges(1, :))./(obj.feature_ranges(2, :) - obj.feature_ranges(1, :));
        end

        % get real values from scaled values
        function y = descale_labels(obj, x)
            y = obj.label_ranges(1, :) + x.*(obj.label_ranges(2, :) - obj.label_ranges(1, :));
        end

        % activation function used in inference
        % 'none' is usually used in input and output layers
        function y = ACT(obj, x, activation_function)
            switch activation_function
                case 'sig'
                    y = 1./(1 + exp(-x));
                case 'relu'
                    y = max(0, x);
                case 'tanh'
                    y = tanh(x);
                case 'none'
                    y = x;
            end
        end
    end
end
