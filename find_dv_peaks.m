function output = find_dv_peaks(sample)


    barrage = sample(19000:31000);

    [p, p_i] = findpeaks(barrage);

    pos_i = p > 0;

    pos_peak_v = p(pos_i);
    pos_peak_x = p_i(pos_i);

    % figure; hold on;
    % plot (barrage);
    % plot (p_i, barrage(p_i), 'or');
    % plot (pos_peak_x, pos_peak_v, '.r');


    d1 = diff (barrage, 1);
    temp_peaks = findpeaks (d1);

    max_d1 = temp_peaks(temp_peaks>0.005);


    mean_max_d1 = mean (max_d1);
    median_max_d1 = median (max_d1);
    max_max_d1 = max (max_d1);

    % {'mean_max_d1', 'median_max_d1', 'max_max_d1';
    % mean_max_d1, median_max_d1, max_max_d1}

    [~,max_d1_x] = ismember (max_d1, d1);
    APs = [];
    % find APs
    APs = cell (length(pos_peak_x),1);

%     figure; hold on;

    for i = 1: length (pos_peak_x)
        APs{i,1} = barrage (pos_peak_x(i)-20:pos_peak_x(i)+15)';
%         plot (APs{i,1}, 'b');
    end

    ap_matrix = [];

    mean_AP = [];
    median_AP = [];

    % if (APs)
        for i = 1:length (APs)
            ap_matrix (:,i) = APs{i,1};
        end

        mean_AP = mean (ap_matrix')';
        median_AP = median (ap_matrix')';
    % end

    output.APs = APs;
    output.ap_matrix = ap_matrix;
    output.mean_AP = mean_AP;
    output.median_AP = median_AP;

    % plot (mean_AP, 'r');
    % plot (median_AP, 'g');

    %
    % figure; hold on;
    % subplot(2,1,1), plot (barrage), hold on, plot (max_d1_x, barrage(max_d1_x), '.r'); axis tight;
    % subplot(2,1,2), plot (max_d1_x, max_d1, '.'); title 'max dv/dt';
    % 
    % figure; hold on; plot (d1); plot (max_d1_x, d1(max_d1_x), 'ro');
    % figure; plot (max_d1, '.');
end