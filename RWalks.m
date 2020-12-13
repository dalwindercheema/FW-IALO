function RWs=RWalks(dim,max_iter,lb,ub,antlion,current_iter)
I=1;
rt=current_iter/max_iter;

if current_iter>max_iter*0.20
    I=1+1*rt;
end
if current_iter>max_iter*0.50
    I=1+5*rt;
end
if current_iter>max_iter*0.75
    I=1+10*rt;
end
if current_iter>max_iter*0.90
    I=1+20*rt;
end

lb=lb'/I;
ub=ub'/I;

if rand<0.5
    lb=lb+antlion;
else
    lb=-lb+antlion;
end

if rand>=0.5
    ub=ub+antlion;
else
    ub=-ub+antlion;
end

RWs=zeros(max_iter+1,dim);
for i=1:dim
    X = [0 cumsum(2*(rand(max_iter,1)>0.5)-1)'];
    a=min(X);
    b=max(X);
    c=lb(i);
    d=ub(i);
    RWs(:,i)=((X-a).*(d-c))./(b-a)+c;
end