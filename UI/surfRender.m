function[F] = surfRender(orig_excitation_pattern,achievable_excitation_pattern,timestep,axis1,axis2,the_view)
 %% Renders two excitation patterns at given timestep onto the two provided axes with specified camera view

    input_size = size(orig_excitation_pattern);
    yrange = [1 input_size(1)];
    zrange = [1 input_size(2)];
    eXcitationrange = [min(min(min(orig_excitation_pattern))) max(max(max(orig_excitation_pattern)))];    


	achievable_size = size(achievable_excitation_pattern);
    i_yrange = [1 achievable_size(1)];
    i_zrange = [1 achievable_size(2)];
    %we'll use the same time range
    

   surf(axis1,orig_excitation_pattern(:,:,timestep));%draw the 3d figure    
   axis(axis1,[1 zrange(2) 1 yrange(2) eXcitationrange(1) eXcitationrange(2)]);
   view(axis1,the_view);
   colormap(axis1,'bone');
        
       
    surf(axis2,achievable_excitation_pattern(:,:,timestep));
    axis(axis2,[i_zrange(1) i_zrange(2) i_yrange(1) i_yrange(2) eXcitationrange(1) eXcitationrange(2)]);
    view(axis2,the_view);
    colormap(axis2,'bone');



