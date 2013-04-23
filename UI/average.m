function [ interpWave ] = average( fineExcitation, dimensions )

    % Round results to this decimal place.
    tolerance = -3;

    input_size = ones(3,1);
    switch numel(size(fineExcitation))
        case 1
            input_size(1) = size(fineExcitation);
        case 2
            input_size(1:2) = size(fineExcitation);
        case 3
            input_size = size(fineExcitation);
        otherwise
            fprintf('Error: Matrix must be of dimension 3 or fewer.');
            exit;
    end
        
    output_size = dimensions;
    
    scale = [input_size(1)*output_size(1) input_size(2)*output_size(2) input_size(3)];% excluding extra time factor *output_size(3)];
    interpWaveScaled = zeros(scale);
  
    
    %CHOOSE THIS 
%   for i = 1:input_size(3)
%       for j = 1:output_size(3)
%           interpWaveScaled(:,:,(i-1)*output_size(3)+j) = kron(fineExcitation(:,:,i),ones(output_size(1), output_size(2)));     
%       end
%   end
 %OR THIS
 
    for i = 1:input_size(1)
        for j = 1:input_size(2)
            for k = 1:input_size(3)
                x = ((i-1)*output_size(1))+1:(i*output_size(1));
                y = ((j-1)*output_size(2))+1:(j*output_size(2));
                z = k;%((k-1)*output_size(3))+1:(k*output_size(3));
                
                interpWaveScaled(x, y, z) = fineExcitation(i, j, k);
            end
        end
    end

%END CHOICE
            
    interpWave = zeros(output_size); 
    
    for i = 1:output_size(1)
        for j = 1:output_size(2)
            for k = 1:output_size(3)
                % x, y, z specify the block from interpWaveScaled which
                % will be averaged
                x = ((i-1)*input_size(1))+1:(i*input_size(1));
                y = ((j-1)*input_size(2))+1:(j*input_size(2));
                z = k;%((k-1)*input_size(3))+1:(k*input_size(3));
                
                interpWave(i, j, k) = mean(mean(mean(interpWaveScaled(x, y, z))));
            end
        end
    end
    
    interpWave = roundn(interpWave, tolerance);
    