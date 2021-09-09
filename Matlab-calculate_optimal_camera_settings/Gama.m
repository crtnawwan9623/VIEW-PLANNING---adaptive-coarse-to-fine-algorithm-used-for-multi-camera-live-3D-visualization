function Gamar=Gama(ui,q)
% calculate Gama: angle between incident viewing ray qu and surface normal
% nq
%ui 6-vector (x,y,z,m,n,f)
global ThreeD;
if ThreeD==false 
    qui=ui(1:3)-[q,0];
else
    qui=ui(1:3)-q(1:3);   
end
Gamar=acos(dot(qui/norm(qui),nq(q)));
Gamar=rad2deg(Gamar);
end