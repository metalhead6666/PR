function [target, predicted] = main(handles)
    clc

    %Calculates amount of train and test data
    [len,~] = size(handles.data);
    train_amount = int32((str2num(get(handles.edit_train,'String'))/100)*len);
    test_amount = len-train_amount;

    %Separates train and test values in input data
    train_data = handles.selected_columns(1:train_amount,:);
    test_data = handles.selected_columns(train_amount+1:len,:);
    all_data = handles.selected_columns;
    [~, n_features] = size(all_data);

    %Separates train and test values in target data
    train_target = handles.target(1:train_amount,:);
    test_target = handles.target(train_amount+1:len,:);
    all_target = handles.target;

    %Scaling before PCA/LDA

    if handles.scaling_choice == 1
        train_data = normc(train_data);
    end

    %TODO: Check PCA/LDA

    if handles.ft_red_choice == 1 && handles.dimension_chosen < n_features        
        model = my_pca(all_data', handles.dimension_chosen);
        train_data = my_linproj(train_data', model);
        test_data = my_linproj(test_data', model);
        train_data = train_data';
        test_data = test_data';
    elseif handles.ft_red_choice == 2 && handles.dimension_chosen < n_features
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
        %disp(size(train_data));
        %disp(size(train_target));
        %train_data = train_data';
        svmStruct = fitcsvm(train_data, train_target);
        results = predict(svmStruct, test_data);
        results = results';
    elseif handles.class_choice == 3
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