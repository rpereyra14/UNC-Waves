function[F] = surfRender(orig,interpolated,frame,axis1,axis2,the_view)
 

    input_size = size(orig);
    yrange = [1 input_size(1)];
    zrange = [1 input_size(2)];
    eXcitationrange = [min(min(min(orig))) max(max(max(orig)))];    

%INTERPOLATION
	interp_size = size(interpolated);
   
    i_yrange = [1 interp_size(1)];
    i_zrange = [1 interp_size(2)];

    %we'll use the same z range

 
%PREPARING THE FIGURE    
    %axis tight
    %set(axis_handle,'nextplot','replacechildren');
    
    %fig = figure('Renderer','zbuffer','visible','off','Color',[240 240 240]/255);
   
%     if strcmp(method,'embed')
%         set(fig, 'Position', [475, 0, 700, 675]);
%     else
%         set(fig, 'Position', [100 100 800 600]);
%     end
     
  
%PLOTTING
   %for each time slice
%    axes(axis_handle);
        %axes(axis1);
        %disp(size(orig(:,:,frame)));
        %campos(axis1,view1);
        surf(axis1,orig(:,:,frame));%draw the 3d figure
                view(the_view);

        %camorbit(orbity,orbitz,'camera');
       % disp('b');
        axis(axis1,[1 zrange(2) 1 yrange(2) eXcitationrange(1) eXcitationrange(2)]);
       view(axis1,the_view);
       colormap(axis1,'bone');
        
        
        %subplot(1,2,2);
           %    campos(axis2,view2);

        surf(axis2,interpolated(:,:,frame));%draw the interpolated version
            %   camorbit(orbity,orbitz,'camera');
        axis(axis2,[i_zrange(1) i_zrange(2) i_yrange(1) i_yrange(2) eXcitationrange(1) eXcitationrange(2)]);
        view(axis2,the_view);
               colormap(axis2,'bone');



