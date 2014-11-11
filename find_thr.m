load('C:\Users\Alex\Documents\MATLAB\data\temp\ap_trace.mat');

barrage = AP_trace(21000:21050);

d1 = diff (barrage, 1);
d3 = diff (barrage, 3);

figure; hold on;
plot (barrage);
plot (d3, '-xr');

v_th_i = find (d1<-0.001, 1, 'first')-1; %offset by one b/c of diff
v_th = barrage(v_th_i); 
d_th = d1(v_th_i);

plot (v_th_i, v_th, 'or');