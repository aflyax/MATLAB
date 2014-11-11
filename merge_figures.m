% merge two figures

fig1_name = 'TC_input_PT.fig';
fig2_name = 'TC_input_IT_avg.fig';

fig1 = open(fig1_name);
fig2 = open(fig2_name);

ax1 = get(fig1, 'Children');
ax2 = get(fig2, 'Children');

for i = 1 : numel(ax2) 
   ax2Children = get(ax2(i),'Children');
   copyobj(ax2Children, ax1(i));
end