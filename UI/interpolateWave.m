function [ interpWave ] = interpolateWave( wave, method, dimensions)
% Interpolates wave to use specified number of exciters and specified
% number of points in time (both to be modified later based on constraints
% of hardware).

X = size(wave, 1);
Y = size(wave, 2);
Z = size(wave, 3);

% Set parameters
% grainX = 4; %modified from 20
% grainY = 4;
% grainZ = 20;%modified from 4

   
    %always set X,Y grain
    grainX = dimensions(1);
    grainY = dimensions(2);
    %optionally set Z grain
    if size(dimensions) == 3
        grainZ = dimensions(3);
    else
        grainZ = Z;
    end
    


% VI = interp3(V,a,b,c) interpolates to find VI, the values of the
% underlying three-dimensional function V at the points in arrays a, b, and
% c.

% Note: This version places ends at edge of wave data
XI = 1:(X-1)/(grainX-1):X;
YI = 1:(Y-1)/(grainY-1):Y;
ZI = 1:(Z-1)/(grainZ-1):Z;

% Note: This version places places all points at equal distance from each
% other and the edge of wave data
% XI = 1:(X-1)/(grainX+1):X;
% XI = XI(2:end-1);
% YI = 1:(Y-1)/(grainY+1):Y;
% YI = YI(2:end-1);
% ZI = 1:(Z-1)/(grainZ+1):Z;
% ZI = ZI(2:end-1);


[interpX, interpY, interpZ] = meshgrid(YI, XI, ZI);
% Note swap of XI and YI in order due to mismatch in the way meshgrid maps
% x, y, z to rows, columns, and pages, and the way we map it.

interpWave = interp3(wave, interpX, interpY, interpZ, method);

%plot(wave(:,end,end),'b');
%hold on;
%plot(XI, interpWave(:,end,end), 'r');


end