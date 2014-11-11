function [output] = find_v_th (APs)
    v_th = struct([]);
    max_dv = {};
    min_dv = {};

    for i = 1:length(APs)
        dv = diff (APs{i}, 1); %first derivative
        
        %find first instance of dv/dt>0.001:
        v_th_i = find (dv>0.01, 1, 'first')-1; %offset by one b/c of diff
        
        if (v_th_i) %if v-threshold was found, enter voltage and x vals
            v_th(i).v = APs{i}(v_th_i);
            v_th(i).x = v_th_i;
            max_dv{i,1} = max (dv);
            min_dv{i,1} = min (dv);
        else
            v_th(i).v = nan;
            v_th(i).x = nan;
            max_dv{i,1} = nan;
            min_dv{i,1} = nan;
        end
    end
    
    output.v_th = v_th;
    output.max_dv = max_dv;
    output.min_dv = min_dv;
end
