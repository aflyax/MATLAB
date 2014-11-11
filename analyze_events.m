function [avg_onset_x, avg_onset_y, avg_peak_x, avg_peak_y] = analyze_events()
    %analyze_events
%   %   Finds onset and peak of traces from a selected fig.
    %   Click on a figure; call the function. Peaks and onsets are shown on
    %   a figure. (Individual points = circles; avg's = squares. Red =
    %   average trace.) The output of the function is the average of the
    %   individual events, not of the average trace. The called find_peaks
    %   function is below.


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
    xlim([data_start, data_finish])
    grey=[.8,.8,.8];

    for i = 1 : size (fig_y)
        base = mean (fig_y{i}(data_start:stim_start));
        data_sweeps{i} = fig_y{i} - base;
        [data_peaks_y(i) data_peaks_x(i)] = min (data_sweeps{i}(stim_start:peak_end));

        %% finding the peak    

        %     data_peaks_x(i) = find (data_sweeps{i} == data_peaks_y(i));
        data_peaks_x(i) = data_peaks_x(i) + stim_start;

        plot (data_sweeps{i}, 'Color', grey);
        plot (data_peaks_x(i), data_peaks_y(i), 'ok');


        %% finding the onset

        [event_onset_x(i), event_onset_y(i)] = find_onset (data_sweeps{i}, pos);
        plot (event_onset_x(i), event_onset_y(i), '*r');
    end

    %% average and plot data

    % figure(); hold on;

    avg_peak_x = mean (data_peaks_x);
    avg_peak_y = mean (data_peaks_y);

    plot (avg_peak_x, avg_peak_y, 'bs');


    avg_onset_x = nanmean (event_onset_x);
    avg_onset_y = nanmean (event_onset_y);

    plot (avg_onset_x, avg_onset_y, 'ks');


    dim = ndims(data_sweeps{2});         %# Get the number of dimensions for your arrays
    M = cat(dim+1,data_sweeps{:});            %# Convert to a (dim+1)-dimensional matrix
    y_mean = mean(M,dim+1);      %# Get the mean across arrays

    plot (y_mean, 'r');

    [y_mean_peak_y, y_mean_peak_x] = min (y_mean(stim_start:peak_end));
    y_mean_peak_x = y_mean_peak_x + stim_start;

    plot (y_mean_peak_x, y_mean_peak_y, 'or');


    [y_mean_onset_x y_mean_onset_y] = find_onset(y_mean, pos);
    plot (y_mean_onset_x, y_mean_onset_y, '^r', 'MarkerFaceColor',[.49 1 .63]);


    %% results output

%     avg_onset_x
%     avg_onset_y
%     avg_peak_x
%     avg_peak_y

    y_mean_onset_x
    y_mean_onset_y
    y_mean_peak_x
    y_mean_peak_y
       

end


function [ output_x, output_y ] = find_onset(input_data, pos)
%FIND_ONSET Finds onset of an event
%   pos = -1 --> inward event
%   input_data = trace to be analyzed
    
    stim_start = 2000;
    peak_end = 2110;
    data_start = 1900;
    data_finish = 2600;
    
    smooth_deg = 0.001;

    data_pos = pos * input_data;
    d_smooth = smooth (data_pos, smooth_deg, 'loess');
        
    diff_s = diff (d_smooth);
    min_diff = std (diff_s(data_start:stim_start));
    
    [y_max x_max] = max (diff_s (stim_start:peak_end));
    x_max = x_max + stim_start;
    
    diff_cut = diff_s (stim_start:x_max);
    rev_diff_cut = flipud (diff_cut);
         
    rev_x = find (rev_diff_cut < min_diff);
    onset_x = size (rev_diff_cut) - rev_x(1,1) + stim_start;
    onset_x = onset_x(1,1);
    
    output_x = onset_x;
    output_y =  input_data(onset_x);
    
    grey=[.8,.8,.8];
    
    
%     figure; hold on; plot (input_data, 'Color', grey);
%     plot (d_smooth*pos, 'r');
%     plot (onset_x, input_data(onset_x), 'or');
%     xlim([data_start, data_finish]);
    
end


