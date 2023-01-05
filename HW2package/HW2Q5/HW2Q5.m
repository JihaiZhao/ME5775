%% a
load('mnist.mat');

whatNumber = 5;
% classified to determine whether a given image is greater than 5 or not
trainXs = trainX(1:10000,:);
trainYs = trainY(:,1:10000);
%%
% checking size of things
numTrainData = length(trainY); % 60,000
numTestData = length(testY); % 10,000
Wpixel = 28; Hpixel = 28; % 28 x 28 = 784 pixels per image
vectorSize = 28*28; % dimensionality of the input data

yList = (trainY>whatNumber); 
yList = double(yList); 
Xmatrix = [ones(numTrainData,1) trainX]; % prediction is linear in 
Xmatrix = double(Xmatrix); % convert to logical variable to 'real numbers'
Binput = zeros(vectorSize+1,1);

% Set some options for the optimization run
options = optimset('MaxFunEvals',100000,'display','iter'); % default optimization options

% performs 'optimization'
[Bresult,fVal] = fminunc(@logisticLogLossContinuous,Binput,options,Xmatrix,yList);

    for iIndex = 1:30 % display 10 images
        
        iDisplayed = randsample(numTestData,1); % randomly select a number between 1 and number of test images
        M = testX(iDisplayed,:); % pull-out one image
        imageDisplayFromVector(M,Wpixel,Hpixel);
        
        z = double([1 M])*Bresult; % basically computes b0 + b1*M(1) + b2*M(2) + ...
        if z>=0
            s = ['greater than ' num2str(whatNumber)];
        else
            s = ['NOT greater than ' num2str(whatNumber)];
        end
        title({'grayscale image',['MNIST thinks this is the number ' num2str(num2str(testY(iDisplayed)))],['OUR CLASSIFIER thinks it is: ' s]},'fontsize',15)        
            pause
        
    % computing the overall accuracy on the TEST dataset
    Xmatrix_test = [ones(numTestData,1) testX]; % construct the Xmatrix for the test dataset
    Xmatrix_test = double(Xmatrix_test); % convert to double
    zList_test = Xmatrix_test*Bresult; % zlist for the test dataset 
    yList_predicted = (zList_test>=0);
    yList_test = (testY>whatNumber)'; 
    accuracy = sum(yList_test==yList_predicted)/length(yList_test);

    % accuracy on train dataset
    Xmatrix_train = [ones(numTrainData,1) trainX]; % construct the Xmatrix for the test dataset
    Xmatrix_train = double(Xmatrix_train); % convert to double
    zList_train = Xmatrix_train*Bresult; % zlist for the test dataset
    yList_predictedtrain = (zList_train>=0); % the decision rule is z>=0 for the image being 5 (or whatever whatNumber is)
    yList_train = (trainY>whatNumber)'; % ground truth data: converting the test labels in textY into a 5 or not-5 binary dataset
    accuracy_train = sum(yList_train==yList_predictedtrain)/length(yList_train);
    
    disp(['The accuracy of this logistic regression is ' num2str(accuracy*100) ' percent']);
    disp(['in detecting whether a number is ' num2str(whatNumber) ' or not']);
    disp(' ');
    disp(['Is this a high percentage? For answer, see comments in the code.']);

    % separating this into two types of error: false positive and false negative error rates
    temp = (yList_test==0); 
    errorRate_FalsePositive = ...
        sum(yList_test(temp)~=yList_predicted(temp))/sum(temp)
    
    errorRate_FalseNegative = ...
        sum(yList_test(~temp)~=yList_predicted(~temp))/sum(~temp)

    
    save(['Run_ToDetect' num2str(whatNumber) '.mat'],'Bresult');
    
    end
%% b
load('mnist.mat');
whatNumber = [0,2,4,6,8];
% classified to determine whether a given image is even or odd
trainX = trainX(1:10000,:);
trainY = trainY(:,1:10000);
% checking size of things
numTrainData = length(trainY); % 60,000
numTestData = length(testY); % 10,000
Wpixel = 28; Hpixel = 28; % 28 x 28 = 784 pixels per image
vectorSize = 28*28; % dimensionality of the input data

yList = (trainY==whatNumber(1)|trainY==whatNumber(2)|trainY==whatNumber(3)...
    |trainY==whatNumber(4)|trainY==whatNumber(5)); 
yList = double(yList); 
Xmatrix = [ones(numTrainData,1) trainX]; % prediction is linear in 
Xmatrix = double(Xmatrix); % convert to logical variable to 'real numbers'
Binput = zeros(vectorSize+1,1);

% Set some options for the optimization run
options = optimset('MaxFunEvals',20000,'display','iter'); % default optimization options

