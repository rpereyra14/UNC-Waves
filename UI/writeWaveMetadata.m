function [] = writeWaveMetadata(fileToWrite, textToWrite)

fid = fopen(fileToWrite, 'w');
paramName = keys(textToWrite);
paramValue = values(textToWrite);

if (fid >= 0)
    for k = 1:textToWrite.Count
        fprintf(fid, '%s %s\n', paramName{k}, paramValue{k});
    end
    fclose(fid);
else
    fprintf('Error: Could not open file to write.');
    exit;
end
