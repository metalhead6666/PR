function [target, predicted] = main(handles)
    clc

    %Calculates amount of train and test data
    train_percentage = str2double(get(handles.edit_train,'String')) / 100;
    
    [len, ~] = size(handles.data);
    handles.number_sel = int32(str2double(get(handles.number_sel, 'String')));
    
    if handles.selected_choice == 1
        index_one = find(handles.data(:,end) == 1);
        index_zero = find(handles.data(:,end) == 0);
        [len_one, ~] = size(index_one);
        [len_zero, ~] = size(index_zero);
        len_one_1 = int32((1 - train_percentage) * len_one);
        len_one = int32(train_percentage * len_one);
        len_zero = int32(train_percentage * len_zero);
        
        train_data = zeros(len_one + len_zero, handles.number_sel);
        test_data = zeros(len - (len_one + len_zero), handles.number_sel);
        
        train_data(1:len_one, :) = handles.data(index_one(1:len_one), 1:handles.number_sel);
        train_data(len_one+1:end, :) = handles.data(index_zero(1:len_zero), 1:handles.number_sel);
        
        test_data(1:len_one_1, :) = handles.data(index_one(len_one+1:end), 1:handles.number_sel);
        test_data(len_one_1+1:end, :) = handles.data(index_zero(len_zero+1:end), 1:handles.number_sel);
        
        all_data = [train_data(:,:); test_data(:,:)];
        
        train_target = zeros(len_one + len_zero, 1);
        test_target = zeros(len - (len_one + len_zero), 1);
        train_target(1:len_one, :) = handles.data(index_one(1:len_one), end);
        train_target(len_one+1:end, :) = handles.data(index_zero(1:len_zero), end);
        
        test_target(1:len_one_1, :) = handles.data(index_one(len_one+1:end), end);
        test_target(len_one_1+1:end, :) = handles.data(index_zero(len_zero+1:end), end);
        
        all_target = [train_target(:,:); test_target(:,:)];
    end

    %Scaling before PCA/LDA

    if handles.scaling_choice == 1
        train_data = normc(train_data);
    end

    %TODO: Check PCA/LDA

    if handles.ft_red_choice == 1        
        model = my_pca(all_data', handles.dimension_chosen);
        train_data = my_linproj(train_data', model);
        test_data = my_linproj(test_data', model);
        train_data = train_data';
        test_data = test_data';
    elseif handles.ft_red_choice == 2
        data_with_target = cell(1);
        data_with_target{1} = all_data';
        data_with_target{2} = all_target';
        model = my_lda(data_with_target, handles.dimension_chosen);
        train_data = my_linproj(train_data', model);
        test_data = my_linproj(test_data', model);
        train_data = real(train_data);
        train_data = train_data';
        test_data = real(test_data);
        test_data = test_data';
    end

    %Scaling after PCA/LDA

    if handles.scaling_choice == 2
        train_data = normc(train_data);
    end

    %Calculate mean for each class
    
    
    if handles.class_choice == 1
        train_data = train_data';

        [n_dimensions, ~] = size(train_data);

        average = zeros(n_dimensions,2);
        for i=1 : n_dimensions
            average(i,1) = mean(train_data(i, train_target==0));
            average(i,2) = mean(train_data(i, train_target==1));
        end
        results = minimum_distance(test_data, average);
    elseif handles.class_choice == 2
        train_data = train_data';
        
        [n_dimensions, ~] = size(train_data);

        average = zeros(n_dimensions,2);
        for i=1 : n_dimensions
            average(i,1) = mean(train_data(i, train_target==0));
            average(i,2) = mean(train_data(i, train_target==1));
        end
        
        [~, columns] = size(average);
        
        [len, col] = size(test_data);
        
        if columns ~= col
            average = average';
        end
        
        results = zeros(1, len);               
        
        for i = 1 : len
            results(i) = mahal(test_data, average);
        end
    elseif handles.class_choice == 3
        %disp(size(train_data));
        %disp(size(train_target));
        %train_data = train_data';
        svmStruct = fitcsvm(train_data, train_target);
        results = predict(svmStruct, test_data);
        results = results';
    elseif handles.class_choice == 4
        %disp(size(train_data));
        %disp(size(train_target));
        %train_data = train_data';
        knnStruct = fitcknn(train_data, train_target);
        results = predict(knnStruct, test_data);
        results = results';       
    end
    

    %size(test_target)
    %size(results)
    %plotconfusion(test_target,results);

    target = test_target';
    %disp(size(target));
    predicted = results;
    %disp(size(predicted));

    %TODO Compare?
end