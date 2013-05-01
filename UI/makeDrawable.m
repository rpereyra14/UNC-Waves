function [ drawable_excitation_pattern ] = makeDrawable( excitation_pattern )
%% Converts <excitation pattern> to a form that is able to be plotted by MATLAB's 'surf' function
    input_size = size(excitation_pattern);
    t_max = 137; %at most this many timeslices will be drawn for the preview movie of this excitation_pattern
    
    assert(all(size(input_size) == [1 3])); %excitation_pattern should have 3 dimensions
    
    ydim = input_size(1);
    zdim = input_size(2);
    tdim = input_size(3);
    
    assert(ydim > 0);
    assert(zdim > 0);
    assert(tdim > 0);
    
    scale = ceil(tdim/t_max);
    total_frames = min(floor(tdim/scale),tdim);
    
    drawable_excitation_pattern = ones(ydim,zdim,total_frames);
    
    if tdim > t_max
        
        for i = 1:total_frames
            drawable_excitation_pattern(:,:,i) = excitation_pattern(:,:,scale*i);
        end
    else
         drawable_excitation_pattern = excitation_pattern;
    end
    
    
    if ydim == 1
        drawable_excitation_pattern = [drawable_excitation_pattern; drawable_excitation_pattern];
    end
    
    if zdim == 1
        drawable_excitation_pattern = [drawable_excitation_pattern drawable_excitation_pattern];
    end
    
    
   
    
    
    
    


end

