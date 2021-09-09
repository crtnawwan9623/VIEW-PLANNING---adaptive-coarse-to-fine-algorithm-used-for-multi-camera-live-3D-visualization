function vuqr=vuq(ui,q)
% ui=[0 0 20 0 0 0.0042];
% q=[0,0];

% ui=[0 0 6 0 0 2059];
% q=[0,0,0,0,0,1]
% ui=[0 0 13 0 0 2059];
% q=[10,0,0,0,0,1]
global Belta_R_T_g;
global Belta_SNR_T_g;
Belta_D_T=60; %25
Belta_D_F=1/60; %1/25
Belta_R_T=Belta_R_T_g; %0.0054
Belta_R_F=1/Belta_R_T; %
Belta_SNR_T=Belta_SNR_T_g; %6.1905
Belta_SNR_F=1/Belta_SNR_T; %

vD=exp(-Belta_D_F*max((Gama(ui,q)-Belta_D_T),0));
vR=exp(-Belta_R_F*max((1/px(ui,q)-Belta_R_T),0));
vSNR=exp(-Belta_SNR_F*max((1/sqrt(mu(ui,q))-Belta_SNR_T),0));

vuqr=vD*vR*vSNR;
%begin try to control the scene center in every image
% if inFov(ui,[5,0])==false
%     vuqr=0;
% end
%end try to control the scene center in every image
end