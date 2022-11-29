function cleanData = preProcessData(Data)

% remove the trials that contained one or more orientations that are
% beyong the range of [-45, 45] relative to the reference (see Li, at el.,
% 2017) and non-registered trials
% PRE-PROCESS DATA
rm_noResp   = find(Data.resp_cat == 999);
[~, col]    = find(Data.drawnangles < -45 | Data.drawnangles > 45);
rm_nonValid = unique(col);
rm_rows     = unique([rm_nonValid',rm_noResp]); 

NEWdat      = structfun(@(x) (transpose(x)), Data, 'UniformOutput', false);
cleanData   = structfun(@(x) (removerows(x, 'ind', rm_rows)), NEWdat, 'UniformOutput', false);
cleanData.resp_cat(cleanData.resp_cat == -1) = 0; 
cleanData   = structfun(@(x) (transpose(x)), cleanData, 'UniformOutput', false);



