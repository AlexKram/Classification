% IMPORT_DATASET.M
%
% ------------------------------------------------
% Version 1.0.0.
% Created       - 13.06.2016 Alexander Kramlich
% Last modified - 13.06.2016 Alexander Kramlich
% ------------------------------------------------

current_location = 'Home';
switch current_location
    case 'RZ'
        path = 'U:\Documents\MATLAB';
    case 'Home'
        path = 'C:\Users\Alexander\Documents\MATLAB\Project - Classification';
    otherwise
end

%% Body-Acc
bodyaccxtrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\body_acc_x_train.txt']);
bodyaccytrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\body_acc_y_train.txt']);
bodyaccztrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\body_acc_z_train.txt']);

%% Body-Gyro
bodygyroxtrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\body_gyro_x_train.txt']);
bodygyroytrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\body_gyro_y_train.txt']);
bodygyroztrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\body_gyro_z_train.txt']);

%% Total-Acc
totalaccxtrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\total_acc_x_train.txt']);
totalaccytrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\total_acc_y_train.txt']);
totalaccztrain = importdata([path, '\UCI HAR Dataset\train\Inertial Signals\total_acc_z_train.txt']);
        
%% Labels
% 7352 data frames -> 30 subjects
subjecttrain = importdata([path, '\UCI HAR Dataset\train\subject_train.txt']);
% 6 label numbers -> 6 label names
activitylabels = import_activitylabels(path);
% 7352 data frames -> 6 label numbers
labeltrain = importdata([path, '\UCI HAR Dataset\train\y_train.txt']);

%% Clear temporary variables
clear current_location path