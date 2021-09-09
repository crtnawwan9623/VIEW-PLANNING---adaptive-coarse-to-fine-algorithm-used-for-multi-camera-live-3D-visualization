%json written
% x=[1 2 3 4];
% y=[5 6 7 8];
% fp=fopen('C.json','a');
% fprintf(fp,'%d,%d,%d,%d\r\n',x);%???\r\n????????windows??????
% fprintf(fp,'%d,%d,%d,%d\r\n',y);
% fclose(fp);
%
% location=[-11.622,69.022,126.405];%y,x,z
% rotation=[72.858,0.0,345.077];%yaw,roll,pitch

%U_json=[12.5,0,10,0,5,2950;12.5,0,10,25,0,2950];
U_json=U;
fp=fopen('C.json','w');
fprintf(fp,'%c\r\n','[');

for i=1:size(U_json,1)
    u=U_json(i,:);
    [Position_unreal,Rotation_unreal]=utounrealcv(u);
    fprintf(fp,'\t%c\r\n','[');
    fprintf(fp,'\t\t%c\r\n','{');
    fprintf(fp,'\t\t\t%s%.1f%c\r\n','"y": ',Position_unreal(2),',');
    fprintf(fp,'\t\t\t%s%.1f%c\r\n','"x": ',Position_unreal(1),',');
    fprintf(fp,'\t\t\t%s%.1f\r\n','"z": ',Position_unreal(3));
    fprintf(fp,'\t\t%s\r\n','},');
    fprintf(fp,'\t\t%c\r\n','{');
    fprintf(fp,'\t\t\t%s%.1f%c\r\n','"yaw": ',Rotation_unreal(2),',');
    fprintf(fp,'\t\t\t%s%.1f%c\r\n','"roll": ',Rotation_unreal(3),',');
    fprintf(fp,'\t\t\t%s%.1f\r\n','"pitch": ',Rotation_unreal(1));
    fprintf(fp,'\t\t%s\r\n','}');
    if i~=size(U_json,1)
        fprintf(fp,'\t%s\r\n','],');
    else
        fprintf(fp,'\t%s\r\n',']');
    end 
end
fprintf(fp,'%c\r\n',']');
fclose(fp);