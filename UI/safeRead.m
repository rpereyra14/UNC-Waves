function [Author, ExcitersHeight, ExcitersWidth, TimeSample, WaveData, SaveTo] = safeRead(metaFilename)

paramMap = readWaveMetadata(metaFilename);

if paramMap.isKey('Author')
    Author = paramMap('Author');
else
    Author = '';
    fprintf('No author specified.\n');
end

if paramMap.isKey('DimY')
    ExcitersHeight = paramMap('DimY');
else
    ExcitersHeight = '';
    fprintf('No number of data points in Y direction specified.\n');
end

if paramMap.isKey('DimZ')
    ExcitersWidth = paramMap('DimZ');
else
    ExcitersWidth = '';
    fprintf('No number of data points in Z direction specified.\n');
end

if paramMap.isKey('DimT')
    TimeSample = paramMap('DimT');
else
    TimeSample = '';
    fprintf('No number of data points in T direction specified.\n');
end

if paramMap.isKey('WaveData')
    WaveData = paramMap('WaveData');
else
    WaveData = '';
    fprintf('No file for wave data specified.\n');
end

if paramMap.isKey('SaveTo')
    SaveTo = paramMap('SaveTo');
else
    SaveTo = '';
    fprintf('No file location specified.\n');
end
