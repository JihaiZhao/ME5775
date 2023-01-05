function L = logisticLogLossBinary(B,Xmatrix,yList)

zList = Xmatrix*B; 
% just a quick way of writing b0 + b1*input1 + ..., the expression for z
% for all data points. z = b0 + b1*x

% if given binary data
L = zeros(size(zList)); % initializing list of losses for each data point

% when y = 1
L(yList==1) = (-log(logisticFunction(zList(yList==1)))); 
% when y = 0
L(yList==0) = (-log(1-logisticFunction(zList(yList==0))));

L = mean(L); % take mean over all data points rather than sum so that the value is not too large

% note: we do not want to do the following as that may result in 0*inf type
% nans or other things
% L = (yList==1).*(-log(logisticFunction(yList_linearPrediction(yList==1)))) + ...
% (yList==0).*(-log(1-logisticFunction(yList_linearPrediction(yList==0))));

end
