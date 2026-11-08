function singlephase


    %initial conditions
    r = 0.1;
    L = 0.001;
    D = 0.5;

    %switching frequencies, etc.
    fsw = 400;
    period = 1/fsw;
    timestep = period / 1000;
    tend = period * 5;
    t = 0:timestep:tend;

    