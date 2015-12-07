function y = nsp2_filter(x)

averaged = zeros(length(x));
averaged(1) = (x(1)+x(2)+x(3))/3;
averaged(2) = (x(1)+x(2)+x(3)+x(4))/4;
for i = 3:length(x)-2
    averaged(i) = (x(i)+x(i-1)+x(i-2)+x(i+1)+x(i+2))/5;
end
%averaged(length(x))=(x(length(x))+x(length(x)-1)+x(length(x)-2))/3;
averaged(length(x)-1)=(x(length(x))+x(length(x)-1)+x(length(x)-2)+x(length(x)-3))/4;

y = averaged;