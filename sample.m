[p, i_p] = findpeaks (f);

[troughs, i_t] = findpeaks (trace);
troughs = –troughs;


plot (i_t, troughs, 'ob'); 
plot (trace, 'r');