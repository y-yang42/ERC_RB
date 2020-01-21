function [c,ceq] = constrain(x, budget)
c = 1 - log(x) * budget;
ceq = [];