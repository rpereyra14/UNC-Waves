Z = generate_wave();
interp = jengaStyleAverage(Z, [16 1 20]);
%interp = jengaStyleAverageNew(Z, [16 1 20]);
disp(Z);
mplay(render(Z,interp,'struct'))
