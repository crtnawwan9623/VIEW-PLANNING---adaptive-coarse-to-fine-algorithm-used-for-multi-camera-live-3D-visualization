global R_of_I;
U_fine=[];
List_fine=[];
for i=1:size(U,1)
    for x=(U(i,1)-2):1:(U(i,1)+2) % -4 2 +4
        for y=(U(i,2)-2):1:(U(i,2)+2) % -4 2 +4
            for z=(U(i,3)-1):1:(U(i,3)+1)
                for dd=1:size(R_of_I,1)
                    if all(U(i,4:5)==R_of_I(dd,:))
                        break;
                    end
                end
                if dd-2>=1
                    d_min=dd-2;
                else
                    d_min=1;
                end
                if dd+2<=size(R_of_I,1)
                    d_max=dd+2;
                else
                    d_max=size(R_of_I,1);
                end
                for d=d_min:2:d_max
                   %for f=U(i,6)*1000-10:10:U(i,6)*1000+10 %iphone6s does not change focal length
                        f=4.15; %focal length(mm) of iphone 6s
                        u=[x,y,z,R_of_I(d,:),f/1000];
                        List_fine=[List_fine;u,IU(u)];
                        i,x,y                   
                    %end %iphone6s does not change focal length
                end
            end
        end
    end
end

%set up u1
List_fine=sortrows(List_fine,-7);
for i=1:size(List_fine,1)
    if List_fine(i,6)*1000>=Focal_range(1,1) && List_fine(i,6)*1000<=Focal_range(1,2)
        U_fine=List_fine(i,1:6);
        List_fine=RemoveSamePostion(List_fine,i);
        break;
    end
end

for j=2:num_U
    i=1;
    while i<size(List_fine,1)
        if  List_fine(i,6)*1000>=Focal_range(j,1) && List_fine(i,6)*1000<=Focal_range(j,2)
            u=List_fine(i,1:6);
            List_fine(i,7)=IU([U_fine;u])-IU(U_fine);
            List_fine=sortrows(List_fine,-7);
            for k=i:size(List_fine,1)
                if List_fine(k,6)*1000>=Focal_range(j,1) && List_fine(k,6)*1000<=Focal_range(j,2)
                    break;
                end
            end
            if all(u==List_fine(k,1:6))
                U_fine=[U_fine;u];
                List_fine=RemoveSamePostion(List_fine,k);
                break;
            end
        else
            i=i+1;
        end
    end
    j,i
end
for i=1:size(U_fine,1)
    U_temp=U_fine(1:i,:);
    IU_growth_fine(i)=IU(U_temp);
end
plot(1:size(U,1),IU_growth,'r','marker','o','markersize',8,'linewidth',1.5);
hold on
plot(1:size(U_fine,1),IU_growth_fine,'b:','marker','d','markersize',8,'linewidth',1.5);
set(gca,'XTick',[1:1:10]);
xlim([1,10]);
set(gca,'FontSize',14);
xlabel('Number of UAV','fontsize',14);
ylabel('Total information','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('Coarse-grained','Fine-grained');
set(leng1,'position',[0.185119053100546 0.752777780616094 0.274999994518502 0.105952378114064]);
grid