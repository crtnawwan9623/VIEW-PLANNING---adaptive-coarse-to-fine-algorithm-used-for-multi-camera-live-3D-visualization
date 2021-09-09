function inFovr=inFov3D(ui,q)

%ui 6-vector (x,y,z,m,n,f)
% ui=[5,0,5,5,2,4.15/1000];
% %q=[5,0,-1,0,0,1,1];
% q=[5,0,1,0,0,1,43];

global R_of_I_3D;
dist_tol=0.5; % tolerance for block detection
q_loc=q(1:3);
q_normal=q(4:6);

v_qui=ui(1:3)-q_loc;  %vector q->ui

angle=acos(dot(q_normal,v_qui)/(norm(q_normal)*norm(v_qui)));
if angle>=pi/2
    inFovr=false;
    return;
end

xmax=max(ui(1),q_loc(1));
xmin=min(ui(1),q_loc(1));

ymax=max(ui(2),q_loc(2));
ymin=min(ui(2),q_loc(2));

zmax=max(ui(3),q_loc(3));
zmin=min(ui(3),q_loc(3));

Points_in_gap_log=R_of_I_3D(:,1)<=xmax & R_of_I_3D(:,1)>=xmin & R_of_I_3D(:,2)<=ymax & R_of_I_3D(:,2)>=ymin & R_of_I_3D(:,3)<=zmax & R_of_I_3D(:,3)>=zmin;
Points_in_gap=R_of_I_3D(Points_in_gap_log,:);

Q1=q_loc;
Q2=ui(1:3);
for i_F3D=1:size(Points_in_gap,1)
    P=Points_in_gap(i_F3D,1:3);
    d = norm(cross(Q2-Q1,P-Q1))/norm(Q2-Q1);
    if d<=dist_tol && all(Points_in_gap(i_F3D,1:6)~=q(1:6)) %blocked by other points
        inFovr=false;
        return;
    end
end

[q_z0(1,1),q_z0(1,2)]=Cal_line_z0_point(ui(1:3),q_loc);
inFovr=inFov(ui,q_z0);

%d = norm(cross(Q2-Q1,P-Q1))/norm(Q2-Q1);
%A(:,1)>=3 & A(:,1)<=5 & A(:,2)>=6 & A(:,2)<=7
end