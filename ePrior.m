function stmPrior = ePrior(mu,theta,w,stmSpc,stepSize,p)
% specify the prior distribution, which is a mixture of
% Gaussian and uniform distributions
if ~exist('stepSize','var')    || isempty(stepSize)    stepSize = abs(stmSpc(2)-stmSpc(1)); end
if ~exist('mu','var')          || isempty(mu)          mu = 0; end
if ~exist('theta','var')       || isempty(theta)       theta = 0; end
if ~exist('p','var')           || isempty(p)           p = 1/(numel(mu(:)) * numel(theta(:))); end

unifCpt        = 1./range(stmSpc);
muRad          = deg2rad(mu);
thetaRad       = deg2rad(theta);
mu_mat         = repmat(muRad(:),2,1);
sigma_mat      = repmat(thetaRad,4,1);
mixGauss       = sum(p.*normpdf(stmSpc,mu_mat(:),sigma_mat(:)));
stmPrior       = mixGauss.*w + unifCpt.*(1-w);  % uniform distribution

