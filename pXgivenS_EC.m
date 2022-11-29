function [pXgivenS_E,mapping_fun]  = pXgivenS_EC(X,S,IntN,priorMn,priorVar,Wgt,pDst) 
% X: measurments; S: stimulus in physical space
% compute p(x|s) based on efficient coding model
snsSpc        = S; % sensory space 
stepSize      = abs(S(2) - S(1)); 
prior         = ePrior(priorMn,priorVar,Wgt,S,stepSize,pDst);  
mapping_fun   = cumtrapz(S, prior) * 2*pi-pi;                         % the cumulative mapping function
ivsStmSpc     = interp1(mapping_fun, S, snsSpc,  'linear', 'extrap'); % prior distribution an observer learned in the experiment
cnst          = 1./(2*pi*besseli(0,IntN));
pXgivenS_     = exp(IntN.*cos(X-S')).*cnst;   % p(x = 1|s) 
% asymmetric likelihood function: columns indicate likelihood functions 
pXgivenS_E    = interp1(ivsStmSpc, pXgivenS_, S, 'linear', 'extrap');
