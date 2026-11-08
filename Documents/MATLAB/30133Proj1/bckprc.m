function bckprc

    
    capacitance = 0.000036232;
    inductance = 0.00001242;
    fsw = 50000;
    period = 1/fsw;
    timestep = period / 1000;
    rLoad = 0.288;
    tend = 0.0004;
    t = 0:timestep:tend;
    
    iL = zeros(size(t));
    vC = zeros(size(t));
    vL = zeros(size(t));
    iC = zeros(size(t));
    vLoad = zeros(size(t));
    isw1 = zeros(size(t));
    isw2 = zeros(size(t));
    vsw1 = zeros(size(t));
    vsw2 = zeros(size(t));
    i2 = zeros(size(t));
    i1 = zeros(size(t));

    rTon = 0.01;
    rDon = 0.01;

    vsw2(1) = -48;
    vS = 48;
    
    k = 1;
    duty = 0.2586; %.25 for ideal
    
    vC(1) = 0;
    vLoad(1) = 0;
    iL(1) = 0;

    bck;
   
    % for getting SS
    removed = round((tend - 2 * period) / timestep)
    
    iL(1:removed ) = [];
    vsw2(1:removed ) = [];
    isw2(1:removed ) = [];
    vLoad(1:removed ) = [];
   
    timeAxis = 0:timestep:(tend - removed * timestep);
    %timeAxis = 0:timestep:tend;
   

    subplot(2, 2, 1); % Selects the first position (top-left)
    plot(timeAxis, iL);
    title('iL vs Time');
    xlabel("Time (s)");
    ylabel("Current (A)");

    subplot(2, 2, 2); % Selects the first position (top-left)
    plot(timeAxis, vLoad);
    title('Output Voltage vs Time');
    xlabel("Time (s)");
    ylabel("Voltage (V)");

    subplot(2, 2, 3); % Selects the first position (top-left)
    plot(timeAxis, vsw2);
    title('Diode Voltage vs Time');
    xlabel("Time (s)");
    ylabel("Current (A)");
 

    subplot(2, 2, 4); % Selects the first position (top-left)
    plot(timeAxis, isw2);
    title('Diode Current vs Time');
    xlabel("Time (s)");
    ylabel("Current (A)");

    sgtitle('Voltages & Currents - Steady State under Light Load');

    %averg(iL, period, timestep);
    %averg(vLoad, period, timestep);
    %averg(isw1, period, timestep);

    


    %{
    subplot(2, 4, 7); % Selects the first position (top-left)
    plot(timeAxis, vsw2);
    title('vsw2 vs Time');
    xlabel("Time (s)");
    ylabel("Voltage (V)");

subplot(2, 4, 4); % Selects the first position (top-left)
    plot(timeAxis, iC);
    title('iC vs Time');
    xlabel("Time (s)");
    ylabel("Current (A)");

 subplot(2, 4, 1); % Selects the first position (top-left)
    plot(timeAxis, vL);
    title('vL vs Time');
    xlabel("Time (s)");
    ylabel("Voltage (V)");

     subplot(2, 4, 5); % Selects the first position (top-left)
    plot(timeAxis, vsw1);
    title('vsw1 vs Time');
    xlabel("Time (s)");
    ylabel("Voltage (V)");
    %}  
