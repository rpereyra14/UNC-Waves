% Once XUnit is installed, you can run this test by navigating to this directory and typing "runtests" into your MATLAB prompt.
%
% Output Variable name should be "test_suite"
% | Make sure the test name either begins or ends with "test"
% | |
% | |
function test_suite = testMyFunctions
initTestSuite;
 
% Contains tests for:
% average.m - Check
% writeWaveMetadata.m - Check
% readWaveMetadata.m - Check
% safeRead.m - Check
% exportToLewos.m - Check


% Testing: average.m

function [] = testAverage_Y1
inputWave = [-2 3 5 7 -1 2 0 4 -3 9 -1 -7];
inputWave = reshape(inputWave, 2, 2, 3);

expectedOut = [.5 6 .5 2 3 -4];
expectedOut = reshape(expectedOut, 1, 2, 3);

assertEqual(average(inputWave, [1 2 3]), expectedOut); 

function [] = testAverage_Y2
inputWave = [-1.5 .5 2.5 1.5 1 4.5 0 -1 -5.5 1.5 2.5 6 -1.5 -2.5 4 -3.5 1 5.5 5 -4.5];
inputWave = reshape(inputWave, 4, 5, 1);

expectedOut = [-1 1.3 2 1 -1.6 3.3 1 1.8 -3.1 -.9 3.4 .3 .5 3.9 4.8 -4.3];
expectedOut = reshape(expectedOut, 4, 4, 1);

assertEqual(average(inputWave, [4 4 1]), expectedOut); 

function [] = testAverage_Y3
inputWave = [-2 9 3 -6 -1 4 0 7 -6 -3 3 4 0 2 4 -9 1 6 7 -5 -1 -8 2 9 3 5 0 -9 -5 6 2 8 -3 -7 4 2 1 5 3 -4];
inputWave = reshape(inputWave, 4, 5, 2);

expectedOut = [.75 6 -3.75 .25 2 5.25 -5.25 0 3.75 .5 3 -5.75 2.25 6.5 -2 -2.75 -3 7.25 3.5 2.5 -6.75 -2.25 4 6.5 -4 -1.5 2.5 2 4 -2.25];
expectedOut = reshape(expectedOut, 3, 5, 2);

assertEqual(average(inputWave, [3 5 2]), expectedOut); 

function [] = testAverage_Z1
inputWave = [2 8 7 -2 -3 9 4 -6 3 0 -1 6 -4 8 -5 2];
inputWave = reshape(inputWave, 2, 4, 2);

expectedOut = [3.25 5.5 2 3.5 2.25 -2.25 2 1.5 -2.5 7 -4.75 3.5];
expectedOut = reshape(expectedOut, 2, 3, 2);

assertEqual(average(inputWave, [2 3 2]), expectedOut); 

function [] = testAverage_Z2
inputWave = [-1 1.3 2 1 -1.6 3.3 1 1.8 -3.1 -.9 3.4 .3 .5 3.9 4.8 -4.3];
inputWave = reshape(inputWave, 4, 4, 1);

expectedOut = [-.425 1.65 1.25 -.375 2.15 1.6 -2.55 1.25 1.075 1.35 4.35 -2.025];
expectedOut = reshape(expectedOut, 3, 4, 1);

assertEqual(average(inputWave, [3 4 1]), expectedOut); 

function [] = testAverageT1
inputWave = [-1 3 5 9 0 -7 1 9 8 1 0 6 4 6 7 2 1 7];
inputWave = reshape(inputWave, 2, 3, 3);

expectedOut = [-1 3 5 9 0 -7 1 9 8 1 0 6 4 6 7 2 1 7];
expectedOut = reshape(expectedOut, 2, 3, 3);

assertEqual(average(inputWave, [2 3 3]), expectedOut);

function [] = testAverage_YZ1
inputWave = [-2 9 3 -6 -1 4 0 7 -6 -3 3 4 0 2 4 -9 1 6 7 -5 -1 -8 2 9 3 5 0 -9 -5 6 2 8 -3 -7 4 2 1 5 3 -4];
inputWave = reshape(inputWave, 4, 5, 2);

expectedOut = [.65 5.2 -1.95 -1.95 1.2 4.65 -1.8 1.8 -1.95 1.9 5.8 -2.75 -1.5 -1.9 4.45 1.2 3.1 -1.45 -3.3 .7 4.1 .8 2.9 -1.3];
expectedOut = reshape(expectedOut, 3, 4, 2);

assertEqual(average(inputWave, [3 4 2]), expectedOut); 




% Testing: writeWaveMetadata.m and readWaveMetadata.m:
% Tests with complete data given to write and read.

function [] = testWrite_CompleteData

initNoFiles = length(fopen('all'));

names = {'Author', 'DimT', 'DimY', 'DimZ', 'WaveData'};
values = {'Author_Test', 'DimT_Test', 'DimY_Test', 'DimZ_Test', 'WaveData_Test'};

