clear; 
close all; 
clc;

load('DatRobotManipulator.mat')
%% question a
theta1 = theta1Store;
theta2 = theta2Store;
X = [ones(size(theta1)), xBStore, yBStore];

A = regress(theta1, X);
B = regress(theta2, X);

Etheta1 = theta1-X*A; % array of errors for theta1
MSE1 = mean(Etheta1.^2); % mean of the squared error for theta1

Etheta2 = theta2-X*B; % array of errors for theta2
MSE2 = mean(Etheta2.^2); % mean of the squared error for theta2

%% question b
Xb = [ones(size(theta1)), xBStore, yBStore, xBStore.^2, yBStore.^2, xBStore.*yBStore];

Ab = regress(theta1, Xb);
Bb = regress(theta2, Xb);

Etheta1b = theta1-Xb*Ab; % array of errors for theta1
MSE1b = mean(Etheta1b.^2); % mean of the squared error for theta1

Etheta2b = theta2-Xb*Bb; % array of errors for theta2
MSE2b = mean(Etheta2b.^2); % mean of the squared error for theta2