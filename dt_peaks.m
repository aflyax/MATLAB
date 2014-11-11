barrage = AP_trace(21050:21100);

d1 = diff (barrage, 1);
d3 = diff (barrage, 3);

i_pos_d1 = find (d1>0);
pos_d1 = d1(i_pos_d1);
pos_d1_v = barrage(i_pos_d1);

pos_d3 = d3(i_pos_d1(2:length(i_pos_d1)-2));
[sorted, i_s] = sort (-pos_d3); sorted = -sorted;
local_max = sorted(2);
i_local_max = i_s(2);


% pos_d3_v = barrage(i_pos_d1);


figure; hold on;

plot (d1-0.05, '-rx');
% plot (i_pos_d1, pos_d1, 'ro');
plot (pos_d3, '-rx');
plot (i_local_max, local_max, 'k^');
plot (i_local_max, barrage(i_local_max), 'or');

plot (barrage, '-x');
% plot (i_pos_d1, pos_d1_v, 'ro');


% [peaks, i] = findpeaks(d);

% max_peaks = findpeaks (peaks);
% 
% [~,i_max] = ismember (max_peaks, d);
% 
% figure; hold on;
% plot(i,peaks, 'og');
% plot(i_max-2,max_peaks,'og');
% 
% plot(barrage);
% plot(d, '-xr');