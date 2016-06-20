% SHOW_STATISICS
%
% ------------------------------------------------
% Version 2.0.0.
% Created       - 18.06.2016 Alexander Kramlich
% Last modified - 19.06.2016 Alexander Kramlich
% ------------------------------------------------

close all

%% Boxplots of the features by classes
[R,~] = size(totalaccxtrain);

% Preallocation of the array of structs
features(1:R) = struct('mean', [],...
                       'variance', [],...
                       'skewness', [],...
                       'kurtosis', []);
                   
% Calculation of the features
for r=1:R
    features(r) = calculate_features(totalaccxtrain(r,:));
end

f = figure('Position', [300 280 750 600]);
tgroup = uitabgroup(f);

featureNames = fieldnames(features);

K = length(featureNames);
t = zeros(1,K);
t_ax = zeros(1,K);

for k=1:K
    t(k) = uitab(tgroup, 'Title', featureNames{k});
    t_ax(k) = axes('Parent', t(k));
    boxplot([features.(featureNames{k})], labeltrain, 'Labels', activitylabels)
    set(t_ax(k), 'XTickLabelRotation',45)
end

clear f featureNames features k K r R t t_ax tgroup

%% Histograms (maybe)
% numberOfBins = 20;
% selectedLabel1 = 2;
% selectedLabel2 = 3;
% 
% index1 = find(labeltrain == selectedLabel1, 1, 'first');
% index2 = find(labeltrain == selectedLabel2, 1, 'first');
% 
% figure('Position', [360 500 800 400])
% subplot(1,2,1)
% histogram(totalaccxtrain(index1,:), numberOfBins)
% subplot(1,2,2)
% histogram(totalaccxtrain(index2,:), numberOfBins)