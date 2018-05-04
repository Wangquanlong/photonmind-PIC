classdef Device < handle
    properties
        model
        constants
        conditions
        matches
        features
    end
    methods
        function obj = Device(model)
            obj.model = model;
        end

        function add_constant(obj, index, constant)
            if index > length(obj.model.inputs), error('Index out of input range'); end
            obj.constants(index).value = constant;
        end

        function remove_constant(obj, index)
            obj.constants(index).value = [];
        end

        function add_condition(obj, index, value, tolerance)
            if index > length(obj.model.outputs), error('Index out of output range'); end
            obj.conditions(index).value = value;
            obj.conditions(index).tolerance = tolerance;
        end

        function remove_condition(obj, index)
            obj.conditions(index).value = [];
            obj.conditions(index).tolerance = [];
        end

        % simple parametric sweep that finds all possible devices
        % sweep size grows exponentially with resolution
        function solve(obj, resolution)
            if isempty(obj.conditions), error('Must have at least one condition'); end
            v = waitbar(0, 'Solving...');

            obj.matches = {};
            featureset = obj.get_uniform_featureset(resolution);

            for n = 1:length(featureset)
                waitbar(n/length(featureset));
                features = featureset(n, :);
                labels = obj.model.infer(features);
                if obj.check_conditions(labels)
                    obj.matches{end + 1} = features;
                    obj.print_device(features, labels, length(obj.matches));
                end
            end

            close(v);
        end

        % allows the user to set the features of this device from the generated list of matches
        function set_features(obj, match_num)
            if ~ismember(match_num, 1:length(obj.matches)), error('Match number out of range'); end
            obj.features = cell2mat(obj.matches(match_num));
        end

        % predicts the output based on the features of the device
        function run(obj)
            if isempty(obj.features), error('No features have been set for this device'); end
            y = obj.model.infer(obj.features);
            for n = 1:length(obj.model.outputs)
                disp([obj.model.outputs(n).attribute, ' = ', num2str(y(n))]);
            end
        end
    end
    methods (Access = private)
        % create a uniformly distributed featureset to check
        function y = get_uniform_featureset(obj, resolution)
            for n = 1:length(obj.model.inputs)
                sequence = linspace(obj.model.inputs(n).range(1),...
                obj.model.inputs(n).range(2), resolution);
                sequence = repmat(sequence, [resolution^(length(obj.model.inputs) - n), 1]);
                featureset(n, :) = repmat(sequence(:), [resolution^(n - 1), 1]);
            end

            for n = 1:length(obj.constants)
                if ~isempty(obj.constants(n).value)
                    featureset(n, :) = obj.constants(n).value;
                end
            end
            y = unique(featureset', 'rows');
        end

        % check if value is within range of conditions
        % return false if any do not clear
        function y = check_conditions(obj, labels)
            y = true;
            for n = 1:length(obj.conditions)
                if abs(labels(n) - obj.conditions(n).value) > abs(obj.conditions(n).tolerance)
                    y = false;
                end
            end
        end

        % print information about the found device
        function print_device(obj, features, labels, match_num)
            disp(['Match #', num2str(match_num)]);
            for n = 1:length(obj.model.inputs)
                disp([obj.model.inputs(n).parameter, ' = ', num2str(features(n))]);
            end
            for n = 1:length(obj.model.outputs)
                disp([obj.model.outputs(n).attribute, ' = ', num2str(labels(n))]);
            end
            fprintf('\n');
        end
    end
end
