% PERFORM_CLASSIFICATION
%
% ------------------------------------------------
% Version 1.4.0.
% Created       - 18.06.2016 Alexander Kramlich
% Last modified - 29.06.2016 Alexander Kramlich
% ------------------------------------------------

[R,~] = size(totalaccxtrain);

% Calculation of the features
featuresBodyAccX = calculate_features(totalaccxtrain);
featuresBodyAccY = calculate_features(totalaccxtrain);
featuresBodyAccZ = calculate_features(totalaccxtrain);
featuresBodyGyroX = calculate_features(bodygyroxtrain);
featuresBodyGyroY = calculate_features(bodygyroxtrain);
featuresBodyGyroZ = calculate_features(bodygyroxtrain);

%% Inputs for the Neural Network
featuresMatrix = [cell2mat(struct2cell(featuresBodyAccX))'...
                  cell2mat(struct2cell(featuresBodyAccY))'...
                  cell2mat(struct2cell(featuresBodyAccZ))'...
                  cell2mat(struct2cell(featuresBodyGyroX))'...
                  cell2mat(struct2cell(featuresBodyGyroY))'...
                  cell2mat(struct2cell(featuresBodyGyroZ))'];
featureNames = feature_names({'BodyAccX'; 'BodyAccY'; 'BodyAccZ';...
                              'BodyGyroX'; 'BodyGyroY'; 'BodyGyroZ'});

%% Targets for the Neural Network
labeltrainMatrix = zeros(R,6);
for k=1:6
    labeltrainMatrix(:,k) = (labeltrain == k);
end

%% Train with nnstart
%nnstart

%% Load the Neural Network
path = fileparts(which('perform_classification.m'));
load([path, '\neuralnetwork.mat'])

%% Calculate performance of the Neural Network on the training data
outputClass = zeros(1,R);
for r=1:R
    prediction = net(featuresMatrix(r,:)');
    outputClass(r) = find(prediction == max(prediction), 1);
end

outputClassMatrix = zeros(R,6);
for k=1:6
    outputClassMatrix(:,k) = (outputClass == k);
end

classPerformance = classperf(labeltrain, outputClass);
plotconfusion(labeltrainMatrix', outputClassMatrix')
set(gca, 'XTickLabel', [activitylabels; {'TOTAL'}], 'XTickLabelRotation', 45,...
         'YTickLabel', [activitylabels; {'TOTAL'}], 'YTickLabelRotation', 45);

clear featureNames k labeltrainMatrix...
      outputClass outputClassMatrix path prediction r R