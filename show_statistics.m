% SHOW_STATISICS
%
% ------------------------------------------------
% Version 1.0.0.
% Created       - 18.06.2016 Alexander Kramlich
% Last modified - 18.06.2016 Alexander Kramlich
% ------------------------------------------------

close all

numberOfBins = 20;
selectedLabel1 = 2;
selectedLabel2 = 3;

index1 = find(labeltrain == selectedLabel1, 1, 'first');
index2 = find(labeltrain == selectedLabel2, 1, 'first');

figure('Position', [360 500 800 400])
subplot(1,2,1)
histogram(totalaccxtrain(index1,:), numberOfBins)
subplot(1,2,2)
histogram(totalaccxtrain(index2,:), numberOfBins)