function dfdx = myGradient_CentralDifference(inputfn,X0,accuracy_feval,varargin)
%MYGRADIENT Numerical GRADIENT of a vector-valued function.
%   DFDX = MYGRADIENT(FUN,X0,ACCFEVAL) tries to find a central difference
%   approximation of the gradient of function FUN at X0. FUN accepts a
%   real COLUMN vector input X and returns a scalar function value
%   evaluated at X within an error of ACCFEVAL. The (truncation) error in
%   each element of DFDX is about O(ACCFEVAL^0.66). Note: If FUN eats
%   only column vectors use X0' as the argument above.
%
%   DFDX = MYGRADIENT(FUN,X0,ACCFEVAL,P1,P2,...) allows for additional arguments
%   which are passed to the function, F=feval(FUN,X,P1,P2,...). The gradient
%   however is still calculated with respect to the first argument X of the
%   function.
%
%   March 01, 2002, Manoj Srinivasan.

if nargin < 3
    error('This function requires at least three input arguments. Do "help myJacobian_CentralDifference"');
end

% s = size(xx);

N=length(X0); Ns=size(X0);
if Ns(2)>Ns(1)
    error('Input should be a column vector, not a row vector.');
end

dfdx = [];  

% this is roughly the optimal step size for using central difference
% approximation
del = accuracy_feval^(1/3); 

v0 = feval(inputfn,X0,varargin{:}); % evaluate the function at the given point

[vRow,vCol] = size(v0);
if (vCol>1)||(vRow>1)
    error('the function must return a scalar, not a row or column vector.');
end

for i=1:N % loop over all input variables
    vprev = feval(inputfn,[X0(1:i-1);X0(i)-del;X0(i+1:N)],varargin{:}); % take a step forward
    vpost = feval(inputfn,[X0(1:i-1);X0(i)+del;X0(i+1:N)],varargin{:}); % take a step backward
    dfdx = [dfdx; (vpost-vprev)/(2*del)]; % central difference approximation along the i'th direction
end

end
