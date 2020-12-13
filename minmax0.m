% Min-Max [0, 1] Normalization

function ntrain = minmax0( train )
[in,d]=size(train);
ntrain=zeros(in,d);
mn=min(train);
mx=max(train);
for j=1:d
    ntrain(:,j)=(train(:,j)-mn(j))/(mx(j)-mn(j));
end
end