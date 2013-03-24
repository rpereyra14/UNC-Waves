function [Author, ErrorBound, InterpolationMethod, WaveFile, wave] = waveMain(metaFilename)

paramMap = readWaveMetadata(metaFilename);

if paramMap.isKey('Author')
    Author = paramMap('Author');
else
    fprintf('No author specified');
end
if paramMap.isKey('ErrorBound')
    ErrorBound = paramMap('ErrorBound');
else
    fprintf('No error bound specified');
end
if paramMap.isKey('InterpolationMethod')
    InterpolationMethod = paramMap('InterpolationMethod');
else
    fprintf('No interpolation method specified');
end
if paramMap.isKey('WaveFile')
    WaveFile = paramMap('WaveFile');
else
    fprintf('No Wave file specified');
end