% performs 'optimization'
[Bresult,fVal] = fminunc(@logisticLogLossContinuous,Binput,options,Xmatrix,yList);

    for iIndex = 1:30 % display 10 images
        
        iDisplayed = randsample(numTestData,1); % randomly select a number between 1 and number of test images
        M = testX(iDisplayed,:); % pull-out one image
        imageDisplayFromVector(M,Wpixel,Hpixel);
        
        z = double([1 M])*Bresult; % basically computes b0 + b1*M(1) + b2*M(2) + ...
        if z>=0
            s = [ ' even '];
        else
            s = [ ' odd '];
        end
        title({'grayscale image',['MNIST thinks this is the number ' num2str(num2str(testY(iDisplayed)))],['OUR CLASSIFIER thinks it is: ' s]},'fontsize',15)        
            pause
        
    % computing the overall accuracy on the TEST dataset
    Xmatrix_test = [ones(numTestData,1) testX]; % construct the Xmatrix for the test dataset
    Xmatrix_test = double(Xmatrix_test); % convert to double
    zList_test = Xmatrix_test*Bresult; % zlist for the test dataset 
    yList_predicted = (zList_test>=0);
    yList_test = (testY==whatNumber(1)|testY==whatNumber(2)|testY==whatNumber(3)...
    |testY==whatNumber(4)|testY==whatNumber(5))'; 
    accuracy = sum(yList_test==yList_predicted)/length(yList_test);

    % accuracy on train dataset
    Xmatrix_train = [ones(numTrainData,1) trainX]; % construct the Xmatrix for the test dataset
    Xmatrix_train = double(Xmatrix_train); % convert to double
    zList_train = Xmatrix_train*Bresult; % zlist for the test dataset
    yList_predictedtrain = (zList_train>=0); % the decision rule is z>=0 for the image being 5 (or whatever whatNumber is)
    yList_train = (trainY==whatNumber(1)|trainY==whatNumber(2)|trainY==whatNumber(3)...
        |trainY==whatNumber(4)|trainY==whatNumber(5))'; % ground truth data: converting the test labels in textY into a 5 or not-5 binary dataset
    accuracy_train = sum(yList_train==yList_predictedtrain)/length(yList_train);
    
    disp(['The accuracy of this logistic regression is ' num2str(accuracy*100) ' percent']);
    disp(['The train accuracy of this logistic regression is ' num2str(accuracy_train*100) ' percent']);
    disp(['in detecting whether a number is ' num2str(whatNumber) ' or not']);
    disp(' ');
    disp(['Is this a high percentage? For answer, see comments in the code.']);

    % separating this into two types of error: false positive and false negative error rates
    temp = (yList_test==0); 
    errorRate_FalsePositive = ...
        sum(yList_test(temp)~=yList_predicted(temp))/sum(temp)
    
    errorRate_FalseNegative = ...
        sum(yList_test(~temp)~=yList_predicted(~temp))/sum(~temp)
    
    save(['Run_ToDetect' num2str(whatNumber) '.mat'],'Bresult');
    
end
%% c
load('mnist.mat');
whatNumber = 7;
% classified to determine whether a given image is 7 or not
trainX = trainX(1:10000,:);
trainY = trainY(:,1:10000);

% checking size of things
numTrainData = length(trainY); % 60,000
numTestData = length(testY); % 10,000
Wpixel = 28; Hpixel = 28; % 28 x 28 = 784 pixels per image
vectorSize = 28*28; % dimensionality of the input data

yList = (trainY==whatNumber); % y will be 1 if trainY = 7 and y will be 0 if trainY is not 7 (assuming whatNumber = 7)

yList = double(yList); % convert to double precision 'real number' because matrix multiplication does not work with logical data

Xmatrix = [ones(numTrainData,1) trainX]; % prediction is linear in 
Xmatrix = double(Xmatrix); % convert to logical variable to 'real numbers'
Binput = zeros(vectorSize+1,1);

% Set some options for the optimization run
options = optimset('MaxFunEvals',100000,'display','iter'); % default optimization options

% performs 'optimization'
[Bresult,fVal] = fminunc(@logisticLogLossContinuous,Binput,options,Xmatrix,yList);

    for iIndex = 1:30 % display 10 images
        
        iDisplayed = randsample(numTestData,1); % randomly select a number between 1 and number of test images
        M = testX(iDisplayed,:); % pull-out one image
        imageDisplayFromVector(M,Wpixel,Hpixel);
        
        z = double([1 M])*Bresult; % basically computes b0 + b1*M(1) + b2*M(2) + ...
        if z>=0
            s = ['A ' num2str(whatNumber)];
        else
            s = ['NOT A ' num2str(whatNumber)];
        end
        title({'grayscale image',['MNIST thinks this is the number ' num2str(num2str(testY(iDisplayed)))],['OUR CLASSIFIER thinks it is: ' s]},'fontsize',15)        
            pause
        
    % computing the overall accuracy on the TEST dataset
    Xmatrix_test = [ones(numTestData,1) testX]; % construct the Xmatrix for the test dataset
    Xmatrix_test = double(Xmatrix_test); % convert to double
    zList_test = Xmatrix_test*Bresult; % zlist for the test dataset 
    yList_predicted = (zList_test>=0);
    yList_test = (testY==whatNumber)'; 
    accuracy = sum(yList_test==yList_predicted)/length(yList_test);

    % accuracy on train dataset
    Xmatrix_train = [ones(numTrainData,1) trainX]; % construct the Xmatrix for the test dataset
    Xmatrix_train = double(Xmatrix_train); % convert to double
    zList_train = Xmatrix_train*Bresult; % zlist for the test dataset
    yList_predictedtrain = (zList_train>=0); % the decision rule is z>=0 for the image being 7 (or whatever whatNumber is)
    yList_train = (trainY==whatNumber)'; % ground truth data: converting the test labels in textY into a 7 or not-7 binary dataset
    accuracy_train = sum(yList_train==yList_predictedtrain)/length(yList_train);
    
    disp(['The accuracy of this logistic regression is ' num2str(accuracy*100) ' percent']);
    disp(['in detecting whether a number is ' num2str(whatNumber) ' or not']);
    disp(' ');
    disp(['Is this a high percentage? For answer, see comments in the code.']);

    % separating this into two types of error: false positive and false negative error rates
    % false positives: when the image is not a 7 (y=0) but the algorithm says
    % its a 5
    temp = (yList_test==0); % where the real image is not a 7
    errorRate_FalsePositive = ...
        sum(yList_test(temp)~=yList_predicted(temp))/sum(temp)
    
    errorRate_FalseNegative = ...
        sum(yList_test(~temp)~=yList_predicted(~temp))/sum(~temp)
    
    save(['Run_ToDetect' num2str(whatNumber) '.mat'],'Bresult');
    
end