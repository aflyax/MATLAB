clear t;
t = VoltageTrace (5, sample);

[rows, cols] = size (t.APs);
buffer = [];

figure; hold on;

t = VoltageTrace (5, sample);

for i = 1:50
    buffer = [buffer; t.APs(1,i).voltage];
    plot (t.APs(1,i).voltage);
    i
end

figure;
plot (buffer, 'r');