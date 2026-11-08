%sin triangle (st)
%more or less same as sp.m

nextstate = 0;
k = 1;
while t(k)< tend

    
    if(duty(k+1) > triangle(k+1))
        nextstate = 1;
    else
        nextstate = 0;
    end
    
   
    vAC(k + 1) = (2 * nextstate - 1) * vdc;
    iAC(k + 1) = (iAC(k) + timestep * vAC(k+1) / L) / (1 + timestep * r / L);
    

    vsw1(k+1) = (vdc ) * (1 - nextstate);
    

    if iAC(k + 1) > 0;
        iT1(k+1) = nextstate * iAC(k + 1);
        id2(k+1) = (1 - nextstate) * iAC(k + 1);
    
    else 
        id1(k+1) = nextstate * -1 * iAC(k + 1);
        iT2(k + 1) = (1 - nextstate) * -1 * iAC(k+1);
    end
    
    k = k + 1;


end