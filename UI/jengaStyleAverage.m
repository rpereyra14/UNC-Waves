function [ interpWave ] = jengaStyleAverage2( fineExcitation, dimensions )

    input_size = size(fineExcitation);
    output_size = dimensions;
    
    scale = [input_size(1)*output_size(1) input_size(2)*output_size(2) input_size(3)*output_size(3)];
    interpWaveScaled = zeros(scale);
    
    for i = 1:input_size(3)
        for j = 1:output_size(3)
            interpWaveScaled(:,:,(i-1)*output_size(3)+j) = kron(fineExcitation(:,:,i),ones(output_size(1), output_size(2)));     
        end
    end
    
    disp(interpWaveScaled);
    
    interpWave = zeros(output_size); 
    
    for i = 1:output_size(1)
        for j = 1:output_size(2)
            for k = 1:output_size(3)
                % x, y, z specify the block from interpWaveScaled which
                % will be averaged
                x = ((i-1)*input_size(1))+1:(i*input_size(1));
                y = ((j-1)*input_size(2))+1:(j*input_size(2));
                z = ((k-1)*input_size(3))+1:(k*input_size(3));
                
                interpWave(i, j, k) = mean(mean(mean(interpWaveScaled(x, y, z))));
            end
        end
    end
    
end