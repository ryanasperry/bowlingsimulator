function position = update_position(object, timestep)
position = object.position + object.velocity * timestep;
end