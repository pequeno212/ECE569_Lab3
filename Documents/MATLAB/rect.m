%three phase rectifier (rect)

ia = zeros(size(t));
ib = zeros(size(t));
ic = zeros(size(t));

while t(k) < tend
    
    %input voltages
    ea(k + 1) = amplitude * cos(t(k) * ac_w);
    eb(k + 1) = amplitude * cos(t(k) * ac_w - 2 * pi / 3);
    ec(k + 1) = amplitude * cos(t(k) * ac_w + 2 * pi / 3);

    vdc_prime(k + 1) = dc_L/ tau * iDC(k) + stuff(k);

    %figuring out ia, id1, and vag
    ia(k + 1) = ia(k) + timestep * (ea(k) - va(k))/ac_L;
    if ia(k + 1) > 0
        id1(k + 1) = ia(k + 1);
    else 
        id1(k + 1) = 0;
    end

    if ia(k + 1) > epsilon
        vag(k + 1) = vdc_prime(k + 1);
    elseif ia(k + 1) < - epsilon
        vag(k +1) = 0;
    else
        vag(k + 1) = vdc_prime(k + 1) * ia(k) / (2 * epsilon) + vdc_prime(k + 1)/2;
    end

    %figuring out ib, id3, and vbg
    ib(k + 1) = ib(k) + timestep * (eb(k) - vb(k))/ac_L;
    if ib(k + 1) > 0
        id3(k + 1) = ib(k + 1);
    else 
        id3(k + 1) = 0;
    end

    if ib(k + 1) > epsilon
        vbg(k + 1) = vdc_prime(k + 1);
    elseif ib(k + 1) < - epsilon
        vbg(k + 1) = 0;
    else
        vbg(k + 1) = vdc_prime(k + 1) * ib(k) / (2 * epsilon) + vdc_prime(k + 1)/2;
    end

    %figuring out ic, id5, and vcg
    ic(k + 1) = ic(k) + timestep * (ec(k) - vc(k))/ac_L;
    if ic(k + 1) > 0
        id5(k + 1) = ic(k + 1);
    else 
        id5(k + 1) = 0;
    end

    if ic(k + 1) > epsilon
       vcg(k +1) = vdc_prime(k + 1);
    elseif ic(k + 1) < - epsilon
        vcg(k +1) = 0;
    else
        vcg(k + 1) = vdc_prime(k + 1) * ic(k) / (2 * epsilon) + vdc_prime(k + 1)/2;
    end

    %idc = sum of 3 upper currents
    iDC(k + 1) = id1(k + 1) + id5(k + 1) + id3(k + 1);

    %stuff -> from class
    stuff(k + 1) = stuff(k) + timestep * (iDC(k) * rload / tau - vdc_prime(k + 1)/tau);
 
    %get phase voltages
    va(k + 1) = 2/3 * vag(k + 1) - 1/3 * vbg(k + 1) - 1/3 * vcg(k + 1);
    vb(k + 1) = 2/3 * vbg(k + 1) - 1/3 * vag(k + 1) - 1/3 * vcg(k + 1);
    vc(k + 1) = 2/3 * vcg(k + 1) - 1/3 * vbg(k + 1) - 1/3 * vag(k + 1);
    
    vDC(k + 1) = iDC(k + 1) * rload;A
    
    k = k + 1;

end