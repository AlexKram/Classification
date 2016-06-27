function features = calculate_features(frame, my_filter)
% CALCULATE_FEATURES
%
% ------------------------------------------------
% Version 1.0.0.
% Created       - 18.06.2016 Alexander Kramlich
% Last modified - 18.06.2016 Alexander Kramlich
% ------------------------------------------------
            
featureNames = feature_names();
features = cell2struct(cell(size(featureNames)), featureNames, 2);

features.mean = mean(frame);
features.variance = var(frame);              % second central moment
features.skewness = skewness(frame);         % third central moment
features.kurtosis = kurtosis(frame);         % fourth central moment

Fs = 50;
filtered_frame = filter(my_filter, frame);
psd_frame = pwelch(filtered_frame, 64, 32, 128, Fs);
[pks, locs] = findpeaks(psd_frame, 'SortStr', 'descend');
features.peakPSD = pks(1);
features.peaklocationPSD = locs(1)*((Fs/2)/64);

features.meanPSD = mean(psd_frame);
features.variancePSD = var(psd_frame);
features.skewnessPSD = skewness(psd_frame);
features.kurtosisPSD = kurtosis(psd_frame);

features.energyPSD = sum(psd_frame.^2);
 
sum_temp = 0;
for k=1:(64+1)
    sum_temp = sum_temp + psd_frame(k).^2;
    if sum_temp >= 0.5*features.energyPSD
        break
    end
end
features.centroidlocationPSD = (k-1) * (Fs/2)/64;