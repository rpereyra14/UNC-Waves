function [] = exportToLewos(interpolated,filename)
    input_size = size(interpolated);
    
    ylen = input_size(1);%16;   %y is the first index
    zlen = input_size(2);%1;    %z is the second index
    tlen = input_size(3);%20;   %t is the third index

    formatSpec = '%d %d %d %f \n';
    fileID = fopen(filename,'w');

    for i = 1:tlen
        for j = 1:zlen
            for k = 1:ylen
                fprintf(fileID,formatSpec,j,k,i,interpolated(k,j,i));
            end
        end
    end
    fclose(fileID);

end