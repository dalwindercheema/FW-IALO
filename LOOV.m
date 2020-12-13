% This function evaluates the data using Leave-one-out validation procedure
% on SVM - RBF classifier.

function err = LOOV(train,label,Cval,gamma,cvt)
pred=zeros(size(label));
for m=1:cvt.NumTestSets
    tmp=cvt.test(m);
    idx=find(tmp);
    ntrain=train(~tmp,:);
    ntrain_label=label(~tmp,:);
    ntest=train(idx,:);
    ntest_label=label(idx,1);
    opt=['-s 0 -t 2 -c ',num2str(Cval),' -g ',num2str(gamma),' -q'];
    model=svmtrain(ntrain_label,ntrain,opt);
    [pred_l,~,~]=svmpredict(ntest_label,ntest,model,'-q');
    pred(idx,1)=pred_l;
end
classi=length(find(pred==label));
err=1-(classi/length(label));
end