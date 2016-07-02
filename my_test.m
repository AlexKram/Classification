%%
subjectNumber = 1;
rowNumber = zeros(1,3);
for k=1:3
    rowNumber(k) = datasample(find(labeltrain(subjecttrain == subjectNumber) == k),1);
end

M = 1;
C = (M+1)*64;
rawSignal = zeros(3, C);
for k=1:3
    rawSignal(k,:) = reshape(bodygyroxtrain(rowNumber(k):rowNumber(k)+M,1:64)', 1, []);
end

%% Filtering
my_filter = highpassfilter();
filteredSignal = zeros(3, C);
for k=1:3
    filteredSignal(k,:) = filter(my_filter, rawSignal(k,:));
end

%filtered_signal = raw_signal - mean(raw_signal);

%% Plot filtered signals
close all
figure('Position', [0 0 900 700])
for k=1:3
    subplot(3,1,k)
    plot(filteredSignal(k,:))
    xlim([0 C])
    title(activitylabels{k})
    xlabel('Samples')
end

%% Calculation of the PSD
Fs = 50;
psdSignal = zeros(3,64+1);
for k=1:3
    [psdSignal(k,:), f] = pwelch(filteredSignal(k,:), 64, 32, 128, Fs);
end

%% Plot PSD of the signals
figure('Position', [0 0 900 700])
for k=1:3
    subplot(3,1,k)
    plot(f, psdSignal(k,:))
    %findpeaks(psdSignal(k,:))
    title(activitylabels{k})
    xlabel('Frequency [Hz]')
    ylabel('PSD')
end

%%
Fs = 50;
my_signal = bodygyroxtrain(200,:);
[my_psd, f] = pwelch(my_signal, 64, 32, 128, Fs);

my_sum = 0;
my_total = sum(my_psd);
for k=1:(64+1)
    my_sum = my_sum + my_psd(k);
    if my_sum >= 0.5*my_total
        break
    end
end

clear C f filteredSignal Fs k M my_filter my_psd my_signal my_sum my_total psdSignal rawSignal rowNumber subjectNumber 

%%
% lp_filter = lowpassfilter();
% my_index = 111;
% figure
% subplot(3,1,1)
%     hold on
%     plot(bodygyroxtrain(my_index,:))
%     plot(filter(lp_filter, bodygyroxtrain(my_index,:)))
%     xlim([0 128])
%     hold off
% subplot(3,1,2)
%     hold on
%     plot(bodygyroxtrain(my_index,:))
%     plot(filter(lp_filter, bodygyroytrain(my_index,:)))
%     xlim([0 128])
%     hold off
% subplot(3,1,3)
%     hold on
%     plot(bodygyroxtrain(my_index,:))
%     plot(filter(lp_filter, bodygyroztrain(my_index,:)))
%     xlim([0 128])
%     hold off