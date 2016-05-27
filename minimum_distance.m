function results = minimum_distance(test_data, average)

    [len,~] = size(test_data);

    results = zeros(1,len);
    for i=1 : len
        %disp(test_data(i,:));
        %disp(average(:,1));
        results(i) = euclidean(test_data(i,:),average);
    end

end