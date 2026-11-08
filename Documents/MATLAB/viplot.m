%loop for vDC vs iDC

while loads(j) > rborder23;
   
    %set k = 1 to run rect
    k = 1;
    %set the resistance, run the while loop
    rload = loads(j);
    rect;
    
    %take second period
    iDC_graphing = iDC(start : end);
    vDC_graphing = vDC(start : end);

    %find avg
    iDC_vi(j) = fourthd(t_graphing, iDC_graphing, period, 1);
    vDC_vi(j) = fourthd(t_graphing, vDC_graphing, period, 1);

    j = j + 1;
    
end