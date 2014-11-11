function [ output_args ] = find_onset(input_data, pos)
%FIND_ONSET
    
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
    
    output_args = [onset_x input_data(onset_x)];
    
    grey=[.8,.8,.8];
    figure; hold on; plot (input_data, 'Color', grey);
    plot (d_smooth*pos, 'r');
    plot (onset_x, input_data(onset_x), 'or');
    xlim([data_start, data_finish]);
    
end

