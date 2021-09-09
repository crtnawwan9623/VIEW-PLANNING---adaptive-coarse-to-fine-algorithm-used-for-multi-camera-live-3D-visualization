function inFovr=inFov(ui,q)
sensor_size_x=23.6e-3;%default for my Nikon
sensor_size_y=15.6e-3;%default for my Nikon
sensor_size_x=3.67e-3;%for iphone 6s
sensor_size_y=4.89e-3;%for iphone 6s
%ui 6-vector (x,y,z,m,n,f)
Theta(1)=atan(sensor_size_x/(2*ui(6))) ;%x-dimention
Theta(2)=atan(sensor_size_y/(2*ui(6))) ;%x-dimention

%begin for virtual camera
Theta(1)=25/180*pi;
Theta(2)=25/180*pi;
%end for virtual camera

if ui(1)==ui(4) && ui(2)==ui(5)
    d=ui(4:5);
    if abs(q(1)-d(1))/ui(3)<=tan(Theta(1)) && abs(q(2)-d(2))/ui(3)<=tan(Theta(2))
        inFovr=true; %in FOV
    else 
        inFovr=false; %not in FOV
    end
else
    v_uiq=[q,0]-ui(1:3);  %vector ui->q
    v_uiq=v_uiq/norm(v_uiq);

    d=ui(4:5);
    v_dui=ui(1:3)-[d,0];  %vector d->ui
    v_dui=v_dui/norm(v_dui);
    [q_bar,exist]=intersection_computing(ui(1:3),v_uiq,[d,0],v_dui); %intersection between line(pass ui with directio uiq) and plane(pass d with normal dui)
    if exist==false % no intersection
        inFovr=false; %not in FOV
        return;
    end
    v_dqbar=q_bar-[d,0]; %vector d->q_bar
    [x_bar,y_bar]=x_y_bar(ui); %local x_axis and y_axis in global coordinate system
    if abs(dot(v_dqbar,x_bar))/ui(3)<=tan(Theta(1)) && abs(dot(v_dqbar,y_bar))/ui(3)<=tan(Theta(2))
        inFovr=true; %in FOV
    else 
        inFovr=false; %not in FOV
    end
end
end