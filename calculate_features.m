function features = calculate_features(inputData)
% CALCULATE_FEATURES - function containing all necessary steps for the
%                      calculation of the features.
%
% --- INPUT ---
%   inputData   - RxC matrix with R frames with the length of C.
%
% --- OUTPUT ---
%   features    - struct containing R elements with 12 fields each.
%
% ------------------------------------------------
% Version 1.4.1.
% Created       - 18.06.2016 Alexander Kramlich
% Last modified - 30.06.2016 Alexander Kramlich
% ------------------------------------------------

R = size(inputData, 1);

featureNames = feature_names();
N = size(featureNames, 2);
features = cell2struct(cell([R,N]), featureNames, 2);

Fs = 50;
highpassFilter = highpassfilter();

for r=1:R
    frame = inputData(r,:);
    
    %% Raw-signal-based features
    features(r).mean = mean(frame);
    features(r).variance = var(frame);              % second central moment
    features(r).skewness = skewness(frame);         % third central moment
    features(r).kurtosis = kurtosis(frame);         % fourth central moment

    %% (P)ower-(S)pectral-(D)ensity-based features
    filtered_frame = filter(highpassFilter, frame);
    psd_frame = pwelch(filtered_frame, 64, 32, 128, Fs);
    [pks, locs] = findpeaks(psd_frame, 'SortStr', 'descend');
    % height of the highest peak
    features(r).peakPSD = pks(1);
    % location of the highest peak
    features(r).peaklocationPSD = locs(1)*((Fs/2)/64);

    features(r).meanPSD = mean(psd_frame);
    features(r).variancePSD = var(psd_frame);       % second central moment
    features(r).skewnessPSD = skewness(psd_frame);  % third central moment
    features(r).kurtosisPSD = kurtosis(psd_frame);  % fourth central moment
    % energy of the signal calculated from its PSD
    features(r).energyPSD = sum(psd_frame.^2);

    total = sum(psd_frame);
    sum_temp = 0;
    for k=1:(64+1)
        sum_temp = sum_temp + psd_frame(k);
        if sum_temp >= 0.5*total
            break
        end
    end
    % centroid of the PSD
    features(r).centroidlocationPSD = (k-1) * (Fs/2)/64;
end