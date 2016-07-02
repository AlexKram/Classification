function featureNames = feature_names(varargin)
% FEATURE_NAMES -
%
% --- INPUT ---
%   NameExtension   - Cell of name extensions (strings) with the size of 
%                     Cx1.
%
% --- OUTPUT ---
%   featureNames    - Cell of feature names (strings) with the size of
%                     1x(12*C). If NameExtension is not empty, names of the
%                     features are extended by the presented extensions.
%
% ------------------------------------------------
% Version 1.3.0.
% Created       - 20.06.2016 Alexander Kramlich
% Last modified - 30.06.2016 Alexander Kramlich
% ------------------------------------------------

p = inputParser;
defaultNameExtension = {};
addOptional(p, 'NameExtension', defaultNameExtension, @(x) iscell(x));
parse(p, varargin{:});

NameExtension = p.Results.NameExtension;
R = size(NameExtension, 1);

featureNames = {'mean',...
                'variance',...
                'skewness',...
                'kurtosis',...
                'meanPSD', ...
                'variancePSD',...
                'skewnessPSD',...
                'kurtosisPSD',...
                'peakPSD',...
                'peaklocationPSD',...
                'energyPSD',...
                'centroidlocationPSD'};

C = length(featureNames);

if R > 1
    featureNames = repmat(featureNames, [1,R]);
end

for r=1:R
    featureNames(((r-1)*C+1):r*C) = strcat(featureNames(((r-1)*C+1):r*C), NameExtension{r});
end
