function [x_z0,y_z0]=Cal_line_z0_point(p1,p2)
%calculate the z=0 point on a line passing two points p1 and p2

% k=0:0.01:1;
% p1=[0,0.1,0.2];
% p2=[0.3,0.5,0.7];
% x=p1(1)+k*(p2(1)-p1(1));
% y=p1(2)+k*(p2(2)-p1(2));
% z=p1(3)+k*(p2(3)-p1(3));
% plot3(x,y,z)

k=(0-p1(3))/(p2(3)-p1(3));
x_z0=p1(1)+k*(p2(1)-p1(1));
y_z0=p1(2)+k*(p2(2)-p1(2));

end