function stprc6
%sin trinagle single phase

%initial conditions
    r = 10;
    L = 0.02;
    k = 1;

    %switching frequencies, etc.
    fac = 60;
    fsw = fac * 21; %harmonic w highest voltage
    period = 1/fac;
    timestep = period / 100000;
    tend = period;
    t = 0:timestep:tend;
    theta = 2 * pi * fac;
    diff_m = [0.1, 0.2, 0.3, 0.4, 0.6, 1.0, 5];

    %preparing triangle wave
    amplitude = 1; %vpp
    a0 = 0;
    w = 2 * pi  * fsw;
    triangle = amplitude * sawtooth( w * t, 0.5) + a0;

    %graphs and whatnot
    iAC = zeros(size(t)); 
    vAC = zeros(size(t));
    fundamentals = zeros(size(diff_m));


    iAC(1) = 0;
  
    vdc = 125;
    num_coefs = 25;
 
    
    i = 0;
    for val = diff_m
        i = i +1;
        disp(val);
        duty = val * sin(theta * t);
        st;
        [avg1,ak1,bk1,rw1,err1,thd1] = fourthd(t, vAC, period, num_coefs);
        fundamentals(i) = (ak1(1)^2 + bk1(1)^2)^(0.5);
        
    end

 

    cla;
    scatter(diff_m, fundamentals, 'r', 'x');
    ylim([-5 200]);
    title('Fundamental Amplitude vs m');
    xlabel("m");
    ylabel("Voltage (V)");

    
    fprintf('Fundamentals: [%s]\n', join(string(fundamentals), ', ')); 
    
