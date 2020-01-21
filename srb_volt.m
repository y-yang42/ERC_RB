function [netValue,weight] = srb_volt(data, monthCount, startMonth, covSpan, span, voltM, rate)

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
    volt = voltM(n-startMonth+1,:);
    place = (mu>0);
    sharpe = mu(place)./volt(place);
    if ~size(sharpe,2)
        tempWeight = [0,0,1,0,0,0];
    elseif size(sharpe,2) == 1
        tempWeight = zeros(1,N);
        tempWeight(place) = [1];    
    else
        budgetCol = sharpe'/sum(sharpe);
    
        covM = nancov(data(monthCount(n-covSpan):monthCount(n)-1,place));
        x0 = ones(1,size(budgetCol,1));
        x = fmincon(@(x)toMinimize(x,covM),x0,[],[],[],[],zeros(1,size(budgetCol,1)),[],@(x)constrain(x,budgetCol),options);
        tempWeight = zeros(1,N);
        tempWeight(place) = x/sum(x);
    end
    
    weight = [weight;tempWeight];

    vRemain = sum(min(valueHist(end,:), netValue(end) * weight(end,:)));
    valueR = (netValue(end) - (netValue(end) - vRemain) * rate) * weight(end,:);
    
    hist = cumprod(data_nanas0(monthCount(n):(monthCount(n+1)-1),:)/100+1) .* valueR;
    valueHist = [valueHist; hist(end,:)];
   
    netValue = [netValue; sum(valueHist(end,:))];   
end
end

