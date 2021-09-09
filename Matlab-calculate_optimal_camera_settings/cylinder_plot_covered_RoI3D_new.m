global ThreeD;
ThreeD=1;%0: plane opt, use inFov; 1: 3D opt, use inFov3D;

%begin- sample on a cylinder
%cylinder is placed on x-y plane horizontally
%length=c_xmax-c_xmin
%raditor=c_r;
c_xmin=0.5;
c_xmax=9.5;
c_xdelta=1;

c_r=1;
rad_delta=2*pi/100; %8 for calculation optimization, 100 for display

C_allpoints=[];
C_allnormal=[];
for c_x=c_xmin:c_xdelta:c_xmax
    for rad=0:rad_delta:2*pi-rad_delta
        c_y=c_r*cos(rad);
        c_z=c_r*sin(rad)+c_r;
        C_allpoints=[C_allpoints;c_x,c_y,c_z];
        normal=[c_x,c_y,c_z]-[c_x,0,c_r];
        normal=normal/norm(normal);
        C_allnormal=[C_allnormal;normal];
    end
end

R_of_I_3D_plot=zeros(size(C_allpoints,1),6);
R_of_I_3D_plot(:,1:3)=C_allpoints;
R_of_I_3D_plot(:,4:6)=C_allnormal;
R_of_I_3D_plot=roundn(R_of_I_3D_plot,-4);

%end- sample on a cylinder


%begin- calculate information gain and the number of covered FOV of each point on cylinder
q_Fov_all=[];
q_Info_all=[]; 
for i=1:size(R_of_I_3D_plot,1)
    q=R_of_I_3D_plot(i,:);
    q_Info_all=[q_Info_all;IPUq(U,q)];
    q_Fov=0;
    for j=1:size(U,1)
        ui=U(j,:);
        if inFov3D(ui,q)==true
        q_Fov=q_Fov+1;
        end
    end
    q_Fov_all=[q_Fov_all;q_Fov];
end
%end- calculate the number of covered FOV of each point on cylinder

%begin- draw cylinder
R=[1 1]; 
N=30; 
[X,Y,Z] = cylinder(R,N); 
c=ones(size(Z,1),size(Z,2),3);
testsubject = surf(Z*10,Y,X+1,c); 
set(testsubject,'FaceAlpha',0.5);
set(gca,'DataAspectRatio', [1 1 1]);
set(testsubject,'edgecolor',[0.5 0.5 0.5])
hold on

%to create legend:
h1=plot3 (R_of_I_3D_plot(1,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'r.','markersize',20);
h2=plot3 (R_of_I_3D_plot(1,1),R_of_I_3D_plot(1,2),R_of_I_3D_plot(1,3),'m.','markersize',20);
h3=plot3 (R_of_I_3D_plot(1,1),R_of_I_3D_plot(1,2),R_of_I_3D_plot(1,3),'b.','markersize',20);
h4=plot3 (R_of_I_3D_plot(1,1),R_of_I_3D_plot(1,2),R_of_I_3D_plot(1,3),'g.','markersize',20);

for i=1:size(R_of_I_3D_plot,1)
    if q_Fov_all(i)==0 || q_Fov_all(i)==1
            plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'r.','markersize',10);
    else
        if q_Info_all(i) <= 0.3
            plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'m.','markersize',10);
        end
        if q_Info_all(i) > 0.3 && q_Info_all(i) <=0.6
            plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'b.','markersize',10);
        end
        if q_Info_all(i) > 0.6
            plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'g.','markersize',10);
        end
    end
    hold on
end
xlabel('x','fontsize',14);
ylabel('y','fontsize',14);
zlabel('z','fontsize',14);
set(gca,'FontSize',14);
set(gca,'Fontname','times new Roman');
legend1=legend([h1,h2,h3,h4],'Invisible','Low quality','Medium quality','High quality');
set(legend1,...
    'Position',[0.112758694985662 0.647023812362126 0.287241305014338 0.203571422894796]);
%set(legend1,'Orientation','horizon');
%end- draw cylinder