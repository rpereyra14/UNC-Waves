function [wave] = generate_wave(~)
%Generate the exciter pattern that we'll receiving from mathematicians
    %Parameters that will control the rest of the script
        xrange = [1 49];
        yrange = [1 49];
        trange = [1 20];

        xstep = 1;
        ystep = 1;
        tstep = 1;

    %The rest of the script.
    [X,Y,T] = meshgrid(xrange(1):xstep:xrange(2), ...
                       yrange(1):ystep:yrange(2), ...
                       trange(1):tstep:trange(2));
   
    dimensions = [(xrange(2)-xrange(1)+1) ...
                  (yrange(2)-yrange(1)+1) ...
                  (trange(2)-trange(1)+1)];
               
    total_size = prod(dimensions);
   
    
    Z = zeros(dimensions);
    
    for i = 1:total_size
        Z(i) = wave_generating_function(X(i),Y(i),T(i));
    end
    %It seems like Z(0,0,_) will be Z at the lowest x,y instead of when x,y
    %are 0.  for instance for xrange from -25 to 25 Z(25,_,_) is when x = 0
    
    wave = Z;
    csvwrite('stevens_wave.csv',wave);