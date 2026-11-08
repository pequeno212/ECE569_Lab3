function [state] = swch(duty, time) 


%make a triangle wave from 0-1
amplitude = 1; %vpp
a0 = 0;
%a0 = 0.5; %for 180
%amplitude = 0.5 %for reg 180
freq = 60000; %period of waveform, subject to change, fsw >>> fac 
w = 2 * pi  * freq;


triangle = amplitude * sawtooth(w * time, 0.5) + a0;

%f(x) = 8A/(pi^2) * sum [1/k^2 * cos(kwt)]



if triangle < duty
    state = 1; %on

else
    state = 0; % off

end