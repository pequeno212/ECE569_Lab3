function spprc


    %initial conditions
    r = 0.1;
    L = 0.001;
    duty = 0.5;
    k = 1;

    %switching frequencies, etc.
    fac = 400;
    period = 1/fac;
    timestep = period / 1000;
    tend = period ;
    t = 0:timestep:tend;
    theta = 2 * pi * 400;

    %graphs and whatnot
    iAC = zeros(size(t)); 
    vAC = zeros(size(t));
    id1 = zeros(size(t));
    iT1 = zeros(size(t));
    vsw1 = zeros(size(t));
    vsw2 = zeros(size(t));
    iT2 = zeros(size(t));
    id2 = zeros(size(t));
    iDC = zeros(size(t));


    vdc = 200;

    sp;
    [avg1,ak1,bk1,rw1,err1,thd1] = fourthd(t, vAC, period, 12);

    absak1 = abs(ak1);
    absbk1 = abs(bk1);
    harmonics = absak1.^2 + absbk1.^2;
    harmonics = harmonics.^(1/2);

    coeffs = (1:1:12) ;


    %disp(thd1);
    %disp(ak1);
   
    theta_graphing = t / period;
    iDC = iT1 + iT2 - id1 - id2;

    subplot(4, 2, 1);
    plot(theta_graphing, vAC);
    ylim([-250 250])
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
    ylim([-5 250]);
    title('Switch1 Voltage vs Theta');
    xlabel("ThetaAC");
    ylabel("Voltage (V)");

    subplot(4, 2, 4);
    cla;
    plot(theta_graphing, vsw2);
    ylim([-5 250]);
    title('Switch2 Voltage vs Theta');
    xlabel("ThetaAC");
    ylabel("Voltage (A)");
    
    subplot(4, 2, 5);
    cla;
    plot(theta_graphing, id1);
    ylim([-10 150]);
    title('Diode1 Current vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(4, 2, 6);
    cla;
    plot(theta_graphing, iT1);
    ylim([-10 150]);
    title('Transistor1 Current vs Theta');
    xlabel("ThetaAc");
    ylabel("Current (A)");


    subplot(4, 2, 8);
    cla;
    scatter(coeffs, harmonics);
    ylim([-10 300]);
    title('Harmonics of VAC vs Theta');
    xlabel("Harmonics");
    ylabel("Voltage (V)");

    subplot(4, 2, 7);
    cla;
    ylim([-150 150]);
    xlim([-0 1]);
    plot(theta_graphing, iDC);
    title('DC Current vs Time');
    xlabel("ThetaAC");
    ylabel("Current (A)");
    

    
    %The THD value is 0.43

    %The THD value is 0.43
    %The average value is 0.40
    %The error is 0.20

