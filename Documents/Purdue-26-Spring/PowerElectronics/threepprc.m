function threepprc


    %initial conditions
    r = 0.1;
    L = 0.001;
    duty = 0.5;
    k = 1;

    %switching frequencies, etc.
    fsw = 400;
    period = 1/fsw;
    timestep = period / 1000;
    tend = period ;
    t = 0:timestep:tend;
    theta = 2 * pi * 400;

    %graphs and whatnot
    iAC = zeros(size(t)); 
    vAC = zeros(size(t));
    id = zeros(size(t));
    iT = zeros(size(t));
    vT = zeros(size(t));
    vd = zeros(size(t));

    iAC(1) = 0;
  
    vdc = 200;

    sp;
    [avg1,ak1,bk1,rw1,err1,thd1] = fourthd(t, vAC, period, 12);

    absak1 = abs(ak1);
    absbk1 = abs(bk1);

    coeffs = (1:1:12) ;

    %disp(thd1);
    %disp(ak1);
    thetavals = linspace(theta, theta, 12*theta);
   
    theta_graphing = t / period;
     
    subplot(4, 2, 1);
    plot(theta_graphing, vAC);
    ylim([-250 250])
    title('VAC vs Theta');
    xlabel("ThetaAC");
    ylabel("Voltage (V)");

    subplot(4, 2, 2);
    plot(theta_graphing, iAC);
    title('iAC vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");
  
    subplot(4, 2, 3);
    plot(theta_graphing, id);
    title('id vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(4, 2, 4);
    plot(theta_graphing, iT);
    title('iT vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");
    
    subplot(4, 2, 5);
    plot(theta_graphing, vd);
    ylim([0 250])
    title('vd vs Theta');
    xlabel("ThetaAC");
    ylabel("Current (A)");

    subplot(4, 2, 6);
    plot(theta_graphing, vT);
    ylim([0 250])
    title('vT vs Theta');
    xlabel("ThetaAc");
    ylabel("Current (A)");


    subplot(4, 2, 7);
    scatter(coeffs, absak1);
    title('Harmonics of ak vs Theta');
    xlabel("Harmonics");
    ylabel("Voltage (V)");

    subplot(4, 2, 8);
    plot(theta_graphing, rw1);
    title('RW vs Time');
    xlabel("ThetaAC");
    ylabel("Voltage (A)");
    

    
    %The THD value is 0.43

    %The THD value is 0.43
    %The average value is 0.40
    %The error is 0.20

