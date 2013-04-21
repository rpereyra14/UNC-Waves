% Once XUnit is installed, you can run this test by navigating to this directory and typing "runtests" into your MATLAB prompt.
%
% Output Variable name should be "test_suite"
% | Make sure the test name either begins or ends with "test"
% | |
% | |
function test_suite = testMyFunctions
initTestSuite;
 
% Contains tests for:
% jengaStyleAverage.m
% writeWaveMetadata.m
% readWaveMetadata.m
% waveMain.m
% waveUI.m

% jengaStyleAverage: Individual dimensions

function [] = testJenga_Z
inputWave = [-2 -4 -1 5 10 -9 6 3 -7 -9 2 7 4 -9 3 4 6 0 6 0 3 0 7 6 -1 -4 2 3 1 9 -1 5 -6 -8 7 -4 -2 -1 5 8 2 4 0 -1 -7];
inputWave = reshape(inputWave, 3, 3, 5);

expectedOut = [-3.4 -2.8 .6 4.8 6.2 -6.6 5.6 3.6 -5.6 -3 1.2 5.4 2.4 -2.6 4.2 2 2 .8 4.2 .6 6.6 -.6 5.8 -1.2 -5.2 2.6 -1.6 -1 -.6 5.8 6.2 2.6 2 -1.6 .6 -6.4];
expectedOut = reshape(expectedOut, 3, 3, 4);

assertEqual(jengaStyleAverage(inputWave, [3 3 4]), expectedOut); 

function [] = testJenga_Y
inputWave = [-2 3 5 7 -1 2 0 4 -3 9 -1 -7];
inputWave = reshape(inputWave, 2, 2, 3);

expectedOut = [.5 6 .5 2 3 -4];
expectedOut = reshape(expectedOut, 1, 2, 3);

assertEqual(jengaStyleAverage(inputWave, [1 2 3]), expectedOut); 

function [] = testJenga_X
inputWave = [2 8 7 -2 -3 9 4 -6 3 0 -1 6 -4 8 -5 2];
inputWave = reshape(inputWave, 2, 4, 2);

expectedOut = [3.25 5.5 2 3.5 2.25 -2.25 2 1.5 -2.5 7 -4.75 3.5];
expectedOut = reshape(expectedOut, 2, 3, 2);

assertEqual(jengaStyleAverage(inputWave, [2 3 2]), expectedOut); 

% jengaStyleAverage: Individual dimensions, then the whole thing at once.

function [] = testJenga_AllStepZ
inputWave = [-2 9 3 -6 -1 4 0 7 -6 -3 3 4 0 2 4 -9 1 6 7 -5 -1 -8 2 9 3 5 0 -9 -5 6 2 8 -3 -7 4 2 1 5 3 -4];
inputWave = reshape(inputWave, 4, 5, 2);

expectedOut = [-1.5 .5 2.5 1.5 1 4.5 0 -1 -5.5 1.5 2.5 6 -1.5 -2.5 4 -3.5 1 5.5 5 -4.5];
expectedOut = reshape(expectedOut, 4, 5, 1);

assertEqual(jengaStyleAverage(inputWave, [4 5 1]), expectedOut); 

function [] = testJenga_AllStepX
inputWave = [-1.5 .5 2.5 1.5 1 4.5 0 -1 -5.5 1.5 2.5 6 -1.5 -2.5 4 -3.5 1 5.5 5 -4.5];
inputWave = reshape(inputWave, 4, 5, 1);

expectedOut = [-1 1.3 2 1 -1.6 3.3 1 1.8 -3.1 -.9 3.4 .3 .5 3.9 4.8 -4.3];
expectedOut = reshape(expectedOut, 4, 4, 1);

assertEqual(jengaStyleAverage(inputWave, [4 4 1]), expectedOut); 

function [] = testJenga_AllStepY
inputWave = [-1 1.3 2 1 -1.6 3.3 1 1.8 -3.1 -.9 3.4 .3 .5 3.9 4.8 -4.3];
inputWave = reshape(inputWave, 4, 4, 1);

