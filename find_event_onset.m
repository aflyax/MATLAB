% Shortcut summary goes here
% click on a trace

pos = 1; %reverse for negative traces
start = 1900;
finish = 4600;

d = get(gco,'ydata')';

data = pos * d(start:finish);

min_diff = 1;

d_s = smooth (data, 0.01, 'loess');
diff_s = diff (d_s);
diff_pts = find (diff_s > min_diff);

figure; hold on;
plot (data);
plot (d_s, 'r');
plot (diff_pts(1,1), data (diff_pts(1,1)), 'ok');