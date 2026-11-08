function rectprc
%Initialization Script

    %variables
    ac_L = 0.003;
    dc_L = 0.005;
    amplitude = 2^(1/2) * 120;
    ac_w = 377;
    period = 2 * pi / ac_w;
    tend = 1/ac_w * 2 * pi * 2; %doing two periods to come up to propper value, will only take second period
    timestep = tend/100000;
    t = 0:timestep:tend;
    tau = 10^-5;
    epsilon = 0.01;
    k = 1;
    j = 1;
    rborder12 = 3.24;
    rborder23 = 1.08;

    %waveforms 
    iDC = zeros(size(t)); 
    vDC = zeros(size(t));
    ia = zeros(size(t));
    ib = zeros(size(t));
    ic = zeros(size(t));
    ea = zeros(size(t));
    eb = zeros(size(t));
    ec = zeros(size(t));
    vdc_prime = zeros(size(t));
    id1 = zeros(size(t));
    id3 = zeros(size(t));
    id5 = zeros(size(t));
    gamma = zeros(size(t));
    vag = zeros(size(t));
    vbg = zeros(size(t));
    vcg = zeros(size(t));
    va = zeros(size(t));
    vb = zeros(size(t));
    vc = zeros(size(t));
    stuff = zeros(size(t));

    %waveforms viplot.m
    loads = 100:-0.005:rborder23;
    vDC_vi = zeros(size(loads));
    iDC_vi = zeros(size(loads));
    start = floor(length(t) / 2);
    t_graphing = t(start : end);
    theta_graphing = t_graphing * ac_w / (2 * pi) - 1;
    
    %VI plot
    viplot;
    iDC_plot = iDC_vi;
    iDC_plot(iDC_plot==0)=nan;
    vDC_plot = vDC_vi;
    vDC_plot(vDC_plot==0)=nan;
   
    %Phase Currents 1b
    k = 1;
    rload = 6.31;
    rect;
    ia_graphing = ia(start:end);
    ib_graphing = ib(start:end);
    ic_graphing = ic(start:end);

    %Phase Currents 1c
    k = 1;
    rload = rborder23;
    rect;
    ia_graphing_23 = ia(start:end);
    ib_graphing_23 = ib(start:end);
    ic_graphing_23 = ic(start:end);

    %Phase Currents high resistance
    k = 1;
    rload = 50;
    rect;
    ia_graphing_high = ia(start:end);
    ib_graphing_high = ib(start:end);
    ic_graphing_high = ic(start:end);

    %plot 1: IV
    figure (1);
    cla;
    plot(iDC_plot, vDC_plot);
    title('VDC vs IDC for Range of Loads');
    xlabel("Average DC Current");
    ylabel("Average DC Voltage");
   
    %plot 2: gamma = 45
    figure(2);
    cla
    xlim([0 1]);
    plot(theta_graphing, ia_graphing, 'r');
    hold on; 
    plot(theta_graphing, ib_graphing, 'b');
    plot(theta_graphing, ic_graphing, 'g');
    hold off;
    legend('ia', 'ib', 'ic');
    xticks(0 : 1/6 : 1);
    title('Phase Currents vs Theta at Commutaion of 45 degrees');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    %plot 3: alpha = 30
    figure(3);
    cla
    xlim([0 1]);
    plot(theta_graphing, ia_graphing_23, 'r');
    hold on; 
    plot(theta_graphing, ib_graphing_23, 'b');
    plot(theta_graphing, ic_graphing_23, 'g');
    hold off;
    legend('ia', 'ib', 'ic');
    xticks(0 : 1/6 : 1);
    title('Phase Currents vs Theta at Mode 2 and 3 Borderline');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    %plot 4: no commutation
    figure(4);
    cla
    xlim([0 1]);
    plot(theta_graphing, ia_graphing_high, 'r');
    hold on; 
    plot(theta_graphing, ib_graphing_high, 'b');
    plot(theta_graphing, ic_graphing_high, 'g');
    hold off;
    legend('ia', 'ib', 'ic');
    xticks(0 : 1/6 : 1);
    title('Phase Currents vs Theta with low Gamma');
    xlabel("ThetaAC");
    ylabel("Current (A)");

