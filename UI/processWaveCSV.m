function [M] = processWaveCSV(fileCSV, dimensions)

M = csvread(fileCSV);
M = M(:)';
if (prod(double(dimensions)) == length(M))
    M = reshape(M, dimensions);
else
    fprintf('Error: Input matrix dimensions do not match wave data.\n');
    M = [];
end