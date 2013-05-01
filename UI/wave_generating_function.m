function [x] = wave_generating_function(y,z,t)

%noise = t/3;
%x = random('uniform',x-noise,x+noise,1);
%y = random('uniform',y-noise,y+noise,1);
%t = random('uniform',0,t,1);


modifier = sin(2*pi*t/70);
%modifier = 1;

%x= mod(round(x-(50*t/20)+50),50);
%y= mod(round(y-(50*t/20)+50),50);

x = ...
    ...%inline(...
        5*modifier*(  ...
                    ... 
        gaussmf(y,[5+modifier*10 3])*gaussmf(z,[9+modifier*10 3]) ...
        ...%-gaussmf(x,[3+modifier*10 30])*gaussmf(y,[3+modifier*10 30])...
   ... )...
);


end
