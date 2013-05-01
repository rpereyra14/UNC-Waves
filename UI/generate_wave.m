function [wave] = generate_wave(y_range, z_range, t_range,name)
%Generate the exciter pattern that we'll receiving from mathematicians

    while(strcmp(name,'wave') || strcmp(name,'name'))
        if(strcmp(name,'wave'))
            name = input('try using a name other than "wave"...\n','s');
        end
        if (strcmp(name,'name'))
            name = input('try using a name other than "name"...\n','s');
        end
       
    end

    dimensions = [(y_range) ...
                  (z_range) ...
                  (t_range)];
               
              
    %Initialize the wave
    wave = zeros(dimensions);
    
    %Generate the wave one x,y,t at a time
    for t = 1:t_range
        for z = 1:z_range
            for y = 1:y_range
                wave(y,z,t) = wave_generating_function(y,z,t);
            end
        end
    end
    
    %Write it to a csv file
    csvwrite([name '.csv'] ,wave);
    
    %Add this wave struct into matlab file test_waves.mat
    
    clearvars -except name wave

    load('test_waves.mat');
    
    eval([name '= wave;']); %Create variable to hold the wave
    
    clear 'name'
    clear 'wave'
    
    save('test_waves.mat');
    
    
    