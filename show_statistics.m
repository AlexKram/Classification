% SHOW_STATISICS - Script for the calculation and demonstration of the
%                  boxplots for each feature.
%
% ------------------------------------------------
% Version 2.1.1.
% Created       - 18.06.2016 Alexander Kramlich
% Last modified - 30.06.2016 Alexander Kramlich
% ------------------------------------------------

close all

%% Boxplots of the features by classes
featureNames = feature_names();
                   
% Calculation of the features
features = calculate_features(totalaccxtrain);

f = figure('Position', [300 280 750 600]);
tgroup = uitabgroup(f);

K = length(featureNames);
t = zeros(1,K);
t_ax = zeros(1,K);

for k=1:K
    t(k) = uitab(tgroup, 'Title', featureNames{k});
    t_ax(k) = axes('Parent', t(k));
    boxplot([features.(featureNames{k})], labeltrain, 'Labels', activitylabels)
    set(t_ax(k), 'XTickLabelRotation',45)
end

clear f featureNames k K r R t t_ax tgroup3