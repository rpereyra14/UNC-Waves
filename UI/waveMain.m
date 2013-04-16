function [Author, ExcitersHeight, ExcitersWidth, TimeSample, WaveData, SaveTo] = waveMain(metaFilename)

paramMap = readWaveMetadata(metaFilename);

if paramMap.isKey('Author')
    Author = paramMap('Author');
else
    Author = '';
    fprintf('No author specified.\n');
end

if paramMap.isKey('ExcitersHeight')
    ExcitersHeight = paramMap('ExcitersHeight');
else
    ExcitersHeight = '';
    fprintf('No number of exiters (h) specified.\n');
end

if paramMap.isKey('ExcitersWidth')
    ExcitersWidth = paramMap('ExcitersWidth');
else
    ExcitersWidth = '';
    fprintf('No number of exciters (w) specified.\n');
end

if paramMap.isKey('TimeSample')
    TimeSample = paramMap('TimeSample');
else
    TimeSample = '';
    fprintf('No number of time samples specified.\n');
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
