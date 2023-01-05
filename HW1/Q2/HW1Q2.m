clear; 
close all; 
clc;

load('auto-mpg.data')

Y = auto_mpg(:,1);
X = [ones(size(Y)),auto_mpg(:,2),auto_mpg(:,3),auto_mpg(:,4),auto_mpg(:,5),auto_mpg(:,6)]; 
B = regress(Y,X);

b0 = B(1);
b1 = B(2);
b2 = B(3);
b3 = B(4);
b4 = B(5);
b5 = B(6);

%% question d
% mpg will decrease when displacement,horsepower,weight(influence is small) 
% cylinders and acceleration increase
