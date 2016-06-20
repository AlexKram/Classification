%%
subjectNumber = 1;
rowNumber = zeros(1,3);
for k=1:3
    rowNumber(k) = datasample(find(labeltrain(subjecttrain == subjectNumber) == k),1);
end

M = 2;
C = (M+1)*64;
rawSignal = zeros(3, C);
for k=1:3
    rawSignal(k,:) = reshape(bodygyroxtrain(rowNumber(k):rowNumber(k)+M,1:64), 1, []);
end

%% Filtering
my_filter = highpass_filter();
filteredSignal = zeros(3, C);
for k=1:3
    filteredSignal(k,:) = filter(my_filter, rawSignal(k,:));
end

%filtered_signal = raw_signal - mean(raw_signal);

%% Plot filtered signals
close all
figure('Position', [700 300 900 700])
for k=1:3
    subplot(3,1,k)
    plot(filteredSignal(k,:))
    xlim([0 C])
    title(activitylabels{k})
    xlabel('Samples')
end

%% Calculation of the PSD
Fs = 50;
%mu = ceil(log2((((M+1)*64)/9)/128));
psdSignal = zeros(3,64+1);
for k=1:3
    [psdSignal(k,:), f] = pwelch(filteredSignal(k,:), 64, 32, 128, Fs);
end

%% Plot PSD of the signals
figure('Position', [700 300 900 700])
for k=1:3
    subplot(3,1,k)
    plot(f, psdSignal(k,:))
    title(activitylabels{k})
    xlabel('Frequency [Hz]')
    ylabel('PSD')
end
    
%% FFT
% Fs = 50;
% L = length(filteredSignalWalking);
% Y = fft(filteredSignalWalking);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% plot(f,P1)