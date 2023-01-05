function f = logisticLogLossContinuous(B,Xmatrix,yList)

yList_linearPrediction = Xmatrix*B;

% if given binary or smooth probability data
% f = yList.*(-log(logisticFunction(yList_linearPrediction))) + ...
%     (1-yList).*(-log(1-logisticFunction(yList_linearPrediction)));


%% the above commented way of writing the function may lead to nan's and inf's 
% due to 0*infinity form or other imprecise evaluations. the following
% rewrites the function so that these things cannot happen

a = logisticFunction(yList_linearPrediction);
b = 1-logisticFunction(yList_linearPrediction);
b = (b>=1)*1 + (b<=0)*0 + ((b>0)&(b<1)).*b;


p1 = (yList==1);
p2 = (yList==0);

p3 = ~(p1|p2);

f1 = (-log(a(p1))); % when y = 1
f2 = (-log(b(p2))); % when y = 0
f3 = yList(p3).*(-log(a(p3))) + (1-yList(p3)).*(-log(b(p3))); % when y is in between
f = zeros(size(yList_linearPrediction));
f(p1) = f1; f(p2) = f2; f(p3) = f3;

f = mean(f);
% 
% if isnan(f)
%     error('function evaluates to nan. check function evaluation');
% elseif isinf(f)
%     warning('function evaluates to inf. check function evaluation and make it smooth');
% end 
   
f = min(f,10^6); 
% to make sure that the value of f is not infinity. could actually replace
% this with a logistic function itself so that the function is smoot


end