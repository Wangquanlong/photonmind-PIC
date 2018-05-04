classdef Source < handle
    properties
        amplitude
        mode
        wavelength
    end
    methods
        function obj = Source(amplitude, mode, wavelength)
            obj.amplitude = amplitude;
            obj.mode = mode;
            obj.wavelength = wavelength;
        end
    end
end
