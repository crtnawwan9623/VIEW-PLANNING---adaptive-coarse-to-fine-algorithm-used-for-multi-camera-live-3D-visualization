function IUr=IU(U)
global ThreeD;
global R_of_I;
global R_of_I_3D;
%calculate the total information for all Region of Interests from the
%camera group 
% U=[0,0,10,0,0,0.05;
%    5,-10,10,0,0,0.05;
%    -5,15,10,1,3,0.05;
%    0,-10,-20,0,-8,0.05;];

IU=0;
if ThreeD==false 
    for i=1:size(R_of_I,1)
        q=R_of_I(i,:);
        IU=IU+IPUq(U,q);
    end
else
    for i=1:size(R_of_I_3D,1)
        q=R_of_I_3D(i,:);
        IU=IU+IPUq(U,q);
    end
end
IUr=IU;
end


