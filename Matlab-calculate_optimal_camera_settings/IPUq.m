function IPUqr=IPUq(U,q)
%cauclate IPUq: total information of q from camera group U
% U=[0,0,10,0,0,0.05;
%    5,5,10,0,0,0.05;
%    3,3,10,1,3,0.05;];
% q=[2,2];
global ThreeD;
N=20;% divide the hemisphere into 20 parts
v=zeros(1,3);
Fan=(sqrt(5)-1)/2;
sum_maxvG=0;
for n=1:N
    v(3)=1-(2*n-1)/(2*N);
    v(1)=sqrt(1-v(3)^2)*cos(2*pi*n*Fan);
    v(2)=sqrt(1-v(3)^2)*sin(2*pi*n*Fan);
    max_vG=0;
    for i=1:size(U,1)
        ui=U(i,:);
        if ThreeD==false  
            if inFov(ui,q)==true
                qui=ui(1:3)-[q,0];
                qui=qui/norm(qui);
                vG=vuq(ui,q)*Gaussian(v,qui);
                if vG>max_vG
                    max_vG=vG;
                end
            end
        else
            if inFov3D(ui,q)==true
                qui=ui(1:3)-q(1:3);
                qui=qui/norm(qui);
                vG=vuq(ui,q)*Gaussian(v,qui);
                if vG>max_vG
                    max_vG=vG;
                end
            end
        end
    end
    sum_maxvG=sum_maxvG+max_vG;
end

IPUqr=sum_maxvG*2*pi/N;
end

