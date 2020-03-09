function velocity = update_velocity(object, timestep)
if norm(object.velocity) > .005
    friction = 0;%.5;
    vNorm = object.velocity/norm(object.velocity);
    a = -vNorm*friction/object.mass;
    velocity = object.velocity + a * timestep;
else
    velocity = [0, 0];
end
end