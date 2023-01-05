function [modelcoeffs, fval] = L1regression(YOutput,XInput)
% Manoj Srinivasan, 2012
% This function finds a linear relation between input columns (XInput) and
% output columns (YOutput) by minimizing the mean or summed absolute error
% between the linear relation and the output. Also called LAR in MATLAB
% (LAR = Least Absolute Residual).
% The syntax for the input is the same as that of regress.
% It uses linear programming for solving this problem, which can be
% converted into an optimization problem with linear objective function and
% linear constraints.

NumCoeffs = size(XInput,2);
NumDataPoints = size(XInput,1);

NumUnknowns = NumCoeffs+NumDataPoints;

%% Assemble the equality and inequality constraints constraints for the slack variables
LB = -Inf*ones(NumUnknowns,1);
UB = +Inf*ones(NumUnknowns,1);

Aineq_temp1 = zeros(NumDataPoints,NumUnknowns);
Aineq_temp1(1:NumDataPoints,1:NumDataPoints) = -eye(NumDataPoints);
Aineq_temp1(1:NumDataPoints,end-NumCoeffs+1:end) = XInput;
Bineq_temp1 = YOutput;

Aineq_temp2 = zeros(NumDataPoints,NumUnknowns);
Aineq_temp2(1:NumDataPoints,1:NumDataPoints) = -eye(NumDataPoints);
Aineq_temp2(1:NumDataPoints,end-NumCoeffs+1:end) = -XInput;
Bineq_temp2 = -YOutput;

Aineq = [Aineq_temp1; Aineq_temp2];
Bineq = [Bineq_temp1; Bineq_temp2];

Aeq = []; Beq = [];

% objective function
f = [1*ones(NumDataPoints,1); 0*ones(NumCoeffs,1)];

[presult, fval] = linprog(f,Aineq,Bineq,Aeq,Beq,LB,UB);

modelcoeffs = presult(end-NumCoeffs+1:end);

end