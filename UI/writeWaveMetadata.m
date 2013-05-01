function [] = writeWaveMetadata(fileToWrite, textToWrite)
%% Saves wave metadata to file with name <fileToWrite> and content <textToWrite>
fid = fopen(fileToWrite, 'w');
paramName = keys(textToWrite);
paramValue = values(textToWrite);

if (fid >= 0)
    for k = 1:textToWrite.Count
        v = paramValue{k};
        if ((~isempty(strfind(v,' '))) && ~((v(1) == '"') && (v(end) == '"'))) 
            fprintf(fid, '%s "%s"\n', paramName{k}, v);
        else
            fprintf(fid, '%s %s\n', paramName{k}, v);
        end
    end
    fclose(fid);
else
    fprintf('Error: Could not open file to write.\n');
    return;
end
