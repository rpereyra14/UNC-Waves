function[F] = render(orig,interpolated,method)
    
%We've received an exciter pattern, let's analyze the size...
%mine is formatted z = f(x,y,t)... they might want to choose for an
%alternative like z = f(t,x,y)
    orig = makeDrawable(orig);
    interpolated = makeDrawable(interpolated);
    debug('interpolated: [%d %d %d]',size(interpolated));

    input_size = size(orig);
    
    
    yrange = [1 input_size(1)];
    zrange = [1 input_size(2)];
    eXcitationrange = [min(min(orig)) max(max(orig))];
    
    trange = [1 input_size(3)];
    

%INTERPOLATION
	interp_size = size(interpolated);
   
    i_yrange = [1 interp_size(1)];
    i_zrange = [1 interp_size(2)];

    %we'll use the same z range

 
%PREPARING THE FIGURE    
    axis tight
    set(gca,'nextplot','replacechildren');
    fig = figure('Renderer','zbuffer','visible','off','Color',[240 240 240]/255);
   
    if strcmp(method,'embed')
        set(fig, 'Position', [475, 0, 700, 675]);
    else
        set(fig, 'Position', [100 100 800 600]);
    end
     
  
%PLOTTING
    for j = trange(1):trange(2)%for each time slice
        subplot(1,2,1);

        surf(orig(:,:,j));%draw the 3d figure
        axis([zrange(1) zrange(2) yrange(1) yrange(2) eXcitationrange(1)-1 eXcitationrange(2)+1]);

        subplot(1,2,2);

        
        surf(interpolated(:,:,j));%draw the interpolated version
        axis([i_zrange(1) i_zrange(2) i_yrange(1) i_yrange(2) eXcitationrange(1)-1 eXcitationrange(2)+1]);

        F(j) = im2frame(figure_grab(fig));
        if(mod(j,10) == 0)
            debug('drawn frame %d out of %d',j, trange(2));
        end
    end

    close(fig);

