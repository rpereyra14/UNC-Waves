function [wave] = generate_wave(y_range, z_range, t_range,name)
%Generate the exciter pattern that we'll receiving from mathematicians

    xstep = 1;
    ystep = 1;
    tstep = 1;

   
    [X,Y,T] = meshgrid(1:xstep:y_range, ...
                       1:ystep:z_range, ...
                       1:tstep:t_range);
   
    dimensions = [(y_range) ...
                  (z_range) ...
                  (t_range)];
               
              
    %Initialize the wave
    wave = zeros(dimensions);
    
    %Generate the wave one x,y,t at a time
    total_size = prod(dimensions);
    for i = 1:total_size
        wave(i) = wave_generating_function(X(i),Y(i),T(i));
    end
    
    %Write it to a csv file
    csvwrite([name '.csv'] ,wave);
    
    %Add this wave struct into matlab file test_waves.mat
    
    eval([name '= wave;']);             %Create variable to hold the wave
    eval([' clearvars -except ' name]); %Clear all other variables
    load('test_waves.mat');             %Add to existing file
    save('test_waves.mat');
    
    
    