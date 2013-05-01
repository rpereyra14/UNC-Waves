function [] = exportToLewos(achievable_excitation_pattern,filename)
%% Writes a file called <filename> consisting of the data in <achievable_excitation_pattern> in a format to be read by LewOS


    input_size = size(achievable_excitation_pattern);
    
    ylen = input_size(1);%expected to be 16    %y is the first index
    zlen = input_size(2);%expected to be 1     %z is the second index
    tlen = input_size(3);%no expectation       %t is the third index

    formatSpec = '%d %d %d %f \n';
    fileID = fopen(filename,'w');

    for i = 1:tlen
        for j = 1:zlen
            for k = 1:ylen
                fprintf(fileID,formatSpec,j,k,i,achievable_excitation_pattern(k,j,i));
            end
        end
    end
    fclose(fileID);

end