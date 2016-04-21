function main(handles)

%Calculates amount of train and test data
[len,~] = size(handles.data);
train_amount = int32((str2num(get(handles.edit_train,'String'))/100)*len);
test_amount = len-train_amount;

%Separates train and test values in input data
train_data = handles.selected_columns(1:train_amount,:);
test_data = handles.selected_columns(train_amount+1:len,:);

%Separates train and test values in target data
train_target = handles.target(1:train_amount,:);
test_target = handles.target(train_amount+1:len,:);

%TODO: Check Scaling

%TODO: Check PCA/LDA
train_data = train_data';

[~, n_dimensions] = size(handles.selected_columns);

%Calculate mean for each class
average = zeros(n_dimensions,2);
for i=1 : n_dimensions
    average(i,1) = mean(train_data(i, train_target==0));
    average(i,2) = mean(train_data(i, train_target==1));
end

%TODO Euclidean Distance to Classify

%TODO Compare?


end