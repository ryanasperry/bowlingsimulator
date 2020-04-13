function [J, d] = objectiveFcn_UUO(x,n)
speed = x(4)*15;
direction  = x(1)*90;
position = x(2)*.52705;
mass = x(3)*10;

%setup Monte Carlo
sigma = 0.01/2; %1 cm will be 2 standard deviations.
position_vec = normrnd(position,sigma,n,1);
sigma = .25/2;
speed_vec = normrnd(speed,sigma,n,1);
sigma = .1/2;
mass_vec = normrnd(mass,sigma,n,1);
sigma = 5/2;
direction_vec = normrnd(direction,sigma,n,1);

velocity(:,1) = speed_vec.*sin(direction_vec*pi/180);
velocity(:,2) = speed_vec.*cos(direction_vec*pi/180);
J_vec = zeros(n,1);
d_vec = zeros(n,10);

for ii = 1:n
    world = World([position_vec(ii), -.25], velocity(ii,:), mass_vec(ii), 0); %change to 1 to show simulation
    numberofSteps = 50+(1-x(4))*300;
    for i = 1:numberofSteps
        world.update();
        if norm(world.ball.velocity) == 0
        break
        end
    end
    J_vec(ii) = (mass*speed)/world.momentum(length(world.momentum))^2;
    d_vec(ii,:) = world.displacement;
end
J = mean(J_vec);
d = mean(d_vec);
