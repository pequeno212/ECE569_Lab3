while t(k)< tend
      
    state = swch(duty,t(k));
    nextstate = swch(duty, t(k+1));

    iAC(k + 1) = (iAC(k) + timestep * (nextstate * vdc) * ((1-nextstate) * -vdc))/(L * (1 + timestep * r / L));
    
    %update time step (delta t)
    t(k) = t(k) + timestep;
    k = k + 1;


end