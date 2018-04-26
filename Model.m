classdef Model < handle
    properties
        weights
        biases
    end
    methods
        function obj = Model(weights, biases)
            obj.weights = weights;
            obj.biases = biases;
        end

        function y = infer
        end
    end
end
