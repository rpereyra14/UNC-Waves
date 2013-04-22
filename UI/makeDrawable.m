function [ drawable_excitation_pattern ] = makeDrawable( excitation_pattern )
%MAKEDRAWABLE Converts an excitation pattern to a form to be plotted
    debug('making drawable');
    input_size = size(excitation_pattern);
    t_max = 50;
    
    assert(all(size(input_size) == [1 3]));
    
    ydim = input_size(1);
    zdim = input_size(2);
    tdim = input_size(3);
    
    assert(ydim > 0);
    assert(zdim > 0);
    assert(tdim > 0);
    
    scale = ceil(tdim/t_max);
    total_frames = min(floor(tdim/scale),tdim);
    
    drawable_excitation_pattern = ones(ydim,zdim,total_frames);
    debug('scale: %d',scale);
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
    
    
    debug('compressed matrix of [%d %d %d] down to [ %d %d %d]',input_size, size(drawable_excitation_pattern));
   
    
    
    
    


end

