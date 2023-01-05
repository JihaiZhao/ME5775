%% a
load('DataSetHW2Q1.mat');
Y = yList;
X = ones(size(xList));
xList_forPlottingFit = linspace(0,8,200)';

X = [X xList.^1 xList.^2];
B = regress(Y,X); % all coefficients for this polynomial degree 
    
% plot of data and best fit of a given polynomial degree
yList_forPlottingFit = B(1);

yList_forPlottingFit = yList_forPlottingFit + ...
    B(2)*xList_forPlottingFit.^1 + B(3)*xList_forPlottingFit.^2;

figure(1)
plot(xList,yList,'o',xList_forPlottingFit,yList_forPlottingFit,'linewidth',2);
xlabel('x'); ylabel('y');
title(['Degree of polynomial = ' num2str(2)], ...
    'fontsize',20);
grid on
 
%% remove all y data outside 2 standard deviations of y mean (b)
std_y = std(yList); mean_y = mean(yList);
z_score_y = (yList-mean_y)/std_y; 
% z_score_y = zscore(yList) % can also use the zscore function direction

stdThreshold = 2; % how many std away is an outlier
outlierIndices = (abs(z_score_y)>stdThreshold);

% re do regression
xListb = xList(~outlierIndices);
yListb = yList(~outlierIndices);

Xb = [ones(size(xListb)) xListb xListb.^2];
Yb = yListb;
Bb = regress(Yb,Xb);

yListForFit = Bb(1);
xListForFit = linspace(min(xListb),max(xListb),100)';
yListForFit = yListForFit+ ...
    Bb(2)*xListForFit.^1 + Bb(3)*xListForFit.^2;

hold on; figure(2);
plot(xListb,yListb,'o',xListForFit,yListForFit,'linewidth',2);
xlabel('x'); ylabel('y');
title(['Remove y values with more than 2σy from µy of y' ], ...
    'fontsize',16);
grid on
%%  (c) Remove 10 data points with the highest absolute errors: abs(E).
E = yList-X*B;
c = abs(E);
% remove 10 data is same as remove 20% data
percentRemoved = 20;
outlierIndices = (abs(E)>prctile(abs(E),100-percentRemoved));
xListc = xList(~outlierIndices);
yListc = yList(~outlierIndices);
Xc = [ones(size(xListc)) xListc xListc.^2];
Yc = yListc;
Bc = regress(Yc,Xc);

yListForFitc = Bc(1);
xListForFitc = linspace(min(xListc),max(xListc),100)';
yListForFitc = yListForFitc+ ...
    Bc(2)*xListForFitc.^1 + Bc(3)*xListForFitc.^2;
hold on; figure(3);
plot(xListc,yListc,'o',xListForFitc,yListForFitc,'linewidth',2);
xlabel('x'); ylabel('y');
title(['remove 10 points with the highest abs(E)'], ...
    'fontsize',16);
grid on
%% (d) Use robustfit to do the regression.
Y = yList;
X = ones(size(xList));
xList_forD = linspace(0,8,100)';
X = [X xList.^1 xList.^2];
[Bd,stat] = robustfit(X,Y);
yList_forD = Bd(2);

yList_forD = yList_forD + ...
    Bd(3)*xList_forD.^1 + Bd(4)*xList_forD.^2;

figure(4)
plot(xList,yList,'o',xList_forD,yList_forD,'linewidth',2);
xlabel('x'); ylabel('y');
title(['Use robustfit to do the regression'], ...
    'fontsize',16);
grid on
%% (e)Use L1regression code to do the regression.
[Be, fval] = L1regression(Y,X);
xList_forE = linspace(0,8,100)';
yList_forE = Be(1);
yList_forE = yList_forE + ...
    Be(2)*xList_forE.^1 + Be(3)*xList_forE.^2;
figure(5)
plot(xList,yList,'o',xList_forE,yList_forE,'linewidth',2);
xlabel('x'); ylabel('y');
title(['Use L1regression code to do the regression'], ...
    'fontsize',16);
grid on
%% (f) Add one ‘far away’ outlier
xListf = [xList;12];
yListf = [yList;40];
% normal way
Yf = yListf;
Xf = ones(size(xListf));
xList_forPlotF = linspace(min(xListf),max(xListf),100)';
Xf = [Xf xListf.^1 xListf.^2];
Bf = Xf\Yf;
yList_forPlotF = Bf(1);
yList_forPlotF = yList_forPlotF + ...
    Bf(2)*xList_forPlotF.^1 + Bf(3)*xList_forPlotF.^2;
% Use L1regression code
[BfL1, fval] = L1regression(Yf,Xf);
xList_forf = linspace(min(xListf),max(xListf),100)';
yList_forf = BfL1(1);
yList_forf = yList_forf + ...
    BfL1(2)*xList_forf.^1 + BfL1(3)*xList_forf.^2;
% plot the figure
figure(6)
plot(xListf,yListf,'o',xList_forPlotF,yList_forPlotF,xList_forf,yList_forf,'linewidth',2);
legend('origin','normal','L1regression');
xlabel('x'); ylabel('y');
grid on;