function pxr=px(ui,q)
%calculate px: the length (number of pixels) that a unit length of q stretches when
%projected onto the camera's image plance with focal length f
%ui 6-vector (x,y,z,m,n,f)
global ThreeD;
if ThreeD==false 
    qui=ui(1:3)-[q,0];
else
    qui=ui(1:3)-q(1:3);   
end

pxr=ui(6)/norm(qui);
% pxr=(ui(6)/norm(qui))^2;
% camera_pix_per_unitarea=1.69*10^7/(23.6*0.001*15.6*0.001);
% pxr=pxr*camera_pix_per_unitarea;
end