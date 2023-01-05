clear; 
close all; 
clc;
%% question a
K = [233 239 244 250 255 261 266 272 278 283 289 294 300 305 ...
    311 316 322 328 333 339 344 350 355 361 366 372 378 383 389 394 400 ...
    405 411 416 422 436 450 464 478 491 505 519 533 547 561 575 589 603 ...
    616 630 644 658 672 686 700 714 741 755 769 783 797 810]';

percentChange = [-0.089 -0.083 -0.076 -0.071 -0.058 -0.046 -0.040 ...
    -0.029 -0.024 -0.013 -0.005 0.002 0.012 0.028 0.028 0.037 0.044 ...
    0.055 0.063 0.073 0.083 0.091 0.100 0.107 0.118 0.128 0.134 0.145 0.151 0.161 0.172...
    0.182 0.191 0.199 0.207 0.236 0.259 0.281 0.309 0.334 0.358 0.383 0.402 0.429 0.455...
    0.484 0.507 0.536 0.563 0.588 0.614 0.636 0.667 0.695 0.724 0.768 0.809 0.831 0.858...
    0.887 0.917 0.945]';

figure(1);
plot(K,percentChange,'o');
xlabel('x'); ylabel('y');

 
%% question b using the 'regress' function
disp('Using regress to find b0 and b1')
Y = percentChange;
X = [ones(size(K)) K]; 
B = regress(Y,X);
b0 = B(1);
b1 = B(2);

%% question b using backslash operator to solve the least squares problem

disp('Using backslach to find b0 and b1')
B = X\Y;
b0 = B(1);
b1 = B(2);

% By comparing, regress function and backslash give the same answer. 

%% question c
E = Y-X*B; % array of errors for all data points
MSE = mean(E.^2); % mean of the squared error
