global R_of_I;
global ThreeD;
ThreeD=1;%0: plane opt; 1: 3D opt;

%configure focal length range
num_U=10;
U=[];
Focal_range=ones(num_U,2); %f_i_min,f_i_max
% Focal_range(:,1)=20*Focal_range(:,1); %f_i_min mm
% Focal_range(:,2)=100*Focal_range(:,2); %f_i_max mm
% Focal_range=ones(num_U,2)*4.15; %for iphone 6s
%focal length for virtual camera: imageWidth /(2 * tan(CameraFOV * ? / 360))
%i.e., 1920 /(2 * tan(50 * pi / 360))=2059 [pixels]
Focal_range=ones(num_U,2)*2059*1000; %for iphone 6s


x_min=-15;%
x_max=30; %
x_step=5; %3
y_min=-10; %
y_max=10; %
y_step=2; %2
z_min=3; % 
z_max=15; %
z_step=3;
calibration; % vuq is calibrated
L=[];
for x=x_min:x_step:x_max %4
    for y=y_min:y_step:y_max %4
        for z=z_min:z_step:z_max  %1
            L=[L;x,y,z];
        end
    end
end


d_step=3;
%configure D
D=R_of_I(round(d_step/2):d_step:end,:); %1:d_step:end


List=[];
for l=1:size(L,1)
    for d=1:size(D,1)
        for f=min(Focal_range(:,1)):30: max(Focal_range(:,2))
            u=[L(l,:),D(d,:),f/1000]; % mm->m
            %begin try to control the scene center in every image
            if inFov(u,[15,1])==true && inFov(u,[0,1])==true && inFov(u,[15,-1])==true && inFov(u,[0,-1])==true            
                List=[List;u,IU(u)]; %key->u, value->IU(u)
            end
            %end try to control the 
            l
            d
        end
    end
end     

%set up u1
List=sortrows(List,-7);
for i_cg=1:size(List,1)
    if List(i_cg,6)*1000>=Focal_range(1,1) && List(i_cg,6)*1000<=Focal_range(1,2)
        U=List(i_cg,1:6);
        List=RemoveSamePostion(List,i_cg);
        break;
    end
end

for j_cg=2:num_U
    i_cg=1;
    while i_cg<size(List,1)
        if  List(i_cg,6)*1000>=Focal_range(j_cg,1) && List(i_cg,6)*1000<=Focal_range(j_cg,2)
            u=List(i_cg,1:6);
            List(i_cg,7)=IU([U;u])-IU(U);
            List=sortrows(List,-7);
            for k=i_cg:size(List,1)
                if List(k,6)*1000>=Focal_range(j_cg,1) && List(k,6)*1000<=Focal_range(j_cg,2)
                    break;
                end
            end
            if all(u==List(k,1:6))
                U=[U;u];
                List=RemoveSamePostion(List,k); %remove already deployed point from List
                break;
            end
        else
            i_cg=i_cg+1;
        end
    end
    j_cg,i_cg
end

for i_cg=1:size(U,1)
    U_temp=U(1:i_cg,:);
    IU_growth(i_cg)=IU(U_temp);
end
plot(1:size(U,1),IU_growth);



