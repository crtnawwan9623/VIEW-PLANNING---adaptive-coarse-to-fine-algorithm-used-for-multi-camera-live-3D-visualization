function mur=mu(ui,q)
%calculate mu
global ThreeD;
alpha_a=1;
alpha_d=0.5;
alpha_s=0.5;
alpha_sp=10;
I=1; %intensity of sun ray
s=[0,0,-1]; %direction sun ray
Kc=1.0;
Kl=0.35;
Kq=0.44;

if ThreeD==false 
    qui=ui(1:3)-[q,0];
else
    qui=ui(1:3)-q(1:3);   
end

normqui=norm(qui);
mur_a=alpha_a*I;
mur_d=alpha_d*I*max(dot(qui/normqui,nq(q)),0);
reflect=s-2*dot(nq(q),s)*nq(q);
mur_s=alpha_s*I*(max(dot(qui/normqui,reflect),0))^alpha_sp;

Fatt=1/(Kc+Kl*normqui+Kq*normqui^2);
mur=Fatt*(mur_a+mur_d+mur_s);
end