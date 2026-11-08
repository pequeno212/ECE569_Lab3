while t(k) < tend

    state = swch(duty,time)
    
    if(state)
        
        %indcuctor
        vL = vs - vout;
        iL = iL + vL/inductance * delta;


        %switch 1
        vsw1 = 0;
        isw1 = iL;
    
        %switch 2
        vsw2 = -vs;
        isw2 = 0;

        %cap
        ic = ic + ((i2 - i1)/(period * duty)) * delta;
        vc = vc + ic/capacitance * delta;
        

    else
    
         %indcuctor
        vL = -vout;
        iL = iL + vL/inductance * delta;


        %switch 1
        vsw1 = vs;
        isw = 0;
    
        %switch 2
        vsw2 = 0;
        isw2 = iL;

        %cap
        ic = ic - ((i2 - i1)/(period * (1-duty))) * delta;
        vc = vc + ic/capacitance * delta;
        
    
    end 

    t(k) = t(k) + delta;

end