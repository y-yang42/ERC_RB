function [netValue,weight] = srs_nm(data, monthCount, startMonth, covSpan, span, rate)

import toMinimize.*
import constrain.*

data_nanas0 = data;
data_nanas0(isnan(data)) = 0;

netValue = 1;
N=6;
valueHist = zeros(1,size(data,2));
weight = [];
options = optimoptions(@fmincon, 'Display', 'off');

%n=13;
for n = startMonth:(size(monthCount,1)-1)
    mu = nanmean(data(monthCount(n-span):(monthCount(n)-1),:));
    volt = nanstd(data(monthCount(n-span):(monthCount(n)-1),:));
    %place = (mu>0);
    sharpeS = (mu./volt) .^ 2;
%     if ~size(sharpeS,2)
%         tempWeight = [0,0,1,0,0,0];
%     elseif size(sharpeS,2) == 1
%         tempWeight = zeros(1,N);
%         tempWeight(place) = [1];    
%     else
        budgetCol = sharpeS'/sum(sharpeS);
    
        covM = nancov(data(monthCount(n-covSpan):monthCount(n)-1,:));
        x0 = ones(1,size(budgetCol,1));
        x = fmincon(@(x)toMinimize(x,covM),x0,[],[],[],[],zeros(1,size(budgetCol,1)),[],@(x)constrain(x,budgetCol),options);
        %tempWeight = zeros(1,N);
        tempWeight = x/sum(x);
    %end
    
    weight = [weight;tempWeight];

    vRemain = sum(min(valueHist(end,:), netValue(end) * weight(end,:)));
    valueR = (netValue(end) - (netValue(end) - vRemain) * rate) * weight(end,:);
    
    hist = cumprod(data_nanas0(monthCount(n):(monthCount(n+1)-1),:)/100+1) .* valueR;
    valueHist = [valueHist; hist(end,:)];
   
    netValue = [netValue; sum(valueHist(end,:))];   
end
end

