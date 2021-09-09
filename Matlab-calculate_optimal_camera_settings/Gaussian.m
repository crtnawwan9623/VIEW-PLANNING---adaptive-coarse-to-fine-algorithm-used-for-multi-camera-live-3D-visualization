function Gaussianr=Gaussian(v,w)
%calculate spherical gaussion,
%v,w is normalized vector
%w is central
%v is given direction
lamda=1;%1
Gaussianr=lamda/(2*pi*(1-exp(-2*lamda)))*exp(lamda*(dot(v,w)-1));
end
