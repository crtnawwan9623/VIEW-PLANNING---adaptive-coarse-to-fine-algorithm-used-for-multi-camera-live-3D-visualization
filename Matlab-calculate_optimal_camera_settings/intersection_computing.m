function [sec,exist] = intersection_computing(sam,sam_u,dat,dat_a)
    % calculate intersection between line and plane
    % sam: point on the line?sam_u: vector of the line,
    % dat: point on the plane?dat_a: normal of the plane
    sx = sam(1);
    sy = sam(2);
    sz = sam(3);
    ux = sam_u(1);
    uy = sam_u(2);
    uz = sam_u(3);
    dx = dat(1);
    dy = dat(2);
    dz = dat(3);
    ax = dat_a(1);
    ay = dat_a(2);
    az = dat_a(3);
    F = ax*ux+ay*uy+az*uz;
    if F ~= 0
       sec(1,1) = (sx*(ay*uy+az*uz)+ux*(ax*dx+ay*(dy-sy)+az*(dz-sz)))/F;
       sec(1,2) = (sy*(ax*ux+az*uz)+uy*(ay*dy+ax*(dx-sx)+az*(dz-sz)))/F;
       sec(1,3) = (sz*(ax*ux+ay*uy)+uz*(az*dz+ax*(dx-sx)+ay*(dy-sy)))/F;
       exist=true;
    else
       fprintf('plane and line are parallel, no intersection');
       sec=[0,0,0];
       exist=false;
       return;
    end
end