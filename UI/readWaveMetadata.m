function [paramMap] = readWaveMetadata(filename)
[paramName, paramValue] = textread('samplewave.mhd','%s%s');
paramMap = containers.Map(paramName, paramValue);
