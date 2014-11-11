current_cell = cell_05;

    for cell_i = 1: min (size (current_cell) )
        sample = current_cell(:,cell_i);
        p = find_dv_peaks (sample);

        AP_ths = find_v_th (p.APs);


        total_th = [];
        troughs = [];
        max_dv = [];

        for j = 1:length (p.APs)
            [min_y, ~] = min (p.APs{j});
            troughs (j,1) = min_y;

            total_th = [total_th; AP_ths.v_th(j).v];
            max_dv = [max_dv; AP_ths.max_dv{j}];
        end

        mean_barrage_AHPs(cell_i,1) = mean (total_th - troughs);
        mean_barrage_ths (cell_i,1) = mean (total_th);
        mean_max_dv (cell_i, 1) = mean (max_dv);
        
        
        max_max_dv (cell_i, 1) = max (max_dv);
    end
    