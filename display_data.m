% DISPLAY_DATA.M
%
% ------------------------------------------------
% Version 1.1.0.
% Created       - 13.06.2016 Alexander Kramlich
% Last modified - 17.06.2016 Alexander Kramlich
% ------------------------------------------------

close all

% User input
subjectNumber = 1;

Fs = 50;                                    % Sampling frequency

relevantData = totalaccxtrain(subjecttrain == subjectNumber, 1:64);
relevantLabels = labeltrain(subjecttrain == subjectNumber);
[R,~] = size(relevantData);

color_order = get(groot, 'defaultAxesColorOrder');
figure('Position', [720 300 1200 700])
hold on

p = zeros(1,6);                             % Chart line object which will be used later in the legend
for r=1:R
    t = (1+(r-1)*64:r*64)/Fs;               % Division by sampling frequency Fs in order to convert samples to time
    
    % Plot one row with the color belonging to the corresponding label
    p(relevantLabels(r)) = plot(t, relevantData(r,:), 'Color', color_order(relevantLabels(r),:));
end

xlim([0 t(end)])
title(sprintf('Subject #%g', subjectNumber))
xlabel('Time [s]')
ylabel('totalaccxtrain')
legend(p, activitylabels)
hold off

clear Fs p r R subjectNumber t T