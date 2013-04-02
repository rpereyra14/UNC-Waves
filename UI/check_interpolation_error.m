
%Generate some wave
Z = generate_wave();
  input_size = size(Z);
%Interpolate it down to 4x4 (what our exciters can actually do)
interpolated = interpolateWave(Z,'linear',4,4,20);

%Interpolate it back up to whatever dimensions the original wave was in

deinterpolated = interpolateWave(interpolated,'linear',input_size(1),input_size(2),input_size(3));

%Verify that the deinterpolated wave is always equal to the first
%interpolated wave
%for i = 
error = zeros(input_size);
for i = 1:input_size(1)
    for j = 1:input_size(2)
        for k = 1:input_size(3)
            error(i,j,k) = abs(Z(i,j,k)-deinterpolated(i,j,k));
        end
    end
end

%render(Z,error,'struct');
render(Z,error,'struct');
render(interpolated,deinterpolated,'struct');
