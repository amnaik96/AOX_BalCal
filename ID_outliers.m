function [OUTLIER_ROWS,num_outliers,prcnt_outliers,rowOut,colOut]=ID_outliers(targetRes,loadCapacities,numpts0,dimFlag,numSTD,FLAGS)
%function takes in the residual matrix, returns rows of outliers, number of
%outliers, and percent of datapoints that are outliers

% Use the modeled input for the rest of the calculations
for n = 1:dimFlag
    normtargetRes(:,n) = targetRes(:,n)/loadCapacities(n);
end
out_meanValue = mean(normtargetRes);

% Identify outliers. They are considered outliers if the residual
% is more than 3 standard deviations as % of capacity from the mean.
out_standardDev = std(normtargetRes);
thresholdValue = numSTD * (out_standardDev) - out_meanValue;

for n = 1:dimFlag
    if thresholdValue(1,n) <= 0.0025
        thresholdValue(1,n) = 0.0025;
    end
end

outlierIndices = abs(normtargetRes) > thresholdValue;

[rowOut,colOut]=find(outlierIndices); %Find row and column indices of outliers
% 
% % ID outlier rows :
% zero_counter = 1;
% for k1 = 1:numpts0
%     for k4 = 1:dimFlag
%         if outlierIndices(k1,k4) == 1
%             outlier_values(zero_counter,1) = k1;
%             zero_counter = zero_counter + 1;
%         end
%     end
% end
% if zero_counter==1
%     outlier_values=[];
% end
% OUTLIER_ROWS = unique(outlier_values,'rows');

OUTLIER_ROWS = unique(rowOut);

num_outliers = length(OUTLIER_ROWS);
prcnt_outliers = 100.0*num_outliers/numpts0;

if FLAGS.print == 1
    %% Identify the Possible Outliers
    fprintf(' \n***** \n');
    fprintf(' ');
    fprintf('\nNumber of Outliers =');
    fprintf(string(num_outliers));
    fprintf('\nOutliers % of Data =');
    fprintf(string(prcnt_outliers));
    fprintf('\n \n');
end

end