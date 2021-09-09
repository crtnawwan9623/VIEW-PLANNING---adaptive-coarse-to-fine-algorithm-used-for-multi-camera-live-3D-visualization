%calculate the number of covered FOV of each point 
q_Fov_all=[];
for i=1:size(R_of_I,1)
    q=R_of_I(i,:);
    q_Fov=0;
    for j=1:size(U,1)
        ui=U(j,:);
        if inFov(ui,q)==true
        q_Fov=q_Fov+1;
        end
    end
    q_Fov_all=[q_Fov_all;q_Fov];
end

%plot points with different color according to their number of covered FOV 
plot(x_region,y_region,'r.','Markersize', 2);
axis([-10,10,-10,10])
grid
title('Region of interest');
hold on
for i=1:size(R_of_I,1)
    if q_Fov_all(i)>=3
       plot (R_of_I(i,1),R_of_I(i,2),'kx','markersize',10);
    end
    if q_Fov_all(i)==2
       plot (R_of_I(i,1),R_of_I(i,2),'bx','markersize',10);
    end
    if q_Fov_all(i)==0 || q_Fov_all(i)==1
       plot (R_of_I(i,1),R_of_I(i,2),'rx','markersize',10);
    end 
    hold on
end  
set(gca,'FontSize',18);