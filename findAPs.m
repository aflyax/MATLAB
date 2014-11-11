function [output] = findAPs(input_trace)

    barrage = input_trace; %select APs to analyze from the trace

    %[peaks, i_p] = findpeaks(barrage); %if you want to analyze peaks

    [~, i_t] = findpeaks (-barrage); %obtain x-values for troughs

    APs = cell(length(i_t), 1); %allocate empty cell space

    %adding first and last pts of barrage to minima:
    minima = [1; i_t; length(barrage)];

    %separating APs:
    for i = 1:length(minima)-1
        APs{i} = barrage(minima(i):minima(i+1));
    end
    
    output = APs; %return a cell of AP traces
 end