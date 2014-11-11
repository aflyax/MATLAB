function  output = compare_v_th (current_cell)

%     current_cell = cell_05;

    for i = 1:min (size(current_cell))

        sample = current_cell(:,i);

        findAPs(sample);
        APdata = find_dv_peaks (sample);
        AP_th = find_v_th (APdata.APs);

        total_th = [];
        for j = 1:length (AP_th)
            total_th = [total_th; AP_th(j).v];
        end

        mean_th(i,1) = mean (total_th);
        f = find_v_th ({APdata.mean_AP});
        mean_th_mAP(i,1) = f.v;
    end
    
    output.mean_th = mean_th;
    output.mean_th_mAP = mean_th_mAP;
    
    figure; hold on;
    
    plot (output.mean_th, '.'); plot (output.mean_th_mAP, 'r.');
end