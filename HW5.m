clc
clear
addpath('rodyo-FEX-GODLIKE-dcadb3a')
% addpath('C:\Users\ryana\OneDrive\Documents\School\MS\2020\Winter\ME 575\Project\bowlingsimulator')
addpath('C:\Users\Ryan\Documents\School\ME 575\Project\Bowling_Simulator\bowlingsimulator')
options = set_options('Display','on','algorithms','PSO');
[solution, fval, exitflag, output] = GODLIKE(@objective,[-1,0,0.1,0.1],[1,1,1,1],[], options)
options = optimset('Display','iter');
% [x, F] = fminsearch(@objectiveFcn,[0,0],options)

%%
clc
clear
addpath('rodyo-FEX-GODLIKE-dcadb3a')
addpath('C:\Users\ryana\OneDrive\Documents\School\MS\2020\Winter\ME 575\Project\bowlingsimulator')
options = set_options('Display','on','algorithms','PSO');
[xstar, F, output] = gradfree(@rosenbrock, [2, 2], [0, 0])
[solution, fval, exitflag, output] = GODLIKE(@rosenbrock,[0, 0],[2,2],[], options)
%%
clc
clear
addpath('rodyo-FEX-GODLIKE-dcadb3a')
options1 = set_options('Display','off','algorithms','PSO','MaxFunEvals',1e6);
options2 = optimoptions('fminunc', 'Display', 'off','MaxIterations', 1e6, 'MaxFunctionEvaluations', 1e6, ...
    'FiniteDifferenceType', 'central', 'SpecifyObjectiveGradient', false, 'CheckGradients', false, 'Diagnostics', 'on')
options3 = optimoptions('fminunc', 'Display', 'off','MaxIterations', 1e6, 'MaxFunctionEvaluations', 1e6, ...
    'FiniteDifferenceType', 'central', 'SpecifyObjectiveGradient', true, 'CheckGradients', false, 'Diagnostics', 'on')
for i = 1:5
    n = 2^i;
    lb = zeros(1,n);
    ub = 2*ones(1,n);
    [solution, fval(i), exitflag, output] = GODLIKE(@multirosenbrock,lb,ub,[], options1);
    numVars(i) = n;
    gradFreeFcount(i) = output.funcCount;
    x0 = zeros(1,n);;
    [solution1, fval1(i), exitflag, output1] = fminunc(@multirosenbrock, x0, options2)
    noGradientsFcount(i) = output1.funcCount;
    [solution1, fval2(i), exitflag, output2] = fminunc(@multirosenbrock, x0, options3);
    gradientsFcount(i) = output2.funcCount;
end

plot(numVars,gradFreeFcount,'*b');
hold on
plot(numVars,noGradientsFcount,'og');
plot(numVars,gradientsFcount,'+r');
xlabel('Number of Input Variables')
ylabel('Function Count')
legend('Gradient Free', 'Finite Differencing', 'Exact Gradient')