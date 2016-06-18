function feature = calculate_features(frame)
% CALCULATE_FEATURES
%
% ------------------------------------------------
% Version 1.0.0.
% Created       - 18.06.2016 Alexander Kramlich
% Last modified - 18.06.2016 Alexander Kramlich
% ------------------------------------------------

feature = struct('mean', [],...
                 'variance', [],...
                 'skewness', [],...
                 'kurtosis', []);

feature.mean = mean(frame);
feature.variance = var(frame);              % second central moment
feature.skewness = skewness(frame);         % third central moment
feature.kurtosis = kurtosis(frame);         % fourth central moment