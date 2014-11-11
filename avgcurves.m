function avgCurve = avgcurves( inputX, inputY )
%avgcurves Takes (x,y) curve, averages y for any repeating
% x values.



    %% sort inputX and inputY into a cell%
    tempCell = sortvectors( inputX, inputY );
    
    srtCurve.x = tempCell{1};
    srtCurve.y = tempCell{2};

    
%% initializing newCurve and temp
    % pre-allocating empty values for newCurve
    newCurve.x = zeros(length(inputX),1);
    newCurve.y = zeros(length(inputY),1);
    newCurve.std = zeros(length(inputY),1);
    newCurve.stdErr = zeros(length(inputY),1);

    % initializing the first new X and Y    
    newCurve.x(1) = srtCurve.x(1);
    newCurve.y(1) = srtCurve.y(1);

    %temp is a buffer vector holding all y-val's that have the same x-val
    temp = newCurve.y(1);
    
    uniqI = 1; %the index of the current unique x,y

%% create averaged curve
    for i = 2 : length( srtCurve.x ) %from the second value : last
        
        if srtCurve.x(i) == srtCurve.x(i-1) %if two pts in a row are the same
            
%            if temp ~= inf
               temp = [temp; srtCurve.y(i)]; %add new point to temp
%            else
%                temp = srtCurve.y(i);
%            end
           
           %calculating y (avg), std and stdErr for the current x
           newCurve.y(uniqI) = mean(temp(~isnan(temp))); %new y-value is mean(temp)
%           newCurve.calcStd (uniqI, temp);
           
           newCurve.std(uniqI) = std(temp(~isnan(temp)));
           newCurve.stdErr(uniqI) = std(temp(~isnan(temp))) / sqrt( length(temp(~isnan(temp))) );
           
        else
           uniqI = uniqI + 1; %update uniqI
           
           %update newCurve
           newCurve.x(uniqI) = srtCurve.x(i);
           newCurve.y(uniqI) = srtCurve.y(i);
%          newCurve = newCurve.calcStd (uniqI, temp);

           newCurve.std(uniqI) = std(temp(~isnan(temp)));
           newCurve.stdErr(uniqI) = std(temp(~isnan(temp))) / sqrt( length(temp(~isnan(temp))) );

           temp = newCurve.y(uniqI); %update temp to the next value
           
        end %if
               
    end %for
    
    %delete zero values by making newCurve.x and .y go only until uniqI

%     curve = {newCurve.x newCurve.y newCurve.std newCurve.stdErr};
%     
%     curve = curve(1:uniqI,1);
%     
%     [newCurve.x newCurve.y newCurve.std newCurve.stdErr] = curve{1,:};
%     

    % a little cell magic
    
    % structure names
    curveHeadings = {'x' 'y' 'std' 'stdErr'};
    
    %conversting to a matrix
    curve_mat = cell2mat( struct2cell(newCurve)' );
    
    %assigining non-zero values to a cell
    shortCurve_cell = num2cell( curve_mat(1:uniqI,:), 1)';
    
    %converting back to a structure
    newCurve = cell2struct (shortCurve_cell, curveHeadings, 1);
    
    
    
    
    
%     newCurve.x = newCurve.x(1:uniqI,1);
%     newCurve.y = newCurve.y(1:uniqI,1);
%     newCurve.std = newCurve.std(1:uniqI,1);
%     newCurve.stdErr = newCurve.stdErr(1:uniqI,1);    
%% plotting results
        
    % Create axes
%     axes('Position',[0.13 0.1126 0.775 0.815]);
%     box('on');
%     hold('all');
    
    
    %plot raw data and averaged data%
    %plot (srtCurve.x, srtCurve.y, 'k.', newCurve.x,newCurve.y, '-ko');
    
    plot (newCurve.x,newCurve.y, '-ko'); hold on;
    %plot error bars%
%     
%     stdErr( length(srtCurve) ) = [];
%     
%     for i=1: length(strCurve.x)
%         stdErr = 
%     
%     end
    
    
  % stdErr = 10 * rand (1, length(newCurve.x) ); %generate random stdErr
    
    
    errorbar(newCurve.x, newCurve.y, newCurve.stdErr,'LineStyle','none','Color',[0 0 1]);


%% output

    avgCurve = newCurve;  

   
end

%     function newCurve = calcStd(uniqI, temp)
%         
%     end