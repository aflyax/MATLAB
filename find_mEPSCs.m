function output_traces = find_mEPSCs( input_data, start_data, finish_data )
%FIND_MEPSCS Detects mEPSCs and labels them on a graph

data = input_data(start_data:finish_data); %parse data to be analyzeed in

diff_thresh = 2;
amp_thresh = 3;
decay = 30; %% minimum accepted decay x 0.01 msec; decay = 30 => 0.3 msec
% may have to change these values dep. on your data

mini_start = [];
peaks = [];
peaks_i = [];

mini_trace = {};
    
diff_data = diff (data);
mean_data = mean (data);
std_data = std (data);
mean_diff = mean (diff_data);
std_diff = std (diff_data);


%% find indexes of local minima of diff_data that are lower than threshold*std
loc_max_diff_i = find (diff_data < mean_diff - diff_thresh*std_diff);

%% remove closely spaced peaks

%check for closely spaced double-peaks
n = numel (loc_max_diff_i);
for j = 2:n
        if (loc_max_diff_i(j) - loc_max_diff_i(j-1)) < decay
            %%remove that peak
            loc_max_diff_i (j) = nan;
        end
end

%%
for i = 1:length (loc_max_diff_i)             
    %check for end of data
    if loc_max_diff_i(i) + decay + 10 < length (data)
        
        %find minimum ("peak") and its index
        local_data = data(loc_max_diff_i(i): loc_max_diff_i(i)+decay);
        local_peak = min (local_data);
        local_peak_i = find (local_data == local_peak) + loc_max_diff_i(i)-1;
        
        % if the peak doesn't decay too quickly
        if data (local_peak_i+decay) < data (loc_max_diff_i(i))
%             mini_start = [mini_start; loc_max_diff_i(i)];

            %if the peak is below mean - std * threshold
            if local_peak < mean_data - std_data * amp_thresh
                
                %update the peak and peak index array
                peaks = [peaks; local_peak];
                peaks_i = [peaks_i; local_peak_i];
                
                % sequester the trace
                mid_rise = (loc_max_diff_i(i) + local_peak_i) / 2;
                mini_trace {length(mini_trace)+1} = data(local_peak_i-decay : local_peak_i+decay*1.5);
            end
        end
        
    end
end

%% average mini's

trace_array = cell2mat (mini_trace);
avg_trace = mean (trace_array');
avg_trace = (0 - avg_trace(1)) + avg_trace;


%% print out results

figure; hold on;
plot (data, 'r');
% plot (diff_data, 'b');
% plot (loc_max_diff_i+1, data(loc_max_diff_i), 'bo');
plot (peaks_i, data(peaks_i), 'ko');



output_traces = mini_trace;


figure; hold on;

for i = 1 : length (mini_trace)
    new_trace = (0 - mini_trace{i}(1)) + mini_trace{i};
    plot (new_trace);
end

plot (avg_trace, 'r', 'LineWidth',1.5);

end

