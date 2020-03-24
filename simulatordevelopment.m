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
x0 = [-.95, .55];
lb = [-1, 0];
ub = [1, 1];
[xstar, F] = fmincon(@objectiveFcn,x0,[],[], [],[],lb,ub,@constraints,options)
%[xstar, F] = fminsearch(@objectiveFcn,x0,options)
%%

x1 = -1:.01:1;
x2 = 0:.01:1;
[x, y] = meshgrid(x1,x2);
z = x*0;
k = 1;
for i = 1:length(x2)
    for j = 1:length(x1)
        [z(i,j),~] = objectiveFcn([x(i,j),y(i,j)]);
        [c, ~] = constraints([x(i,j),y(i,j)]);
        if max(c)<0
             strike(k,:) = [i,j];
             k = k+1;
        end
    end
end
surf(x*10, y*.52705, atan(z))
xlabel('Angle')
ylabel('Path')
zlabel('Objective Function')
zlim([-1.6,-1.4])

%%
for i = 1:length(strike)
    vals(i) = objectiveFcn([x(strike(i,1),strike(i,2)),y(strike(i,1),strike(i,2))]);
    hold on
    plot3(x(strike(i,1),strike(i,2))*10,y(strike(i,1),strike(i,2))*.52705,vals(i),'o');
end

%%
Fpenalty = @(x,mu) objectiveFcn(x)+mu/2*sum(max(0,constraints(x)));
mu = 1;
x0 = [.3,5];
for i = 1:5
    [xstar, val, exitflag] = fminunc(@(x)Fpenalty(x,mu),x0);
    mu = mu*10;
    x0 = xstar;
end

 %[xstar, val, exitflag] = fmincon(@rosen,[2,2],[],[],[],[],[],[],@cons)
function F = rosen(x)
F = (1-x(1))^2 + 100*(x(2)-x(1)^2)^2;
end

function c = cons(x)
c = -x(2)-x(1)-1;
end