function cdata = figure_grab(hfig)
% Get CDATA from hardcopy using zbuffer

% Need to have PaperPositionMode be auto 
orig_mode = get(hfig, 'PaperPositionMode');
set(hfig, 'PaperPositionMode', 'auto');

cdata = hardcopy(hfig, '-Dzbuffer', '-r0');

% Restore figure to original state
set(hfig, 'PaperPositionMode', orig_mode);