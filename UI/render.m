function[F] =render(orig,interpolated,method)
    
%We've received an exciter pattern, let's analyze the size...
%mine is formatted z = f(x,y,t)... they might want to choose for an
%alternative like z = f(t,x,y)
    input_size = size(orig);
    
    xrange = [1 input_size(1)];
    yrange = [1 input_size(2)];
    zrange = [min(min(orig)) max(max(orig))];
    
    trange = [1 input_size(3)];
    

%INTERPOLATION

	interp_size = size(interpolated);
    
    i_xrange = [1 interp_size(2)];
    i_yrange = [1 interp_size(1)];
    %we'll use the same z range

    
    
    
    axis tight
    set(gca,'nextplot','replacechildren');
    fig = figure('Renderer','zbuffer');
   
    if strcmp(method,'embed')
        set(fig, 'Position', [100 100 500 200]);
    else
         set(fig, 'Position', [100 100 800 600]);
    end
    
    
    
    
if strcmp(method,'avi')
    writerObj = VideoWriter('peaks.avi');
    open(writerObj);


    for j = trange(1):trange(2)%for each time slice
       subplot(1,2,1);

        surf(orig(:,:,j));%draw the 3d figure
        axis([xrange(1) xrange(2) yrange(1) yrange(2) zrange(1)-1 zrange(2)+1]);

        subplot(1,2,2);

        surf(interpolated(:,:,j));%draw the interpolated version
        axis([i_xrange(1) i_xrange(2) i_yrange(1) i_yrange(2) zrange(1)-1 zrange(2)+1]);

       frame = getframe(fig);
       writeVideo(writerObj,frame);

    end
    close(writerObj);
end

if strcmp(method,'struct') || strcmp(method,'embed')
    %F = zeros(size(getframe(fig)));
    for j = trange(1):trange(2)%for each time slice
    subplot(1,2,1);
    
    surf(orig(:,:,j));%draw the 3d figure
    axis([xrange(1) xrange(2) yrange(1) yrange(2) zrange(1)-1 zrange(2)+1]);
    
    subplot(1,2,2);
    
    surf(interpolated(:,:,j));%draw the interpolated version
    axis([i_xrange(1) i_xrange(2) i_yrange(1) i_yrange(2) zrange(1)-1 zrange(2)+1]);

    F(j) = getframe(fig);
    end
    close(fig);
end

