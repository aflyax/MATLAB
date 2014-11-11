%% get the data, init constants

clear all;

data_sweeps = {};

h = findobj(gca,'Type','line');
fig_x=get(h,'Xdata');
fig_y=get(h,'Ydata');

data_start = 1900;
stim_start = 2000;
data_finish = 2600;
peak_end = 2110;

min_diff = 0.7;
pos = -1; %invert the value for positive events
smooth_deg = 0.005;


%% subtract baseline and get individual traces into data_sweeps
% find peak at min (stimulus start : peak_end)

figure; hold on;
grey=[.8,.8,.8];

for i = 1 : size (fig_y)
    base = mean (fig_y{i}(data_start:stim_start));
    data_sweeps{i} = fig_y{i} - base;
    [data_peaks_y(i) data_peaks_x(i)] = min (data_sweeps{i}(stim_start:peak_end));

    %% finding the peak    
    
    %     data_peaks_x(i) = find (data_sweeps{i} == data_peaks_y(i));
    data_peaks_x(i) = data_peaks_x(i) + stim_start;
    plot (data_sweeps{i}, 'Color', grey);
    plot (data_peaks_x(i), data_peaks_y(i), 'ob');
    
    
    %% finding the onset
    
    data_pos = pos * data_sweeps{i};
    
    d_smooth = smooth (data_pos, smooth_deg, 'loess');
    diff_s = diff (d_smooth);
    
    min_diff = std (diff_s(data_start:stim_start));
    
     
    diff_pts = find (diff_s (stim_start:peak_end) > min_diff);
    
    if diff_pts
        event_onset_x (i) = diff_pts(1,1) + stim_start;
        event_onset_y (i) = data_sweeps{i}(event_onset_x(i));

        plot (event_onset_x (i), event_onset_y (i), 'ko');
    else
        event_onset_x (i) = nan;
        event_onset_y (i) = nan;
    end
end

avg_peak_x = mean (data_peaks_x);
avg_peak_y = mean (data_peaks_y);

plot (avg_peak_x, avg_peak_y, 'bs');

avg_onset_x = nanmean (event_onset_x);
avg_onset_y = nanmean (event_onset_y);

plot (avg_onset_x, avg_onset_y, 'ks');


%% plotting the data and the average trace

dim = ndims(data_sweeps{2});         %# Get the number of dimensions for your arrays
M = cat(dim+1,data_sweeps{:});            %# Convert to a (dim+1)-dimensional matrix
y_mean = mean(M,dim+1);      %# Get the mean across arrays

plot (y_mean, 'r');

[y_mean_peak_y y_mean_peak_x] = min (y_mean(stim_start:peak_end));
y_mean_peak_x = y_mean_peak_x + stim_start;

% y_mean_peak_x = find (y_mean==y_mean_peak_y);



plot (y_mean_peak_x, y_mean_peak_y, 'or');

%     data_pos = pos * y_mean(stim_start:data_finish);
    
    data_pos = pos * y_mean();
    
    d_smooth = smooth (data_pos, smooth_deg, 'loess');
    diff_s = diff (d_smooth);
    
    min_diff = std (diff_s(data_start:stim_start));
    
    diff_pts = find (diff_s > min_diff);
    
    event_onset_x = diff_pts(1,1) + stim_start;
    event_onset_y = y_mean(event_onset_x);
    
    plot (event_onset_x, event_onset_y, 'rs');

%% set axis limits

xlim([data_start, data_finish])