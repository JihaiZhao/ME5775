clear; close all; clc;

syms x1 x2 x3;

%% given some complex expression for a function f of many variables
% for instance:
% f = (x1^2*sin(x2)+x2^3*tan(x3))
f = (2-x1)^2 + 10*(x2-x1^2)^2;

%% the analytical gradient can be computed using the jacobian function as
% follows
% grad_f = jacobian(f, [x1; x2; x3])
grad_f = jacobian(f, [x1; x2])

%% you can also assemble the analytical gradient using the individual
% partial derivatives
% grad_f = [diff(f,x1); diff(f,x2); diff(f,x3)]
grad_f = [diff(f,x1); diff(f,x2)]

%% we can compute the value of the gradient (derivatives) 
% by substituting values for [x1, x2, x3]
X0 = [0; 4];
grad_f_numbers = double(subs(grad_f,[x1; x2],X0))

%% computing using numerical differentiation

% using central difference
% point at which the derivatives are taken
accuracy_feval = 1e-15; % accuracy to which f is evaluated by MATLAB
grad_f = myGradient_CentralDifference('fObjectiveFunction',X0,accuracy_feval)