function [state] = swch(duty, time) 


%make a triangle wave from 0-1

a0 = 0.5; %dc offset
amplitude = 0.5; %
freq = 400; %period of waveform
w = 2 * pi  * freq;


%f(x) = 8A/(pi^2) * sum [1/k^2 * cos(kwt)]


k = 1:2:50;
triangle_general = (8 / pi^2) * sum((1 ./(k.^2)) .* cos(k * w * time)) 
triangle = amplitude * triangle_general + a0

if triangle < duty
    state = 1; %on

else
    state = 0; % off

end