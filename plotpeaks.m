barrage = sample(20005:30005);

[ap_peaks, p_i] = findpeaks (barrage);

[ap_troughs, p_t] = findpeaks (-barrage); ap_troughs = -ap_troughs;

figure; hold on; 
plot (barrage); axis tight;
plot (p_i, ap_peaks, 'ro');
plot (p_t, ap_troughs, '^r');