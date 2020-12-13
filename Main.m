% This is demo code to perform feature weighting using Improved Ant Lion
% Optimization.

clear
clc
load('GASTRO_Data.mat')
Population = 20;
Maximum_iterations = 200;
loutv = cvpartition(label,'LeaveOut');
train=get_comb(Ntrain,Wtrain,9);    % For best Results
ntrain=minmax0(train);
[GlobalBest,ConCurve] = IALO(ntrain,label,Population,Maximum_iterations,loutv);
plot(ConCurve)