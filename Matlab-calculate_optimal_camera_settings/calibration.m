%automatically calibrate parameters for vuq.m
global Belta_R_T_g;
global Belta_SNR_T_g;
ui=[0 0 z_min 0 0 2059];
q=[0,0,0,0,0,1]


Belta_R_T_g=1/px(ui,q)% Belta_R_T
Belta_SNR_T_g=1/sqrt(mu(ui,q)) %Belta_SNR_T

ui=[0 0 z_max 0 0 2059];
q=[x_max,0,0,0,0,1]

Belta_R_T_g=(Belta_R_T_g+1/px(ui,q))/2
Belta_SNR_T_g=(Belta_SNR_T_g+1/sqrt(mu(ui,q)))/2