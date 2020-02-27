clear
clc
speed = 8;
direction  = -15;
velocity(1) = speed*sin(direction*pi/180);
velocity(2) = speed*cos(direction*pi/180);
world = World([.5, -.5], velocity, 1);

for i = 1:100
    world.update();
end

