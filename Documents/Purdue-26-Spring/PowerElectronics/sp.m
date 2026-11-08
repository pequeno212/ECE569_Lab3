%single phase (sp)

while t(k)< tend
      
    state = swch(duty,t(k));
    nextstate = swch(duty, t(k+1)) %1 if next is on, 0 if next is off;
    
    vAC(k + 1) = (2 * nextstate - 1) * vdc; %125 if 1
    iAC(k + 1) = (iAC(k) + timestep * vAC(k+1) / L) / (1 + timestep * r / L);

    if iAC(k + 1) > 0;
        %if AC current is high, T1 or D2 could be on (depends on state)
        iT1(k+1) = nextstate * iAC(k + 1);
        id2(k+1) = (1 - nextstate) * iAC(k + 1);
        
    
    else 
        %if AC current is low, D1 or T2 could be on (depends on state)
        id1(k+1) = nextstate * -1 * iAC(k + 1);
        iT2(k + 1) = (1 - nextstate) * -1 * iAC(k+1);

    end
        vsw1(k+1) = (vdc ) * (1 - nextstate);
        vsw2(k + 1) = vdc * nextstate;


    
    

    
    

    
    %update time step (delta t)
    k = k + 1;


end