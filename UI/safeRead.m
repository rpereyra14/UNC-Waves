
function [Author, DimY, DimZ, DimT, WaveData] = safeRead(metaFilename)
%% Reads a metadata file and establishes default values if metadata is not present

paramMap = readWaveMetadata(metaFilename);

if paramMap.isKey('Author')
    Author = paramMap('Author');
else
    Author = '';
    fprintf('No author specified.\n');
end

if paramMap.isKey('DimY')
    DimY = paramMap('DimY');
else
    DimY = '';
    fprintf('No number of data points in Y direction specified.\n');
end

if paramMap.isKey('DimZ')
    DimZ = paramMap('DimZ');
else
    DimZ = '';
    fprintf('No number of data points in Z direction specified.\n');
end

if paramMap.isKey('DimT')
    DimT = paramMap('DimT');
else
    DimT = '';
    fprintf('No number of data points in T direction specified.\n');
end

if paramMap.isKey('WaveData')
    WaveData = paramMap('WaveData');
else
    WaveData = '';
    fprintf('No file for wave data specified.\n');
end

