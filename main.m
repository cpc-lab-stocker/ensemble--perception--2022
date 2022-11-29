% SIMULATION of EFFICIENT CODING MODEL TO PREDICT ROBUST AVERAGING WITH
% CIRCULAR DATA
%% data simulation
clear; close all
load('./data.mat'); % load data from Li et al., 2017 (available online)
data        = preProcessData(alldata);    % pre-process the data- following the same steps as in Li et al 2017
smSet       = data.drawnangles(:,1:2000); % use part of the data for simulation
dsetMu      = [20,10;-20,-10]';           % mean of the ensembles 
setSigma    = [16,8];                     % variance of the ensembles
p           = 1./(numel(dsetMu) * numel(setSigma)); % probablity of each ensemble condition
%% modeling
% model parameters
IntN        = 3;                          % encoding noise in kappa
Wgt         = [0.1,0.5,1];                % weight of the empirical distribution component in the mixture prior 
pcw         = [];       
% the model predict probability of reporting one category on each trial
for ii = 1: numel(IntN)
    for jj = 1 : numel(Wgt)
     pcw(:,jj,ii)     = eftMdl(IntN(ii),Wgt(jj),smSet,dsetMu,setSigma,p);
    end
end
%% Regresssion analysis
nBin        = 8;                          % numel of bins in the regression analysis
binCoefs_   = [];
for ii = 1: numel(IntN)
    for jj = 1 : numel(Wgt)
        [binX,edges]          = tallyIntoBins(smSet,nBin,[]);
        binCoefs_(:,jj,ii)    = glmfit(binX',pcw(:,jj,ii),'binomial','link','probit');
    end
end
%% plotting
figure % simulation figure similar to Figure 6 in the paper 
plot(1:nBin,binCoefs_(2:end,:),'-','Linewidth',2)
legend({'w = .1','w = .5','w = 1'})
axis square

