Z = generate_wave();
interp = jengaStyleAverage(Z, [16 1 20]);
mplay(render(Z,interp,'struct'))
