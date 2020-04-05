function [J, d] = objectiveFcn(x)
speed = x(4)*15;
direction  = x(1)*90;
position = x(2)*.52705;
mass = x(3)*10;
velocity(1) = speed*sin(direction*pi/180);
velocity(2) = speed*cos(direction*pi/180);
world = World([position, -.25], velocity, mass, 0); %change to 1 to show simulation

for i = 1:100
    world.update();
end
J = (mass*speed^2)/world.momentum(length(world.momentum));
d = world.displacement;
end