toWrite = containers.Map(names,values);
file = 'temp.mhd';
writeWaveMetadata(file, toWrite);
paramMap = readWaveMetadata(file);

endNoFiles = length(fopen('all'));
if (initNoFiles ~= endNoFiles)
    error('testWrite_CompleteData:fileOpen', 'File left open.')
end

% Test existence of each param

if paramMap.isKey('Author')
    if ~strcmp(toWrite('Author'), paramMap('Author'))
        error('testWrite_CompleteData:wrongAuthor', 'Author exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noAuthor', 'Author does not exist: not written/read.')    
end

if paramMap.isKey('DimT')
    if ~strcmp(toWrite('DimT'), paramMap('DimT'))
        error('testWrite_CompleteData:wrongDimT', 'DimT exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noDimT', 'DimT does not exist: not written/read.')    
end

if paramMap.isKey('DimY')
    if ~strcmp(toWrite('DimY'), paramMap('DimY'))
        error('testWrite_CompleteData:wrongDimY', 'DimY exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noDimY', 'DimY does not exist: not written/read.')    
end

if paramMap.isKey('DimZ')
    if ~strcmp(toWrite('DimZ'), paramMap('DimZ'))
        error('testWrite_CompleteData:wrongDimZ', 'DimZ exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noDimZ', 'DimZ does not exist: not written/read.')    
end

if paramMap.isKey('WaveData')
    if ~strcmp(toWrite('WaveData'), paramMap('WaveData'))
        error('testWrite_CompleteData:wrongWaveData', 'WaveData exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noWaveData', 'WaveData does not exist: not written/read.')    
end

delete(file);

function [] = testWrite_IncompleteData

initNoFiles = length(fopen('all'));

names = {'Author', 'WaveData'};
values = {'Author_Test_Again', 'WaveData_Test_Again'};

toWrite = containers.Map(names,values);
file = 'temp.mhd';
writeWaveMetadata(file, toWrite);
paramMap = readWaveMetadata(file);

endNoFiles = length(fopen('all'));
if (initNoFiles ~= endNoFiles)
    error('testWrite_IncompleteData:fileOpen', 'File left open.')
end

% Test existence of each param

if paramMap.isKey('Author')
    if ~strcmp('Author_Test_Again', paramMap('Author'))
        error('testWrite_CompleteData:wrongAuthor', 'Author exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noAuthor', 'Author does not exist: not written/read.')    
end

if paramMap.isKey('WaveData')
    if ~strcmp('WaveData_Test_Again', paramMap('WaveData'))
        error('testWrite_CompleteData:wrongWaveData', 'WaveData exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noWaveData', 'WaveData does not exist: not written/read.')    
end

delete(file);


% Testing: safeRead.m

function [] = testSafeRead

% Expected error messages to console
fprintf('\nSTDOUT EXPECTED OUTPUT:\n');
fprintf('No number of data points in Z direction specified.\n');
fprintf('No file for wave data specified.\n');
fprintf('\nSTDOUT ACTUAL OUTPUT:\n');

initNoFiles = length(fopen('all'));

names = {'Author', 'DimY', 'DimT'};
values = {'Author_Test_Again', 'DimY_Test_Again', 'DimT_Test_Again'};

toWrite = containers.Map(names,values);
file = 'temp.mhd';
writeWaveMetadata(file, toWrite);
[Author, DimY, DimZ, DimT, WaveData] = safeRead(file);

endNoFiles = length(fopen('all'));
if (initNoFiles ~= endNoFiles)
    error('testSafeRead:fileOpen', 'File left open.')
end

% Test existence of each param

if ~strcmp('Author_Test_Again', Author)
    error('testWrite_CompleteData:wrongAuthor', 'Author exists but was not written/read properly.')
end

if ~strcmp('DimT_Test_Again', DimT)
    error('testWrite_CompleteData:wrongDimT', 'DimT exists but was not written/read properly.')
end

if ~strcmp('DimY_Test_Again', DimY)
    error('testWrite_CompleteData:wrongDimY', 'DimY exists but was not written/read properly.')
end

if ~strcmp('', DimZ)
    error('testWrite_CompleteData:wrongDimZ', 'DimZ exists but was not written/read properly.')
end

if ~strcmp('', WaveData)
    error('testWrite_CompleteData:wrongWaveData', 'WaveData exists but was not written/read properly.')
end

delete(file);



% Testing: exportToLewos.m

function [] = testExport

initNoFiles = length(fopen('all'));

load('test_waves.mat');
Z = wave2; % utility function for testing
interp = average(Z, [16 1 20]);
error_bound = 0.001;
filename = 'tmp.txt';

exportToLewos(interp, filename);
retrieved_interpolation = readFromLewos(filename);
success = max(max(retrieved_interpolation-interp)) < error_bound;

delete(filename);

endNoFiles = length(fopen('all'));
if (initNoFiles ~= endNoFiles)
    error('testExport:fileOpen', 'File left open.')
end

assert(success);

