% This function provides the subset of features based on Light source (NBI and WL)
% and feature types (Texture, Color and Shape).

function train=get_comb(Ntrain,Wtrain,Num)
if(Num==1)
    train=Wtrain(:,1:202);                          % White Light - Texture Features
elseif(Num==2)
    train=Wtrain(:,203:266);                        % White Light - Color Features
elseif(Num==3)
    train=Ntrain(:,1:202);                          % NBI Light - Texture Features
elseif(Num==4)
    train=Ntrain(:,203:265);                        % NBI Light - Color Features
elseif(Num==5)
    train=[Ntrain(:,1:202),Wtrain(:,1:202)];        % White & NBI Light - Texture Features
elseif(Num==6)
    train=[Ntrain(:,203:265),Wtrain(:,203:266)];    % White & NBI Light - Color Features
elseif(Num==7)
    train=Wtrain(:,1:266);                          % White Light - Texture & Color Features
elseif(Num==8)
    train=Ntrain(:,1:265);                          % NBI Light - Texture & Color Features
elseif(Num==9)
    train=[Ntrain(:,1:265),Wtrain(:,1:266);];       % White & NBI Light - Texture & Color Features
elseif(Num==10)
    train=[Wtrain(:,1:202),Wtrain(:,267:465)];      % White Light - Texture & Shape Features
elseif(Num==11)
    train=[Wtrain(:,203:266),Wtrain(:,267:465)];    % White Light - Color & Shape Features
elseif(Num==12)
    train=[Ntrain(:,1:202),Ntrain(:,266:464)];      % NBI Light - Texture & Shape Features
elseif(Num==13)
    train=[Ntrain(:,203:265),Ntrain(:,266:464)];    % NBI Light - Color & Shape Features
elseif(Num==14)
    train=[Ntrain(:,1:202),Wtrain(:,1:202),Ntrain(:,266:464)]; % White & NBI Light - Texture & Shape Features
elseif(Num==15)
    train=[Ntrain(:,203:265),Wtrain(:,203:266),Ntrain(:,266:464)];  % White & NBI Light - Color & Shape Features
elseif(Num==16)
    train=Wtrain;                                    % White Light - Texture, Color & Shape Features
elseif(Num==17)
    train=Ntrain;                                    % NBI Light - Texture, Color & Shape Features
elseif(Num==18)
    train=[Ntrain(:,1:265),Wtrain];                  % White & NBI Light - Texture, Color & Shape Features
elseif(Num==19)
    train=Ntrain(:,266:464);                         % White & NBI Light - Shape Features
end