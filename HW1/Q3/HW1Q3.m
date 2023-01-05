clear; 
close all; 
clc;

load('DatHW1Q2.mat')
Y = yList;
X = ones(size(xList));
xList_forPlottingFit = linspace(-4,4,200)';
MSEList = [];

figure(1);
plot(xList,yList,'o');
xlabel('x'); ylabel('y');

for iDegree = 1:4
    %% do 
    X = [X xList.^iDegree];
    B = regress(Y,X); % all coefficients for this polynomial degree 
    
    %% plot of data and best fit of a given polynomial degree
    yList_forPlottingFit = B(1);
    for iTerm = 1:iDegree
        yList_forPlottingFit = yList_forPlottingFit + ...
            B(iTerm+1)*xList_forPlottingFit.^iTerm;
    end
    figure(iDegree+1)
    plot(xList_forPlottingFit,yList_forPlottingFit,'linewidth',2);

    title(['Degree of polynomial = ' num2str(iDegree)], ...
        'fontsize',20);
    grid on
       
    %% compute mean square error
    E = Y-X*B; % array of errors for all data points
    MSE = mean(E.^2); % mean of the squared error
    MSEList = [MSEList MSE]; 
end

figure(6)
plot(1:4,MSEList,'o-')
xlabel('degree of polynomial'); 
ylabel('Mean square error')
title('MSE keeps going down')
grid on