expectedOut = [-.425 1.65 1.25 -.375 2.15 1.6 -2.55 1.25 1.075 1.35 4.35 -2.025];
expectedOut = reshape(expectedOut, 3, 4, 1);

assertEqual(jengaStyleAverage(inputWave, [3 4 1]), expectedOut); 

function [] = testJenga_All
inputWave = [-2 9 3 -6 -1 4 0 7 -6 -3 3 4 0 2 4 -9 1 6 7 -5 -1 -8 2 9 3 5 0 -9 -5 6 2 8 -3 -7 4 2 1 5 3 -4];
inputWave = reshape(inputWave, 4, 5, 2);

expectedOut = [-.425 1.65 1.25 -.375 2.15 1.6 -2.55 1.25 1.075 1.35 4.35 -2.025];
expectedOut = reshape(expectedOut, 3, 4, 1);

assertEqual(jengaStyleAverage(inputWave, [3 4 1]), expectedOut); 


% writeWaveMetadata and readWaveMetadata:

% Tests with complete data given to write and read.
% Referenced expected values. (Not hardcoded.)
function [] = testWrite_CompleteData

initNoFiles = length(fopen('all'));

names = {'Author', 'ExcitersHeight', 'ExcitersWidth', 'TimeSample', 'WaveData','SaveTo'};
values = {'Author_Test', 'ExcitersHeight_Test', 'ExcitersWidth_Test', 'TimeSample_Test', 'WaveData_Test','SaveTo_Test'};

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

if paramMap.isKey('ExcitersHeight')
    if ~strcmp(toWrite('ExcitersHeight'), paramMap('ExcitersHeight'))
        error('testWrite_CompleteData:wrongExcitersHeight', 'ExcitersHeight exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noExcitersHeight', 'ExcitersHeight does not exist: not written/read.')    
end

if paramMap.isKey('ExcitersWidth')
    if ~strcmp(toWrite('ExcitersWidth'), paramMap('ExcitersWidth'))
        error('testWrite_CompleteData:wrongExcitersWidth', 'ExcitersWidth exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noExcitersWidth', 'ExcitersWidth does not exist: not written/read.')    
end

if paramMap.isKey('TimeSample')
    if ~strcmp(toWrite('TimeSample'), paramMap('TimeSample'))
        error('testWrite_CompleteData:wrongTimeSample', 'TimeSample exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noTimeSample', 'TimeSample does not exist: not written/read.')    
end

if paramMap.isKey('WaveData')
    if ~strcmp(toWrite('WaveData'), paramMap('WaveData'))
        error('testWrite_CompleteData:wrongWaveData', 'WaveData exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noWaveData', 'WaveData does not exist: not written/read.')    
end

if paramMap.isKey('SaveTo')
    if ~strcmp(toWrite('SaveTo'), paramMap('SaveTo'))
        error('testWrite_CompleteData:wrongSaveTo', 'SaveTo exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noSaveTo', 'SaveTo does not exist: not written/read.')    
end

delete(file);


% Tests with incomplete data given to write and read.
% Hardcoded expected values.
function [] = testWrite_IncompleteData

initNoFiles = length(fopen('all'));

names = {'Author', 'WaveData','SaveTo'};
values = {'Author_Test_Again', 'WaveData_Test_Again','SaveTo_Test_Again'};

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

if paramMap.isKey('SaveTo')
    if ~strcmp('SaveTo_Test_Again', paramMap('SaveTo'))
        error('testWrite_CompleteData:wrongSaveTo', 'SaveTo exists but was not written/read properly.')
    end
else
    error('testWrite_CompleteData:noSaveTo', 'SaveTo does not exist: not written/read.')    
end

delete(file);

% waveMain.m

% waveUI.m



% Sample test functions
% Must begin or end with 'test'
%{
function [] = testFliplrVector
 
in = [1 2 3];
out = fliplr(in);
expected_out = [3 2 1];
 
if ~isequal(out, expected_out)
error('testFliplrVector:notEqual', 'Incorrect output for vector.');
end 

function [] = testFliplrMatrix
 
in = magic(3);
assertEqual(fliplr(in), in(:, [3 2 1]));
%}