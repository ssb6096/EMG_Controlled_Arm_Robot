clc;
clear all;
close all;

sam_freq = 200;

%%%%%%%%%%%%%%%%%%%%LOAD TRAIN DATA%%%%%%%%%%%%%%%%%%%%%%

%train_data1 = load_xdf('D:\Studies\Spring19\Biorobotics\Project\Code\trial\trialv4.xdf');
train_data2 = load_xdf('itrialv1.xdf');

%%%%%%%%%%%%%%%%%%%%LOAD TEST DATA%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%LOAD GESTURE%%%%%%%%%%%%%%%%%%%%

%gesturedata1_10 = double(train_data1{1, 1}.time_series);
gesturedata2_10 = double(train_data2{1, 2}.time_series);
%gesturedata1_8 = gesturedata1_10(2:9,:);
gesturedata2_8 = gesturedata2_10(2:9,:);

%labels_train1 = train_data1{1, 2}.time_series;  
labels_train2 = train_data2{1, 1}.time_series;  



%%%%%%%%%%%%%%%%%%%%%%%LOAD TIME STAMPS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%gesture_time1 = train_data1{1, 1}.time_stamps;
gesture_time2 = train_data2{1, 2}.time_stamps;

%%%%%%%%%%%%%%%%%%LOAD KEYBOARD TIME STAMP%%%%%%%%%%%%%%%%%%%%%%%
%keytimegesture1 = train_data1{1, 2}.time_stamps;
keytimegesture2 = train_data2{1, 1}.time_stamps;

%%%%%%%%%%%%%%PREPROCESS DATA%%%%%%%%%%%%%%%%%%%%%%%%%
%[data_processed_train1 data_features_train1 feature_label_train1] = preprocess_training_data(gesturedata1_8, gesture_time1, keytimegesture1, sam_freq, labels_train1, 1);

[data_processed_train2 data_features_train2 feature_label_train2] = preprocess_training_data_class1(gesturedata2_8, gesture_time2, keytimegesture2, sam_freq, labels_train2, 2);
[data_processed_train2_class2 data_features_train2_class2 feature_label_train2_class2] = preprocess_training_data_class2(gesturedata2_8, gesture_time2, keytimegesture2, sam_freq, labels_train2, 2);
%train1 = [data_features_train1, feature_label_train1];
train2class1 = [data_features_train2, feature_label_train2];
train2class2 = [data_features_train2_class2, feature_label_train2_class2];

%train = [train1;train2];

c1 = LDAclassifier_class1(train2class1);
%yfitc1 = c1.predictFcn(data_features_test);
c2 = LDAclassifier_class2(train2class2);
%yfitc2 = c2.predictFcn(data_features_test);
