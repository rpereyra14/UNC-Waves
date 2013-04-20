function [M] = processWaveCSV(fileCSV, dimensions)

M = csvread(fileCSV);
M = M(:)';
M = reshape(M, dimensions);