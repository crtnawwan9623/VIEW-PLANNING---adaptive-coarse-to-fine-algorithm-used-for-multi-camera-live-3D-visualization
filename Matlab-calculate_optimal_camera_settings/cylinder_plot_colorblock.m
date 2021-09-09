%sample on a cylinder
%cylinder is placed on x-y plane horizontally
%length=c_xmax-c_xmin
%raditor=c_r;
% global R_of_I_3D;
% c_xmin=0;
% c_xmax=10;
% c_xdelta=1;
% 
% c_r=1;
% rad_delta=2*pi/100;%8 for calculation optimization, 100 for display
% 
% C_allpoints=[];
% C_allnormal=[];
% for c_x=c_xmin:c_xdelta:c_xmax
%     for rad=0:rad_delta:2*pi-rad_delta
%         c_y=c_r*cos(rad);
%         c_z=c_r*sin(rad)+c_r;
%         C_allpoints=[C_allpoints;c_x,c_y,c_z];
%         normal=[c_x,c_y,c_z]-[c_x,0,c_r];
%         normal=normal/norm(normal);
%         C_allnormal=[C_allnormal;normal];
%     end
% end
% 
% R_of_I_3D=zeros(size(C_allpoints,1),6);
% R_of_I_3D(:,1:3)=C_allpoints;
% R_of_I_3D(:,4:6)=C_allnormal;
% %R_of_I_3D(:,7)=1:1:size(C_allpoints,1); %as an index
% R_of_I_3D=roundn(R_of_I_3D,-4);
% plot3(C_allpoints(:,1),C_allpoints(:,2),C_allpoints(:,3),'.')
% %plot(C_allpoints(:,2),C_allpoints(:,3),'x')

global ThreeD;
ThreeD=1;%0: plane opt, use inFov; 1: 3D opt, use inFov3D;

R=[1 1]; 
N=30; 
[X,Y,Z] = cylinder(R,N); 
% c=ones(size(Z,1),size(Z,2),3);
% c1=c;
% c1(1,1,1)=0;
% c1(2,1,1)=0;
% c1(1,1,2)=0;
% c1(2,1,2)=0;
% 
% c1(1,2,2)=0;
% c1(2,2,2)=0;
% c1(1,2,3)=0;
% c1(2,2,3)=0;
q_Fov_all=[];
q_Info_all=[]; 

for c_d=0:1:9
    color=ones(size(Z,1),size(Z,2),3);
    %begin- sample around cylinder at c_x=c_d+0.5
    rad_delta=2*pi/30;
    C_allpoints=[];
    C_allnormal=[];
    c_x=c_d+0.5;
    c_r=1;
    for rad=0:rad_delta:2*pi-rad_delta
%         c_y=c_r*cos(rad);
%         c_z=c_r*sin(rad)+c_r;
        c_y=c_r*sin(rad);
        c_z=c_r*cos(rad)+c_r;
        C_allpoints=[C_allpoints;c_x,c_y,c_z];
        normal=[c_x,c_y,c_z]-[c_x,0,c_r];
        normal=normal/norm(normal);
        C_allnormal=[C_allnormal;normal];
   end
    R_of_I_3D_plot=zeros(size(C_allpoints,1),6);
    R_of_I_3D_plot(:,1:3)=C_allpoints;
    R_of_I_3D_plot(:,4:6)=C_allnormal;
    R_of_I_3D_plot=roundn(R_of_I_3D_plot,-4);
    %end- sample around cylinder at c_x=c_d+0.5
    
    %begin- calculate coverage and info of each sample and color

    for i=1:size(R_of_I_3D_plot,1)
        q=R_of_I_3D_plot(i,:); %each sample
        q_Info=IPUq(U,q);
        q_Info_all=[q_Info_all;q_Info]; %cal info
        %begin-calculate coverage 
        q_Fov=0;
        for j=1:size(U,1)
            ui=U(j,:);
            if inFov3D(ui,q)==true
            q_Fov=q_Fov+1;
            end
        end
        q_Fov_all=[q_Fov_all;q_Fov];
        %end-calculate coverage
        
        %begin- calculate color for each point
        if q_Fov==0 || q_Fov==1
           %plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'r.','markersize',10);
           color(1,i,2)=0; color(2,i,2)=0; color(1,i,3)=0; color(2,i,3)=0; 
        else
            if q_Info <= 0.3
                %plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'m.','markersize',10);
                color(1,i,2)=0; color(2,i,2)=0; 
            end
            if q_Info > 0.3 && q_Info <=0.6
                %plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'b.','markersize',10);
                color(1,i,1)=0; color(2,i,1)=0; color(1,i,2)=0; color(2,i,2)=0; 
            end
            if q_Info > 0.6
                %plot3 (R_of_I_3D_plot(i,1),R_of_I_3D_plot(i,2),R_of_I_3D_plot(i,3),'g.','markersize',10);
                color(1,i,1)=0; color(2,i,1)=0; color(1,i,3)=0; color(2,i,3)=0; 
            end
        end
        %end- calculate color for each point
    end
    
    color(:,31,:)=color(:,1,:);
    testsubject = surf(Z+c_d,Y,X+1,color); 
    set(testsubject,'FaceAlpha',0.5);
    set(gca,'DataAspectRatio', [1 1 1]);
    set(testsubject,'edgecolor',[0.5 0.5 0.5])
    hold on
end
