function threepprc

    %initial conditions
    r = 0.1;
    L = 0.005;
    k = 1;

    %switching frequencies, etc.
    fac = 60;
    period = 1/fac;
    fsw = 21 * fac;
    timestep = period / 1000;
    tend = period;
    t = 0:timestep:tend;
    theta = 2 * pi * fac;
    phi = 87 * pi/180;
    m = 1;

    %important waveforms
    iAC = zeros(size(t)); 
    vAC = zeros(size(t));
    id1 = zeros(size(t));
    iT1 = zeros(size(t));
    iT4 = zeros(size(t));
    id4 = zeros(size(t));
    id2 = zeros(size(t));
    iT2 = zeros(size(t));
    iT5 = zeros(size(t));
    id5 = zeros(size(t));
    id3 = zeros(size(t));
    iT3 = zeros(size(t));
    iT6 = zeros(size(t));
    id6 = zeros(size(t));
    vas = zeros(size(t));
    vbs = zeros(size(t));
    vcs = zeros(size(t));
    vag = zeros(size(t));
    vbg = zeros(size(t));
    vcg = zeros(size(t));
    ias = zeros(size(t));
    ibs = zeros(size(t));
    ics = zeros(size(t));
    vd1 = zeros(size(t));
    vT1 = zeros(size(t));
    vd4 = zeros(size(t));
    vT4 = zeros(size(t));
    

    %duty cycles, work is in project
    da = m * cos(theta * t + phi); 
    db = m * cos(theta * t + phi - 2 * pi /3); 
    dc = m * cos(theta * t + phi + 2 * pi /3); 

    %preparing triangle wave
    amplitude = 1; %vpp
    a0 = 0;
    w = 2 * pi  * fsw;
    triangle = amplitude * sawtooth( w * t, 0.5) + a0;

    %initial conditions
    ias(1) = 100;
    ibs(1) = 100 * cos( 2 * pi * 60 - 2 * pi/3);
    ics(1) = 100 * cos( 2 * pi * 60 + 2 * pi/3);
    vas(1) = 0;
    vbs(1) = 0;
    vcs(1) = 0;
    vag(1) = 0;
    vbg(1) = 0;
    vcg(1) = 0;
    vdc = 188.76;

    threep; %calling threep
    [avg1,ak1,bk1,rw1,err1,thd1] = fourthd(t, ias, period, 25);
    [avg2,ak2,bk2,rw2,err2,thd2] = fourthd(t, vas, period, 25);

    %setting up harmonics
    absak1 = abs(ak1);
    absbk1 = abs(bk1);
    harmonics_ias = absak1.^2 + absbk1.^2;
    harmonics_ias = harmonics_ias.^(1/2);

    absak2 = abs(ak2);
    absbk2 = abs(bk2);
    harmonics_vas = absak2.^2 + absbk2.^2;
    harmonics_vas = harmonics_vas.^(1/2);

    %DC current
    iDC = iT1 + iT2 + iT3 - id1 - id2 - id3;
    
    %setting up graph x axis
    theta_graphing = t / period;
    coeffs = (1:1:25) ;
     
    %vT1 = vdc - vag, diode = -(vT)
    vT1 = vdc - vag;
    vd1 = vag - vdc;
    vT4 = vag;
    vd4 = -vag;

    figure (1);
    subplot(2,1,2);
    cla;
    plot(theta_graphing, ias, 'r');
    hold on; 
    plot(theta_graphing, ibs, 'b');
    plot(theta_graphing, ics, 'g');
    
    hold off;
    legend('ias', 'ibs', 'ics');
    title('AC Current vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(2,1,1);
    cla;
    plot(theta_graphing, vas, 'r');
    hold on;
    
    plot(theta_graphing, vbs, 'b');
    plot(theta_graphing, vcs, 'g');

    hold off;
    legend('vas', 'vbs', 'vcs')
    title('AC Voltage vs Theta'); 
    xlabel("ThetaAC");
    ylabel("Voltage (A)");

    figure(2);
    subplot(2,1,1);
    cla;
    ylim([-50 400]);
    scatter(coeffs, harmonics_ias);
    title('Harmonics of AS Current'); 
    xlabel("Harmonics");
    ylabel("Current (A)");
    
    subplot(2,1,2);
    cla;
    scatter(coeffs, harmonics_vas);
    title('Harmonics of AS Voltage'); 
    xlabel("Harmonics");
    ylabel("Voltage (V)");

    figure(3);
    cla;

    subplot(2,4,1);
    cla;
    plot(theta_graphing, vT1);
    ylim([-5 400]);
    title('Transistor1 Voltage vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Voltage (V)");
    
    
    subplot(2,4,5);
    cla;
    plot(theta_graphing, iT1);
    ylim([-5 120]);
    title('Transistor1 Current vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Current (A)");
    
    subplot(2,4,2);
    cla;
    plot(theta_graphing, vd1);
    ylim([-400 5]);
    title('Diode1 Voltage vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Voltage (V)");

    subplot(2,4,6);
    cla;
    plot(theta_graphing, id1);
    ylim([-5 120]);
    title('Diode1 Current vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(2,4,3);
    cla;
    plot(theta_graphing, vT4);
    ylim([-200 200]);
    title('Transistor4 Voltage vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Voltage (V)");
    
    subplot(2,4,7);
    cla;
    plot(theta_graphing, iT4);
    ylim([-5 120]);
    title('Transistor4 Current vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Current (A)");
    
    subplot(2,4,4);
    cla;
    plot(theta_graphing, vd4);
    ylim([-200 200]);
    title('Diode4 Voltage vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Voltage (V)");

    subplot(2,4,8);
    cla;
    plot(theta_graphing, id4);
    ylim([-5 120]);
    title('Diode4 Current vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Current (A)");

    figure (4)
    cla;
    plot(theta_graphing, iDC);
    title('DC Current vs ThetaAC'); 
    xlabel("ThetaAC");
    ylabel("Current (A)");
    
    