function [taretal,tarestdevsub] = meantare(series,checkit)

% SOLVE TARES BY TAKING THE MEAN
[s,~,s_id] = unique(series);
nseries = length(s);
zap=zeros(nseries,size(checkit,2));
zapper=zeros(nseries,size(checkit,2));

for i = 1:nseries
    zoop = checkit(s_id==i,:);
    zap(i,:) = mean(zoop);
    zapper(i,:) = std(zoop);
end
taretal = zap(s_id,:);
tarestdevsub = zapper(s_id,:); 

