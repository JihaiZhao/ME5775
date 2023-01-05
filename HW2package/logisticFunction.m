function f = logisticFunction(z)

% this function is what we called g(z) in our lecture notes. this function
% is sigmoid or s-shaped in z

f = 1./(1+exp(-z)); % this is the main part of the function

% this following statement makes sure that the evaluation absolutely always
% returns a value that is >=0 and <=1. 
f = (f>=1)*1 + (f<=0)*0 + ((f>0)&(f<1)).*f;
% while the function 1/(1+exp(-z)) is >=0 and <=1, the above statement
% makes sure that we do not violate this property due to very small
% numerical errors (usually at the 12th decimal place).

end