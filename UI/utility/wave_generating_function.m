function [z] = wave_generating_function(x,y,t)

%noise = t/3;
%x = random('uniform',x-noise,x+noise,1);
%y = random('uniform',y-noise,y+noise,1);
%t = random('uniform',0,t,1);


modifier = sin(2*pi*t/20);
%modifier = 1;

%x= mod(round(x-(50*t/20)+50),50);
%y= mod(round(y-(50*t/20)+50),50);

z = ...
    ...%inline(...
        modifier*(  ...
                    ... 
        gaussmf(x,[5+modifier*10 15])*gaussmf(y,[9+modifier*10 35]) ...
        -gaussmf(x,[3+modifier*10 30])*gaussmf(y,[3+modifier*10 30])...
   ... )...
);


end
