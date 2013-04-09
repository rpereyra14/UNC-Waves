function [ interpWave ] = jengaStyleAverage( fineExcitation, dimensions)
%Input: An excitation pattern with high precision in x,y dimensions,
        %dimensions (currently limited to (n x 1 x t) grid (vertical x horiz x time))

%Output: An excitation pattern composed of short, wide rectangles where
    %each rectangle has z = the average z for that same area in the high
    %precision excitation pattern
    
    
    input_size = size(fineExcitation);
    output_size = dimensions;
    output_size(2) = 1; %forces it to be (n x 1 x t)
    
    scale = input_size(1)/output_size(1); 
    % scale is about 6 for input of 100x100 and output of 16 x 1 
    % in this example, each short,wide rectangle in the output 
    % covers 6 x 100 points of the input
    
    
    
    interpWave = ones(output_size);

    for t = 1:input_size(3)
        for i = 1:output_size(1) %iteration goes from top down
            covered = fineExcitation((i-1)*scale+1:i*scale,:,t);
            avg = sum(sum(covered))/(scale*input_size(2));
            %disp(avg)
            jengaBlock = ones(1,input_size(2));
            jengaBlock = jengaBlock * avg;
            %disp(size(jengaBlock));
            %disp(size(interpWave(1,1:input_size(2))));
            interpWave(i,1:input_size(2),t) = jengaBlock;
        end
    end
    
    
        
    
    
    

