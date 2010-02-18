% check that different fitting methods for ridge regression give same result

n = 10;
X = rand(n,2);
%X = [ones(n,1) X];
y = randn(n,1);
lambda = 1e-2;
model1 = linregFitL2(X, y, lambda, 'QR');
model2 = linregFitL2(X, y, lambda, 'minfunc');
assert(approxeq(model1.w, model2.w))
assert(approxeq(model1.w0, model2.w0))