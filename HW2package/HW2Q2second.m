%% a
load('DataSetHW2Q2a.mat');
% plot y vs x. x is real valued and y is binary valued
figure(1);
plot(sigmaXList,yList,'o');
xlabel('xList'); ylabel('yList');

Binput = [0; 0]; 
Xmatrix = [ones(size(sigmaXList)) sigmaXList];
% Set options for the optimization run
options = optimset('MaxFunEvals',3000,'TolX',1e-5,'display','iter');

% performs 'optimization'
[Bresult,fVal] = fminunc(@logisticLogLossBinary,Binput,options,Xmatrix,yList);

% this is the decision boundary when h = 0.5 or z = b0 + b1 x = 0
b0 = Bresult(1); b1 = Bresult(2);
decisionBoundary_Xvalue = -b0/b1;

xList_forPlotting = linspace(min(sigmaXList), max(sigmaXList), 100)';
xMatrix_forPlotting = [ones(size(xList_forPlotting)) xList_forPlotting];
yList_forPlotting = logisticFunction(xMatrix_forPlotting*Bresult);

zList_test = Xmatrix*Bresult; % zlist for the test dataset 
yList_predicted = (zList_test>=0);
yList_test = (yList==1); 
accuracy = sum(yList_test==yList_predicted)/length(yList_test);

figure(1); hold on;
plot(xList_forPlotting,yList_forPlotting);
legend('raw data','fit logistic curve');
ylim([-0.25 1.25]);

%% b
load('DataSetHW2Q2b.mat');
figure(1);
plot(sigmaXList,yList,'o');
xlabel('xList'); ylabel('yList');

Binput = [0; 0; 0]; 
Xmatrix = [ones(size(sigmaXList)) sigmaXList sigmaXList.^2];
% Set options for the optimization run
options = optimset('MaxFunEvals',3000,'TolX',1e-5,'display','iter');

% performs 'optimization'
[Bresult,fVal] = fminunc(@logisticLogLossBinary,Binput,options,Xmatrix,yList);

xList_forPlotting = linspace(min(sigmaXList), max(sigmaXList), 100)';
xMatrix_forPlotting = [ones(size(xList_forPlotting)) xList_forPlotting xList_forPlotting.^2];
yList_forPlotting = logisticFunction(xMatrix_forPlotting*Bresult);

b0 = Bresult(1); b1 = Bresult(2); b2 = Bresult(3);
decisionBoundary_Xvalue(1) = (-b1+sqrt(b1^2-4*b0*b2))/2*b0;
decisionBoundary_Xvalue(2) = (-b1-sqrt(b1^2-4*b0*b2))/2*b0;

zList_test = Xmatrix*Bresult; % zlist for the test dataset 
yList_predicted = (zList_test>=0);
yList_test = (yList==1); 
accuracy = sum(yList_test==yList_predicted)/length(yList_test);

figure(1); hold on;
plot(xList_forPlotting,yList_forPlotting);
legend('raw data','fit logistic curve');
ylim([-0.25 1.25]);