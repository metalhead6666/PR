function value = euclidean(point, class_array)

class_value = zeros(1,2);

for class=1 : 2    
    for i=1 : length(point)
        %disp(point(i));
        %disp(class_array(i,1));
        class_value(class) = class_value(class) + (point(i) - class_array(i,class))^2;
    end
    class_value(class) = sqrt(class_value(class));
    %disp(class_value(class));
end

if(class_value(1)<class_value(2))
    value = 0;
else
    value = 1;
end

end