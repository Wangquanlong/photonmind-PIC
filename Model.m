classdef Model
    properties
        weights
        biases
        activation_functions
        label_ranges
    end
    methods
        function obj = Model(weights, biases, activation_functions)
            obj.weights = weights;
            obj.biases = biases;
            obj.activation_functions = activation_functions;
        end

        function y = infer(obj, features)
            y = features;
            for n = 1:length(weights)
                y = y*obj.weights(n) + obj.biases(n);
                y = obj.ACT(y, activation_functions(n + 1))
            end
            y = obj.descale(y);
        end

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

        function y = descale(obj, x)
            y = obj.label_ranges(1, :) + x.*(obj.label_ranges(2, :) - obj.label_ranges(1, :));
        end
    end
end
