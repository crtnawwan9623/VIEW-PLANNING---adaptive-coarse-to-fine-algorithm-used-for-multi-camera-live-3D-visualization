global R_of_I;
im=imread('10.jpg');%curve drawn in paint
im=rgb2gray(im);%????
thresh = graythresh(im);%?????
im=im2bw(im,thresh);%???
set(0,'defaultfigurecolor','w')
imshow(im)%????
[y_region,x_region]=find(im==0);%??????“??”?????????????
y_region=max(y_region)-y_region;%????????????????
y_region=fliplr(y_region);%fliplr()——??????
plot(x_region,y_region,'r.','Markersize', 2);
axis equal
disp('choose two points: left-bottom and right-top. ');
[Xx,Yy]=ginput(2);%Xx,Yy——???????????

%y_range=abs(Yy(2)-Yy(1))/abs(Xx(2)-Xx(1))*16; %scale by locking the width-height ratio
min_x=0; %x:-15~15
max_x=15; %x:-15~15
min_y=-2; % -2 y: scale with x by the original ratio
max_y=2; % 2 y: scale with x by the original ratio

x_region=(x_region-Xx(1))*(max_x-min_x)/(Xx(2)-Xx(1))+min_x;
y_region=(y_region-Yy(1))*(max_y-min_y)/(Yy(2)-Yy(1))+min_y;
plot(x_region,y_region,'r.','Markersize', 2);
% axis([min_x,max_x,min_y,max_y])%??????????
axis([-20,20,-20,20])%??????????
axis equal
grid
title('Region of interest')
R_of_I=[];
hold on
for i=-50:50
    for j=-50:50
        if i<=max(x_region) && i>=min(x_region)
           [~,iidx]=min(abs(x_region-i));
           all_iidx=x_region==x_region(iidx);
           if j>=min(y_region(all_iidx)) && j<max(y_region(all_iidx))
               if mod(i,1)==0 && mod(j,1)==0
                   plot (i,j,'rx');
                   R_of_I=[R_of_I;i,j];
               end
               if i~=100 || j~=100
                   hold on;
               end
           end
        end
    end
end
    



