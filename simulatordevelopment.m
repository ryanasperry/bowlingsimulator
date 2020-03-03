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
options = optimset('Display','iter','ObjectiveLimit',-6e150);
x0 = [.8, .06];
lb = [-1, -1];
ub = [1, 1];
[xstar, F] = fmincon(@objectiveFcn,x0,[],[], [],[],lb,ub,@constraints,options)
%[xstar, F] = fminsearch(@objectiveFcn,x0)
%%

x1 = -1:.1:1;
x2 = -1:.1:1;
[x, y] = meshgrid(x1,x2);
z = x*0;
for i = 1:length(x1)
    for j = 1:length(x2)
        [z(i,j),~] = objectiveFcn([x(i,j),y(i,j)]);
    end
end
surf(x*15, y*.7, z)
xlabel('Angle')
ylabel('Path')
zlabel('Objective Function')
