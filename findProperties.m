    function output = findProperties( current_cell )
    %FINDAHP Summary of this function goes here
    %   Detailed explanation goes here

    total_AP = {};
    ap_i = 0;
    trough = [];
    total_v_th = [];
    AHP = [];
    mean_AP = [];

%     figure; hold on;

    for cell_i = 1: min (size (current_cell) )
        sample = current_cell(:,cell_i);
        p = find_dv_peaks (sample);

        AP_ths = find_v_th (p.APs);
        
        mean_AP {cell_i, 1} = p.mean_AP;
        
        total_th = [];
        troughs = [];
        max_dv = [];
        min_dv = [];
        
        for j = 1:length (p.APs)
            [min_y, ~] = min (p.APs{j});
            troughs (j,1) = min_y;

            total_th = [total_th; AP_ths.v_th(j).v];
            max_dv = [max_dv; AP_ths.max_dv{j}];
            min_dv = [min_dv; AP_ths.min_dv{j}];
        end

        mean_barrage_AHPs(cell_i,1) = mean (total_th - troughs);
        mean_barrage_ths (cell_i,1) = mean (total_th);
        mean_max_dv (cell_i, 1) = mean (max_dv);
        mean_min_dv (cell_i, 1) = mean (min_dv);

        if (~isnan(max_dv))
            max_max_dv (cell_i, 1) = max (max_dv);
        else
            max_max_dv (cell_i, 1) = nan;
        end
        
        if (~isnan(min_dv))
            max_min_dv (cell_i, 1) = max (min_dv);
        else
            max_min_dv (cell_i, 1) = nan;
        end
    end

    pos_mean_AP =  mean_AP (cellfun(@(V) any(~isnan(V(:))), mean_AP));
    
    for i = 1:length(pos_mean_AP)
        pos_AP_mat (:,i) = pos_mean_AP{i};
    end
    
    mean_tot_AP = mean (pos_AP_mat')';
    
    
    pos_AHPs = mean_barrage_AHPs (~isnan (mean_barrage_AHPs)  );
    mean_cell_AHP = mean (pos_AHPs);
    
    pos_v_th = mean_barrage_ths (~isnan (mean_barrage_ths)  );
    mean_cell_v_th = mean (pos_v_th);

    output.mean_AP = mean_AP;
%     output.mean_pos_AP = mean_pos_AP;
    output.mean_tot_AP = mean_tot_AP;
    
    output.AHP.raw = mean_barrage_AHPs;
    output.AHP.pos = pos_AHPs;
    output.AHP.mean = mean_cell_AHP;
    
    output.v_th.raw = mean_barrage_ths;
    output.v_th.pos = pos_v_th;
    output.v_th.mean = mean_cell_v_th;
    
    output.max_dv.max = max_max_dv;
    output.max_dv.mean = mean_max_dv;
    
    output.min_dv.max = max_min_dv;
    output.min_dv.mean = mean_min_dv;
end

