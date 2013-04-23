function [M] = processWaveCSV(fileCSV, dimensions)

M = [];

if (exist(fileCSV, 'file'))
    M = csvread(fileCSV);
    M = M(:)';
    if (prod(double(dimensions)) == length(M))
        M = reshape(M, dimensions);
    else
        fprintf('Error: Input matrix dimensions do not match wave data.\n');
        M = [];
    end
else
    fprintf('Error: Could not find file %s', fileCSV);
    return;
end
    