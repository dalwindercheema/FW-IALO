% This function initialize the population within the predefined upper and 
% lower bounds

function pos = init_svm(lb,ub,dim,N)
pos=zeros(N,dim);
for i=1:dim
    pos(:,i)=unifrnd(lb(i),ub(i),[N,1]);
end
end