function [F] = readFromLewos(fileName)

    file = fopen(fileName,'r');
    k = 1;
    tline = fgets(file);
    while ischar(tline)
        
       nums = sscanf(tline, '%d %d %d %f',inf);
        F(nums(2),nums(1),nums(3)) = nums(4);
        tline = fgets(file);
        k=k+1;
    end
    fclose(file);
    

end