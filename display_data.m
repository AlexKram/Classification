% DISPLAY_DATA.M
%
% ------------------------------------------------
% Version 1.0.0.
% Created       - 13.06.2016 Alexander Kramlich
% Last modified - 13.06.2016 Alexander Kramlich
% ------------------------------------------------

subjectNumber = 1;
dataToPlot = totalaccxtrain;

[R,C] = size(bodyaccxtrain);
T = sum(subjecttrain == subjectNumber);
t = linspace(0, T*C/50, T*C);

color_order = get(groot, 'defaultAxesColorOrder');
figure
hold on

for r=1:R
    plot(1+(r-1)*64:r*64, totalaccxtrain(r,1:64), 'Color', color_order(labeltrain(r),:))
    if subjecttrain(r) ~= 1
        break;
    end
end
title('Subject #1')
hold off