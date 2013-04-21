<<<<<<< HEAD
function cdata = zbuffer_cdata(hfig)
% Get CDATA from hardcopy using zbuffer

% Need to have PaperPositionMode be auto 
orig_mode = get(hfig, 'PaperPositionMode');
set(hfig, 'PaperPositionMode', 'auto');

cdata = hardcopy(hfig, '-Dzbuffer', '-r0');

% Restore figure to original state
set(hfig, 'PaperPositionMode', orig_mode); % end
=======
function cdata = zbuffer_cdata(hfig)
% Get CDATA from hardcopy using zbuffer

% Need to have PaperPositionMode be auto 
orig_mode = get(hfig, 'PaperPositionMode');
set(hfig, 'PaperPositionMode', 'auto');

cdata = hardcopy(hfig, '-Dzbuffer', '-r0');

% Restore figure to original state
set(hfig, 'PaperPositionMode', orig_mode);
>>>>>>> 43ac889aa72362edefdbb03334f2057e26eccf69
