while t(k) < tend 

    state = swch(duty,t(k));
        
   %inductor current
    vs = 48;

   

    %{

    %IDEAL
    origval = [iL(k); vLoad(k)];
    mult = [(timestep * state * vS / inductance); 0];
    A = [1,(timestep / inductance); (- timestep / capacitance), (1 + timestep / (rLoad * capacitance))];
    newval = inv(A) * (origval + mult);
    iL(k + 1) = newval(1);

    %}

    %NONIDEAL
    origval = [iL(k) / (1 + timestep * rTon/ inductance) ; vLoad(k)];
    mult = [(timestep * state * vS / inductance)/ (1 + timestep * rTon/ inductance); 0];
    A = [1,(timestep / inductance); (- timestep / capacitance), (1 + timestep / (rLoad * capacitance))];
    newval = inv(A) * (origval + mult);
    iL(k + 1) = newval(1);

    if(iL(k + 1) < 0)
        iL(k + 1) = 0;
    end

    vLoad(k + 1) = newval(2);

          
    %cap 
    vC(k + 1) = vLoad(k + 1);
    iC(k + 1) = iL(k + 1) - vLoad(k+1)/rLoad;

    %inductor voltage
    vL(k + 1) = (vs - vLoad(k + 1)) * state - (vLoad(k + 1)) * (1 - state);
    

    %switch 1
    vsw1(k + 1) = vs *  (1 - state);
    isw1(k + 1) = (state) * iL(k + 1);

    %switch 2
    vsw2(k + 1) = -vs * ( state );
    isw2(k + 1) = iL(k + 1) * (1 - state);

    %update time step (delta t)
    t(k) = t(k) + timestep;
    k = k + 1;

end