function averg(wave, T, dt)

average = 0;
last = length(wave);
period_ints = (T / dt);


for i = (last - period_ints ):1:last - 1;

    average = average + dt * wave(i);
    
end

average = average / T;
fprintf('average value for waveform is %.4f \n',  average)


