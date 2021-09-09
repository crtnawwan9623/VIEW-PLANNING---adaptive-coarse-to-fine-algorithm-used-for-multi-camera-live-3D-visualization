global lamda_global;
lamda_group=[1,3,5,7,9,11,13,15,17];

for i_lmd=1:length(lamda_group)
    lamda_global=lamda_group(i_lmd);
    Coarse_grain;
    Fine_grain;
%     GA;
%     Random_algorithm;
    sol_Coa_g(i_lmd)=sol_Coa;
    sol_Fin_g(i_lmd)=sol_Fin;
%     sol_GA_g(i_lmd)=sol_GA;
%     sol_Random_g(i_lmd)=sol_Random;
    save('TotInfo_Lamda.mat');
end

plot(lamda_group,sol_Fin_g,'r','marker','o','markersize',8,'linewidth',1.5);
hold on
plot(lamda_group,sol_Coa_g,'b:','marker','d','markersize',8,'linewidth',1.5);
hold on
plot(lamda_group,sol_GA_g,'d:','marker','+','markersize',8,'linewidth',1.5);
hold on
plot(lamda_group,sol_Random_g,'k:','marker','s','markersize',8,'linewidth',1.5);
set(gca,'XTick',[1:2:17]);
xlim([1,17]);
set(gca,'FontSize',14);
xlabel('$\lambda$','interpreter','latex', 'FontSize', 14);
ylabel('Total information','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('Coarse-to-Fine Greedy','Original Greedy', 'Genetic Algorithm','Random');
set(leng1,'position',[0.173056175709159 0.690033885032238 0.367857134608286 0.203571422894796]);
grid