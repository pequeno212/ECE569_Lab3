%three phase (threep)

while t(k)< tend
      
    %leg a voltage (vag)
    if(da(k+1) > triangle(k+1))
        nextstate_a = 1;
    else
        nextstate_a = 0;
    end
    vag(k + 1) = (2 * nextstate_a - 1) * vdc;

    %legb
    if(db(k+1) > triangle(k+1))
        nextstate_b = 1;
    else
        nextstate_b = 0;
    end
    vbg(k + 1) = (2 * nextstate_b - 1) * vdc;

    %legc
    if(dc(k+1) > triangle(k+1))
        nextstate_c = 1;
    else
        nextstate_c = 0;
    end
    vcg(k + 1) = (2 * nextstate_c - 1) * vdc;

    %vas,vbs,vcs
    vas(k + 1) = 2/3 * vag(k + 1) - 1/3 * vcg(k + 1) - 1/3 * vbg(k + 1);
    vbs(k + 1) = 2/3 * vbg(k + 1) - 1/3 * vcg(k + 1) - 1/3 * vag(k + 1);
    vcs(k + 1) = 2/3 * vcg(k + 1) - 1/3 * vag(k + 1) - 1/3 * vbg(k + 1);
    
    %ias, ibs, ics
    ias(k + 1) = (ias(k) + timestep * vas(k+1) / L) / (1 + timestep * r / L);
    ibs(k + 1) = (ibs(k) + timestep * vbs(k+1) / L) / (1 + timestep * r / L);
    ics(k + 1) = (ics(k) + timestep * vcs(k+1) / L) / (1 + timestep * r / L);
    

    vsw1(k+1) = (vdc ) * (1 - nextstate_a);
    
    %currents/voltages for leg A
    if ias(k + 1) > 0;
        %
        iT1(k+1) = nextstate_a * ias(k + 1);
        id4(k+1) = (1 - nextstate_a) * ias(k + 1);
        
    
    else 
        id1(k+1) = nextstate_a * -1 * ias(k + 1);
        iT4(k + 1) = (1 - nextstate_a) * -1 * ias(k+1);
    end

    %currents for leg B
    if ibs(k + 1) > 0;
        iT2(k+1) = nextstate_b * ibs(k + 1);
        id5(k+1) = (1 - nextstate_b) * ibs(k + 1);
    
    else 
        id2(k+1) = nextstate_b * -1 * ibs(k + 1);
        iT5(k + 1) = (1 - nextstate_b) * -1 * ibs(k+1);
    end

     %currents for leg C
    if ics(k + 1) > 0;
        iT3(k+1) = nextstate_c * ics(k + 1);
        id6(k+1) = (1 - nextstate_c) * ics(k + 1);
    
    else 
        id3(k+1) = nextstate_c * -1 * ics(k + 1);
        iT6(k + 1) = (1 - nextstate_c) * -1 * ics(k+1);
    end


  

    k = k + 1;

end