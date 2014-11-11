%initializing

d_area = 0;

% d = your data
% enter your values here:
d_start = 150;
d_end = 600;

%num_intervals = 50;

%interval = ceil( (d_end-d_start)/num_intervals );

interval = 1;

d_b = d - d(d_start); %subtracting baseline

x = (d_start : interval : d_end)';
y = d_b (x);

%plotting
figure; hold on
plot (d);

%AF trapezoid integration
for i = 1 : size(x)-1
    d_area (i) = (x(i+1) - x(i)) * ((y(i) + y(i+1))/2);
    
    %plotting trapezoid
    t_x = [x(i), x(i), x(i+1), x(i+1)];
    t_y = [0, y(i), y(i+1), 0];
    
    fill (t_x, t_y, 'r');
end

AF_area = sum(d_area)

%trapz integration
trapz_area = trapz(x,y)
