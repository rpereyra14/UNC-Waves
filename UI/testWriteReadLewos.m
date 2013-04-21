%testWriteReadLewos

%Configuration of the test
Z = generate_wave;
interp = jengaStyleAverage(Z,[16 1 20]);
error_bound = 0.001;
filename = 'tmp.txt';



%Rest of the test
exportToLewos(interp,filename);
retrieved_interpolation = readFromLewos(filename);
success = max(max(retrieved_interpolation-interp)) < error_bound;
if success
    disp('successfully wrote a file to the format desired by LewOS');
end

assert(success);
delete(filename);
