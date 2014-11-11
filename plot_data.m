v_th = struct();

v_th_dt = [];
AHP_dt = [];
AHP_con = [];
v_th_con = [];

max_dt.mean = [];
max_con.mean = [];
max_dt.max = [];
max_con.max = [];
min_dt.max = [];
min_con.max = [];
min_dt.mean = [];
min_con.mean = [];
dt_mean_AP = [];
con_mean_AP = [];
tot_mean_AP = [];


for i = 1:length (dt_data)
    v_th_dt = [v_th_dt; dt_data{i}.v_th.raw];
    AHP_dt = [AHP_dt; dt_data{i}.AHP.raw];
    max_dt.mean = [max_dt.mean; dt_data{i}.max_dv.mean];
    max_dt.max = [max_dt.max; dt_data{i}.max_dv.max];
    min_dt.mean = [min_dt.mean; dt_data{i}.min_dv.mean];
    min_dt.max = [min_dt.max; dt_data{i}.min_dv.max];
    tot_mean_AP (:,i) = dt_data{i}.mean_tot_AP;
end

dt_mean_AP = mean (tot_mean_AP')';

tot_mean_AP = [];

for i = 1: length (con_data)
    v_th_con = [v_th_con; con_data{i}.v_th.raw];
    AHP_con = [AHP_con; con_data{i}.AHP.raw];
    max_con.mean = [max_con.mean; con_data{i}.max_dv.mean];
    max_con.max = [max_con.max; con_data{i}.max_dv.max];
    min_con.mean = [min_con.mean; con_data{i}.min_dv.mean];
    min_con.max = [min_con.max; con_data{i}.min_dv.max];
    tot_mean_AP (:,i) = dt_data{i}.mean_tot_AP;
end

con_mean_AP = mean (tot_mean_AP')';

figure ('Name', 'mean APs'); hold on;
plot (dt_mean_AP);
plot (con_mean_AP, 'r');

figure ('Name', 'voltage threshold'); hold on;
plot (con_curr, v_th_con, 'r.');
plot (dt_curr, v_th_dt, '.');

figure ('Name', 'AHP'); hold on;
plot (con_curr, AHP_con, '.r');
plot (dt_curr, AHP_dt, '.');

figure ('Name', 'average max dv/dt'); hold on;
plot (con_curr, max_con.mean, '.r');
plot (dt_curr, max_dt.mean, '.');

figure ('Name', 'maximum max dv/dt'); hold on;
plot (con_curr, max_con.max, '.r');
plot (dt_curr, max_dt.max, '.');

figure ('Name', 'average min dv/dt'); hold on;
plot (con_curr, min_con.mean, '.r');
plot (dt_curr, min_dt.mean, '.');

figure ('Name', 'maximum min dv/dt'); hold on;
plot (con_curr, min_con.max, '.r');
plot (dt_curr, min_dt.max, '.');


% 
% figure; hold on;
% %
% avgcurves (con_curr, v_th.con);
% avgcurves (dt_curr, v_th.dt);