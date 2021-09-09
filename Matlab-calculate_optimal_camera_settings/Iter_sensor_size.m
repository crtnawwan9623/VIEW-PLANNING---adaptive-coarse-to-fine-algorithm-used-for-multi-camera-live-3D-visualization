global sensor_size;
sensor_group=[0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8]
%1.2,1.4,1.6,1.8];

for i_lmd=6:length(sensor_group)
    sensor_size=sensor_group(i_lmd);
    Coarse_grain;
    Fine_grain;
    GA;
    Random_algorithm;
    sol_Coa_g(i_lmd)=sol_Coa;
    sol_Fin_g(i_lmd)=sol_Fin;
    sol_GA_g(i_lmd)=sol_GA;
    sol_Random_g(i_lmd)=sol_Random;
    save('TotInfo_Sensor.mat');
end

plot(sensor_group,sol_Fin_g,'r','marker','o','markersize',8,'linewidth',1.5);
hold on
plot(sensor_group,sol_Coa_g,'b:','marker','d','markersize',8,'linewidth',1.5);
hold on
plot(sensor_group,sol_GA_g,'d:','marker','+','markersize',8,'linewidth',1.5);
hold on
plot(sensor_group,sol_Random_g,'k:','marker','s','markersize',8,'linewidth',1.5);

set(gca,'XTick',[0.2:0.2:1.8]);
xlim([0.2,1.8]);
set(gca,'FontSize',14);
xlabel('(Relative) Sensor size','fontsize',14);
ylabel('Total information','fontsize',14);
set(gca,'Fontname','times new Roman');
leng1=legend('Coarse-to-Fine Greedy','Original Greedy', 'Genetic Algorithm','Random');
set(leng1,'position',[0.515913318566302 0.156700551698905 0.367857134608286 0.203571422894796]);
grid