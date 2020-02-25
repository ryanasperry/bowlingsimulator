clear
clc
world = World([.5, -.5], [-.5, 2], 1);

for i = 1:100
    world.update();
end