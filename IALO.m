% Source Code for Feature Weighting with Improved Ant Lion optimization (Version 1.0)
%
% This code aims to search for the feature weights with the optimal parameters
% of SVM simultaneously.
%
% Input Parameters: 
% train   : Training data where rows represent instances and columns 
%           represents  features
% label   : Class label vector
% N       : Total Population of antlions and ants
% Max_iter: Maximum Iterations to search for solutions
% loutv   : Data partition for Validation 
%
% Output Parameters:
% GlobalBest: A structure with the information of best fitness value and
%             best solution
%             GlobalBest.Cost = Best Fitness
%             GlobalBest.Post = Best Solution
% ConCurve:   A vector of length equal to Max_iter which shows the
%             convergence of the algorithm
%
% If you use the code, please cite the paper:
%
% Dalwinder Singh and Birmohan Singh, "Effective and efficient classification of 
% gastrointestinal lesions: combining data preprocessing, feature weighting, and 
% improved ant lion optimization", Journal of Ambient Intelligence and Humanized 
% Computing, 2020.

function [GlobalBest,ConCurve]=IALO(train,label,N,Max_iter,loutv)
[~,dim]=size(train);
lb=zeros(dim,1);
lb(dim+1,1)=0.01;
lb(dim+2,1)=0.0001;
ub=ones(dim,1);
ub(dim+1,1)=35000;
ub(dim+2,1)=32;

antlion_position=init_svm(lb,ub,dim+2,N);

ant_position=zeros(N,dim+2);
Sorted_antlions=zeros(N,dim+2);
antlions_fitness=zeros(N,1);
ants_fitness=zeros(N,1);
ConCurve=zeros(Max_iter,1);

for i=1:N
    ntrain=calcweights(train,antlion_position(i,1:dim)',dim);
    if(size(ntrain,2)==0)
        err=1;
    else
        err=LOOV(ntrain,label,antlion_position(i,dim+1),antlion_position(i,dim+2),loutv);
    end
    antlions_fitness(i,1)=err;
end
[sorted_antlion_fitness,sorted_indexes]=sort(antlions_fitness);

for newindex=1:N
     Sorted_antlions(newindex,:)=antlion_position(sorted_indexes(newindex),:);
end
    
Elite_antlion_position=Sorted_antlions(1,:);
Elite_antlion_fitness=sorted_antlion_fitness(1);

ConCurve(1)=Elite_antlion_fitness;

Current_iter=2; 
while Current_iter<Max_iter+1
    for i=1:N
        R_idx=RWS(sorted_antlion_fitness);

        RA=RWalks(dim+2,Max_iter,lb,ub, Sorted_antlions(R_idx,:),Current_iter);
        RE=RWalks(dim+2,Max_iter,lb,ub, Elite_antlion_position(1,:),Current_iter);
        
        ant_position(i,:)=BLX(dim+2,RA(Current_iter,:),RE(Current_iter,:),lb,ub);
    end
    for i=1:N
        ntrain=calcweights(train,ant_position(i,1:dim)',dim);
        if(size(ntrain,2)==0)
            err=1;
        else
            err=LOOV(ntrain,label,ant_position(i,dim+1),ant_position(i,dim+2),loutv);
        end
        ants_fitness(i,1)=err;
    end
    double_population=[Sorted_antlions;ant_position];
    double_fitness=[sorted_antlion_fitness;ants_fitness];
    
    [double_fitness_sorted,I]=sort(double_fitness);
    double_sorted_population=double_population(I,:);
        
    sorted_antlion_fitness=double_fitness_sorted(1:N,1);
    Sorted_antlions=double_sorted_population(1:N,:);
        
    Elite_antlion_position=Sorted_antlions(1,:);
    Elite_antlion_fitness=sorted_antlion_fitness(1);
        
    ConCurve(Current_iter)=Elite_antlion_fitness;
    Current_iter=Current_iter+1;
end
GlobalBest.Cost=Elite_antlion_fitness;
GlobalBest.Post=Elite_antlion_position;
end