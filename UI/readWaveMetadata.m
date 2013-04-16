function [paramMap] = readWaveMetadata(filename)

fid = fopen(filename);

if (fid >= 0)
    C = textscan(fid,'%s%s');

    paramName = C{1};
    paramValue = C{2};

    paramMap = containers.Map(paramName, paramValue);

    fclose(fid);
else
    fprintf('Error: Could not open file to read.');
    exit;
end
