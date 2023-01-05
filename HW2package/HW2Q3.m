load('DatasetHW2Q3.mat');

figure(1); hold on;
plot(sigmaXList(yList==1),sigmaYList(yList==1),'rx'); hold on;
plot(sigmaXList(yList==0),sigmaYList(yList==0),'bo'); hold on;
xlabel('sigma_x'); ylabel('sigma_y');

Xmatrix = [ones(size(sigmaXList)) sigmaXList sigmaYList ...
    sigmaXList.^2 sigmaYList.^2 sigmaXList.*sigmaYList sigmaXList.^3 ...
    sigmaXList.^2.*sigmaYList sigmaXList.*sigmaYList.^2 sigmaYList.^3]; 
Binput = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

% Set some options for the optimization run
options = optimset('MaxFunEvals',3000,'TolX',1e-5,'display','iter'); % default optimization options

% fminunc is a program that performs 'optimization'
[Bresult,fVal] = fminunc(@logisticLogLossBinary,Binput,options,Xmatrix,yList);

figure(1); hold on;
terms = {'x','y','x^2','y^2','x*y','x^3','x^2*y','x*y^2','y^3'};
temp = num2str(Bresult(1)) % constant term
for i = 1:length(terms)
    temp = [temp '+' terms{i} '*' '(' num2str(Bresult(i+1)) ')']
    pause
end

zList_test = Xmatrix*Bresult; % zlist for the test dataset 
yList_predicted = (zList_test>=0);
yList_test = (yList==1); 
accuracy = sum(yList_test==yList_predicted)/length(yList_test);

h = ezplot(temp); % plot the decision boundary
set(h,'LineColor',[0 0 0],'linewidth',2); % make it black!
title('2D data and decision boundary')
legend('data 1','data 0','decision boundary')