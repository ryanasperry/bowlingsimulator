clear
clc
speed = 0;
direction  = -15;
velocity(1) = speed*sin(direction*pi/180);
velocity(2) = speed*cos(direction*pi/180);
world = World([0, -.25], velocity, 1);

for i = 1:1
    world.update();
end
%%
options = optimset('Display','iter');
x0 = [0,0];
lb = [-1, -1];
ub = [1, 1];
[F, xstar] = fmincon(@objectiveFcn,x0,[],[], [],[],lb,ub,[],options)
