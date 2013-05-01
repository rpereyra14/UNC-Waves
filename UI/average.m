function [ averagedExcitation ] = average( fineExcitation, dimensions )
%% Compress fine-grained excitation pattern into a (dimensions) sized excitation pattern
%  <fineExcitation> is a Y x Z x T matrix
%  <averagedExcitation> is a matrix with dimensions <dimensions>
%  T may be 1, so that <fineExcitation> is just a 2 dimensional matrix
%  Z may be 1, so that <fineExcitation> is just a 1 dimensional array
%
%  <dimensions> will usually be smaller than or equal to the dimensions of
%  <fineExcitation>. 
%
%  For Example,
%           fineExcitation:  [1  2]
%                            [3  4]
%                            [5  6]
%                            [7  8]
%
%           dimensions: [2,1,1]
%           
%           averagedExcitation: [10/4]
%                               [26/4]
%
%  This process would be applied to each timeslice 
%  (timeslice 1 is fineExcitation(:,:,1)) for matrices with more than one
%  timeslice.  
%
%   If Y and Z dimensions of <fineExcitation> are not easily
%  divided by dimension sizes specified in <dimensions>, like converting 4
%  rows into 3 rows, fractional portions of each row are averaged together.
%
%  For Example,
%           fineExcitation: [1  2]
%                           [3  4]
%                           [5  6]
%                           [7  8]
%
%           dimensions: [3,2,1]
%                           
%           averagedExcitation:        / [3/3+ 3/3   6/3+ 4/3] \
%                              (3/4)* |  [6/3+10/3   8/3+12/3]  |
%                                      \ [5/3+21/3   6/3+24/3] /
%
%   The first output row is the average of (1)*the first input row + (1/3)*the
%   second input row.  The second output row is the average of (2/3)*the
%   second input row + (2/3) * the third output row.  The third output row
%   is the average of (1/3)*the third output row + (1)*the fourth output row,
%   for a total of each input row appearing (4/3) times.  Then everything
%   is multiplied by (3/4) to offset that.  A similar process allows for
%   the averagedExcitation to have larger dimensions that fineExcitation,
%   although that is not expected.


    % Round results to this decimal place. (-3 for nearest .001)
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
    
    averagedExcitation = roundn(interpWave, tolerance);
    