clear; 
close all; 
clc;

load('DatHW1Q2.mat')
Y = yList;
X = ones(size(xList));

figure(1);
plot(xList,yList,'o');
xlabel('x'); ylabel('y');

%% cross validation indices
kCrossValidation = 4; % 4-fold cross validation
indices = crossvalind('Kfold',xList,kCrossValidation);

%%
NumMaximumDegreePolynomial = 8;
for k = 1:kCrossValidation
    validation = (indices == k);
    train = ~validation;
    
    xList_Train = xList(train); yList_Train = yList(train);
    xList_Validation = xList(validation); yList_Validation = yList(validation);
    N_Validation = length(xList_Validation); N_Train = length(xList_Train);
    
    X_Train = ones(size(xList_Train));
    X_Validation = ones(size(xList_Validation));
    for iDegree = 1:NumMaximumDegreePolynomial
        
        % training
        X_Train = [X_Train xList_Train.^iDegree];
        Y_Train = yList_Train;
%         B = regress(Y_Train,X_Train);
        B = X_Train\Y_Train;
        MSE_Matrix_Train(k,iDegree) = ((Y_Train-X_Train*B)'*(Y_Train-X_Train*B))/N_Train;
        % storing as a cell array because each model has a different size B

        % Validationing
        X_Validation = [X_Validation xList_Validation.^iDegree];
        Y_Validation = yList_Validation;
        MSE_Matrix_Validation(k,iDegree) = ((Y_Validation-X_Validation*B)'*(Y_Validation-X_Validation*B))/N_Validation;
        
    end
end

%% plotting train and Validation error
figure(2);
plot(mean(MSE_Matrix_Train),'o-')
hold on
plot(mean(MSE_Matrix_Validation),'o-')
legend('Mean train error','mean Validation or validation error');

optimalDegree = find(mean(MSE_Matrix_Validation)==min(mean(MSE_Matrix_Validation)))
title({'k-fold cross validation',['Mean Validation error is minimized at N = ' num2str(optimalDegree)]})

%% b
xList_forPlottingFit = linspace(-4,4,200)';
noiseList = [];

for iDegree = 1:6
    %% do 
    X = [X xList.^iDegree];
    B = regress(Y,X); % all coefficients for this polynomial degree     
    %% plot of data and best fit of a given polynomial degree
    yList_forPlottingFit = B(1);
    for iTerm = 1:iDegree
        yList_forPlottingFit = yList_forPlottingFit + ...
            B(iTerm+1)*xList_forPlottingFit.^iTerm;
    end
    figure(iDegree+2)
    plot(xList_forPlottingFit,yList_forPlottingFit,'linewidth',2);

    title(['Degree of polynomial = ' num2str(iDegree)], ...
        'fontsize',20);
    grid on
       
    %% compute mean square error
    E = Y-X*B; % array of errors for all data points
    noise = std(E);
    noiseList = [noiseList noise]
    % y has noise with standard deviation equal to 3, therefore polynomial 
    % degree is better if std(E)closer to 3. Thus, the polynomial degree
    % should be 3
end