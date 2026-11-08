function [avg] = fourthd(t,x,T,N)
%updated fourthd to give just average

    n = 1;
    tend = t(1) + T;
    dt = t(2) - t(1);
    ak = zeros(1, N);
    bk = zeros(1, N);
    rw = 0;
    xr = zeros(1,N);
    sum_xr = 0;

    while n <= N
        
        dummy = 1; %start at begginging of waveform t, assuming ends at T
        sum_ak = 0;
        sum_bk = 0;
        
        while t(dummy) < tend - dt %integrate over waveform     
   
            sum_ak = sum_ak + x(dummy)*cos(n * (2 * pi /T) * t(dummy)) * dt; %integrate little by little ak
            sum_bk = sum_bk + x(dummy)*sin(n * (2 * pi /T) * t(dummy)) * dt; %^ for bk
            dummy = dummy + 1; %take 100 points from 0 to T
            
        end
       
        ak(n) = 2/T * sum_ak;
        bk(n) = 2/T * sum_bk;
        rw = rw + ak(n)* cos(n * (2 * pi /T) * t) + bk(n)* sin(n * (2 * pi /T) * t);
        xr(n) = sqrt(ak(n)^2 + bk(n)^2)/ sqrt(2);
        if n > 1
            sum_xr = sum_xr + xr(n)^2;
        end
        n = n + 1;

    end

    dummy = 1;
    sum_avg = 0;

    while t(dummy) < tend - dt %integrate over waveform
        
         sum_avg = sum_avg + x(dummy) * dt; % ^for avg of waveform
         dummy = dummy + 1; 

    end

    avg = 1/T * sum_avg;

    fprintf("Average value of x is %.2d\n", avg);