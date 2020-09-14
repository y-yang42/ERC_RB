function b2w = budget2weight(data, monthCount, n, covSpan, budgetCol)
import toMinimize.*
import constrain.*

N=size(data,2);
options = optimoptions(@fmincon, 'Display', 'off');

covM = nancov(data(monthCount(n-covSpan):monthCount(n)-1,:));
x0 = ones(1,N);
x = fmincon(@(x)toMinimize(x,covM),x0,[],[],[],[],zeros(1,N),[],@(x)constrain(x,budgetCol),options);

b2w = x/sum(x);
end