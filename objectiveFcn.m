function [J, d] = objectiveFcn(x)
speed = 8;
direction  = x(1)*90;
position = x(2)*.52705;
velocity(1) = speed*sin(direction*pi/180);
velocity(2) = speed*cos(direction*pi/180);
world = World([position, -.25], velocity, 1); %change to 1 to show simulation

for i = 1:1000
    world.update();
end
J = -world.momentum(length(world.momentum));
d = world.displacement;
end