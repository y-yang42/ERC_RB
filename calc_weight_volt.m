function tempWeight = calc_weight_volt(data, monthCount, n, covSpan, span, voltM, startMonth)
N=size(data,2);

mu = nanmean(data(monthCount(n-span):(monthCount(n)-1),:));
volt = voltM(n-startMonth+1,:);
place = (mu>0);
sharpeS = (mu(place)./volt(place)).^2;

if ~size(sharpeS,2)
    tempWeight = zeros(1,N);
    tempWeight(1) = 1;
elseif size(sharpeS,2) == 1
    tempWeight = zeros(1,N);
    tempWeight(place) = [1];
else
    budgetCol = sharpeS'/sum(sharpeS);
    b2w = budget2weight(data(:,place), monthCount, n, covSpan, budgetCol);
    tempWeight = zeros(1,N);
    tempWeight(place) = b2w;
end

end