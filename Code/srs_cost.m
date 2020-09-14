function [netValue,weight] = srs_cost(data, monthCount, startMonth, covSpan, span, rate)
import calc_weight.*

data_nanas0 = data;
data_nanas0(isnan(data)) = 0;

netValue = 1;
valueHist = zeros(1,size(data,2));
weight = [];

%n=13;
for n = startMonth:(size(monthCount,1)-1)
    tempWeight = calc_weight(data, monthCount, n, covSpan, span);
    weight = [weight;tempWeight];
   
    vRemain = sum(min(valueHist(end,:), netValue(end) * weight(end,:)));
    valueR = (netValue(end) - (netValue(end) - vRemain) * rate) * weight(end,:);
    
    hist = cumprod(data_nanas0(monthCount(n):(monthCount(n+1)-1),:)/100+1) .* valueR;
    valueHist = [valueHist; hist(end,:)];
   
    netValue = [netValue; sum(valueHist(end,:))];   
end

end

