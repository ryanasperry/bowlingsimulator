classdef Disc
    properties
        mass {mustBeNumeric}
        radius {mustBeNumeric}
        position {mustBeNumeric}
        velocity {mustBeNumeric}
        cRes {mustBeNumeric} = 1;
    end
    methods
        function obj = Disc(mass, radius, position, velocity)
            obj.mass = mass;
            obj.radius = radius;
            obj.position = position;
            obj.velocity = velocity;
        end
    end
end