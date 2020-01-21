%function [netValue,weight] = maxSR(data, monthCount, covSpan, corrSpan, span, rate)
function [netValue,weight] = maxSR_cost(data, monthCount, startMonth, covSpan, span, rate)
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
% %     mu = mean(data(monthCount(n):(monthCount(n+1)-1),:));
% %     volt = std(data(monthCount(n):(monthCount(n+1)-1),:));
    sharpeR = mu ./ volt;
    
%     corrVec = {};
%     for i = 1:4
%         corrVec{i} = corrcoef(data(monthCount(n-2*i):monthCount(n-2*(i-1)-1),:));
%     end
%     corrM = (4*corrVec{1}+2*corrVec{2}+corrVec{3}+corrVec{4})/8;
    
    corrM = corrcoef(data_nanas0(monthCount(n-span):monthCount(n)-1,:));
    coeffM = corrM ./ sharpeR;
    budgetOrg = coeffM \ sharpeR';
    
% %     place = (budgetOrg>0);
% %     budgetCol =  budgetOrg(place); 
%     
% %     covM = cov(data_nanas0(monthCount(n-4):monthCount(n)-1,place));
% %     x0 = ones(1,size(budgetCol,1));
% %     x = fmincon(@(x)toMinimize(x,covM),x0,[],[],[],[],zeros(1,size(budgetCol,1)),[],@(x)constrain(x,budgetCol),options);
% %     tempWeight = zeros(1,N);
% %     tempWeight(place) = x/sum(x);
    
    %budgetCol = budgetOrg/sum(budgetOrg);
    covM = nancov(data(monthCount(n-covSpan):monthCount(n)-1,:));    
    x0 = ones(1,size(budgetOrg,1));
    %x = fmincon(@(x)toMinimize(x,covM),x0,[],[],[],[],zeros(1,size(budgetOrg,1)),[],@(x)constrain(x,budgetOrg),options);
    x = fmincon(@(x)toMinimize(x,covM),x0,[],[],[],[],[],[],@(x)constrain(x,budgetOrg),options);
    tempWeight = x/sum(x);
    weight = [weight;tempWeight];

    vRemain = sum(min(valueHist(end,:), netValue(end) * weight(end,:)));
    valueR = (netValue(end) - (netValue(end) - vRemain) * rate) * weight(end,:);
    
    hist = cumprod(data_nanas0(monthCount(n):(monthCount(n+1)-1),:)/100+1) .* valueR;
    valueHist = [valueHist; hist(end,:)];
   
    netValue = [netValue; sum(valueHist(end,:))]; 
end
end
