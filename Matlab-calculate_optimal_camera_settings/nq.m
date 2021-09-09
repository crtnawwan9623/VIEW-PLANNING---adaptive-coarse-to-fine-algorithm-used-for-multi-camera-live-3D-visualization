function nqr=nq(q)
%calculate the surface normal at point q
global ThreeD;
if ThreeD==false 
    nqr=[0,0,1];
else
    nqr=q(4:6);  
end

end