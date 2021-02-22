% Batch run alternate input file (can be used in lieu of the GUI)
% (c) Akshay Naik, NASA AOX 2021
% Specify a set of files and inputs for Balcal (for now, single run only. Batch support next).
%   GUI_out collects the option flags from this file and sends them to AOX_Balcal
%   Place this INPUT file in the same location as AOX_BalCal.m. It uses the Balcal root directory as a reference to make picking the file easier.
%   This is meant for users who are already very familiar with Balcal. Friendlier input is available using the GUI.


%% File(s) to run
mode = 1;           % Mode: 1--balance calibratin mode, 2--general approximation mode
action = 1;         % Action: 1--calibration only, 2--calib + validation, 3--calib + approximation. Ignored if mode=2
cpath = pwd;
% For files: use "/" as folder delimiter for compatibility with Unix/Mac and Windows. Start the path AFTER root balcal path (for now)
calfile = "/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv"
valfile = "/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv"
appfile = "/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv"
calpath = pwd + calfile;
%% OPTIONS
%% Algebraic Model Type
algmodel        = "full"       % algmodels: "full", "truncated", "linear", "none", "balance"
balancetype     = "1A"        % Balance types: 1A, 1B, 1C, 1D, 2A, 2B, 2C, 2D, 2E, 2F (all strings). Specify if algmodel = "balance"
%% GRBF Addition
grbf            = 1;               % Include GRBFs: 1, Not: 0
numBasisIn      = 10;        % number of basis functions
selfTerm_pop    = "Prediction Interval Termination";
min_eps         = 0.07; % default = 0.07
max_eps         = 1.0;  % default = 0.1
RBF_VIF_thresh  = 10;   % default = 10
%% Model Options
intercept_pop   = 1;    % 1 = series specific, 2 = global, 3 = no intercept
anova_FLAGcheck = 1;    % 1: anova enabled, 0: disabled
anova_pct       = 95;   % anova confidence interval (%)


BALFIT_Matrix   = 1;    % print BALFIT coefficient matrix
Rec_Model       = 1;    % print recommended Alg model csv file
approx_and_PI_print = 1; % print load w/ prediction interval csv file
output_location = calpath; % placeholder--make it the enclosing folder