%% Averages traces on a selected figure

data_b = {};


h = findobj(gca,'Type','line');
fig_x=get(h,'Xdata');
fig_y=get(h,'Ydata');

data_start = 1900;
stim_start = 2000;
data_finish = 2600;


%subtract baseline
figure; hold on;
grey=[.8,.8,.8];

for i = 1 : size (fig_y)
    base = mean (fig_y{i}(data_start:stim_start));
    data_b{i} = fig_y{i} - base;
    
    plot (data_b{i}(data_start:data_finish), 'Color', grey);
end

dim = ndims(data_b{2});         %# Get the number of dimensions for your arrays
M = cat(dim+1,data_b{:});            %# Convert to a (dim+1)-dimensional matrix
y_mean = mean(M,dim+1);      %# Get the mean across arrays

plot (y_mean (data_start:data_finish), 'r');