mean = 0;
sigma = 1;
x=-3:0.01:3;

w = zeros(601,4,4);
for i = 1:4
    for j = 1:4
        w(:,i,j) = 1/sqrt(2*pi)/sigma*exp(-(x + i*0.4+0.1*j-mean).^2/2/sigma/sigma);
    end
end

csvwrite('samplewave.csv',w);