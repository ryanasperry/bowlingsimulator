function [J, d] = objectiveFcn(x)
speed = 8;
direction  = x(1)*15;
position = x(2)*.7;
velocity(1) = speed*sin(direction*pi/180);
velocity(2) = speed*cos(direction*pi/180);
world = World([position, -.25], velocity, 0); %change to 1 to show simulation

for i = 1:100
    world.update();
end
J = -log(sum(world.momentum));
d = world.displacement;
end