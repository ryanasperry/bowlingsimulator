
function [c, ceq] = constraints(x)
ceq = []; %no equivalence constraints
%set up minimum displacements
disp = ones(10,1)*.05;
%calculate value for constraint
[~, displacement] = objectiveFcn(x);
c = disp - displacement';
end