function [vBins,edges] = tallyIntoBins(X,nBin,edges)
if  ~exist('edges','var') || isempty(edges)
    sp = 45;
    edges         = linspace(-sp,sp,nBin + 1)./180.*pi;
    edges(1)      = min(X,[],'all')./180.*pi; edges(end) = max(X,[],'all')./180.*pi;
end
nTr           = length(X);
X             = X./180.*pi;
bin_          = discretize(X,edges,'IncludedEdge','left');
vBins         = nan(nBin,nTr);
for jj = 1 : nTr
    for ii = 1:nBin
        ind    =  find(bin_(:,jj) == ii);
        if ~isempty(ind)
            vBins(ii,jj) = sum(X(ind,jj));
        else
            vBins(ii,jj) = 0; % replace with the mean of the range-no evidence
        end
    end
end





