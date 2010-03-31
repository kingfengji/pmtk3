%% Simple test of MixDiscreteFitEM
%% Create Data
setSeed(0);
truth.nmix = 6;
truth.d = 80;
truth.nstates = 10;
truth.mixweight = normalize(rand(1, truth.nmix));
truth.T = normalize(rand(truth.nstates, truth.d, truth.nmix), 1);
nsamples = 1000;
[X, y] = mixDiscreteSample(truth, nsamples); 
%% Fit
model = mixDiscreteFitEM(X, truth.nmix);
%% Compare against the best permutation of the cluster labels.
ypred = mixDiscreteInfer(model, X);
allperms = perms(1:model.nmix);
nperms = size(allperms, 1); 
errors = zeros(nperms, 1); 
for i=1:nperms
    errors(i) = sum(y ~= allperms(i, ypred)');
end
ypred = allperms(minidx(errors), ypred)';
errorRate = mean(y~=ypred)