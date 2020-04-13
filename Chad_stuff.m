speed = 0.1;
ang = 0;
pos = 0.3;
weight = 0.4;

x0 = [speed,ang,pos,weight];

nvec = 2.^[1:10]*100;
tic
% J_vec = zeros(length(nvec),1);
for ii = 9:length(nvec)
    n = nvec(ii);
    [J, d] = objectiveFcn_UUO([speed,ang,pos,weight],n);
    J_vec(ii) = J;
end
toc
semilogx(nvec,J_vec,'ro')



