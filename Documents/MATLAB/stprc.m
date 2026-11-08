function stprc
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
    m = 0.64; %80/125 = 0.66
    duty = m * sin(theta * t); %made duty cycle = sin to account for starting current at 0A, doing cos had a first rise that was smaller


    %preparing triangle wave
    amplitude = 1; %vpp
    a0 = 0;
    w = 2 * pi  * fsw;
    triangle = amplitude * sawtooth( w * t, 0.5) + a0;

    %graphs and whatnot
    iAC = zeros(size(t)); 
    vAC = zeros(size(t));
    id1 = zeros(size(t));
    iT1 = zeros(size(t));
    vsw1 = zeros(size(t));
    iT2 = zeros(size(t));
    id2 = zeros(size(t));
    vComparator = zeros(size(t));
    iDC = zeros(size(t));


    iAC(1) = 0;
  
    vdc = 125;
    num_coefs = 25;

    st;
    [avg1,ak1,bk1,rw1,err1,thd1] = fourthd(t, vAC, period, num_coefs);
    [avg2,ak2,bk2,rw2,err2,thd2] = fourthd(t, iAC, period, num_coefs);

    absak1 = abs(ak1);
    absbk1 = abs(bk1);
    harmonics = absak1.^2 + absbk1.^2;
    harmonics = harmonics.^(1/2);
    coeffs = (1:1:num_coefs);
    theta_graphing = t / period;

    
    

    iDC = iT1 + iT2 - id1 - id2;
   

    
    %for q5

    fprintf("The vAC THD value is %.2f\n", thd1);
    fprintf("The iAC THD value is %.2f\n", thd2);
    fprintf("The average value of vAC is %.2f\n", avg1);
    fprintf("The error of vAC is %.2f\n", err1);
    fprintf("The average value of iAC is %.2f\n", avg2);
    fprintf("The error of iAC is %.2f\n", err2);
    fprintf('Harmonics: [%s]\n', join(string(harmonics), ', ')); 
  
    figure(1);
    subplot(4, 2, 1);
    cla;
    plot(theta_graphing, vAC);
    ylim([-150 150]);
    title('AC Voltage vs Theta');
    xlabel("ThetaAC");
    ylabel("Voltage (V)");

    subplot(4, 2, 2);
    cla;
    plot(theta_graphing, iAC);
    title('AC Current vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");
  
    subplot(4, 2, 3);
    cla;
    plot(theta_graphing, vsw1);
    title('Transistor Voltage vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(4, 2, 4);
    cla;
    plot(theta_graphing, iDC);
    title('DC Current vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");


    
    subplot(4, 2, 5);
    cla;
    plot(theta_graphing, iT1);
    ylim([-1 10]);
    title('Transistor1 Current vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(4, 2, 6);
    cla;
    plot(theta_graphing, id1);
    ylim([-1 10]);
    title('Diode1 Current vs Theta');
    xlabel("ThetaAc");
    ylabel("Current (A)");

    subplot(4, 2, 7);
    cla;
    plot(theta_graphing, iT2);
    ylim([-1 10]);
    title('Transistor2 Current');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(4, 2, 8);
    cla;
    plot(theta_graphing, id2);
    ylim([-1 10]);
    title('Diode 2 Current');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    figure(3);
    cla;
    scatter(coeffs, harmonics);
    title('Harmonics of AC Voltage');
    xlabel("Harmonic #");
    ylabel("Voltage (A)");


  
    
  
    

