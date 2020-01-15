function [V]=vif_dl(X)
% New method for calculating Variance Inflation Coefficients (VIF) for
% predictor variables. Method is much faster than previous approach in
% ANOVA. Agrees for all predictor variables except intercept terms

%INPUTS:
%  X = Matrix of predictor variables. Each row is observation, each column
%  is different predictor variable

%OUTPUTS:
% V = Vector of VIF for all predictor variables.

%vif() computes variance inflation coefficients  
%VIFs are also the diagonal elements of the inverse of the correlation matrix [1], a convenient result that eliminates the need to set up the various regressions
%[1] Belsley, D. A., E. Kuh, and R. E. Welsch. Regression Diagnostics. Hoboken, NJ: John Wiley & Sons, 1980.

orig_state=warning; %Save warning state
warning('off','all'); %Temp turn off warnings

R0 = corrcoef(X); % correlation matrix
V=diag(inv(R0))';

warning(orig_state); %Restore warning state