%% Example Batch Input file for AOX_Balcal, (c) Akshay Naik, NASA AOX 2021
% INIT, don't change
% RULES: 
%   --Each parameter must be an array with a value for each file input.
%       i.e. for 2 files: calfile is a string array of size 2x1. GRBF is a vector of size 2...etc.
%       Regardless if paramters are identical for each file, there must be a value for each file.

% Not used, just by me to simplify making the arrays for each parameter and defining filepaths for this example.
cpath   = pwd; % here to simplify the file path--pulls the parent directory of AOX_Balcal so BE CAREFUL USING THIS TO SET YOUR FILE PATHS
nfile = 2;

%% Universal Program Parameters

pmode  = [1,1];    % Program Mode for each file
                    %   1: Balance Calibration Mode
                    %   2: General Function Approximation Mode

fmode   = [1,2];    % File Analysis Mode for each file:
                    %   1: calibration only
                    %   2: + validation
                    %   3: + approximation
                    %   EACH FILE MUST HAVE A MODE ASSOCIATED WITH IT
                    %   SIZE of fmode, calfile, valfile, apprxfile MUST == NFILE

%% INPUT FILES for Cal, Val, Approx
% calfile, valfile, and approxfile MUST be same size! i.e. if file 1 wants validation, but file 2 doesn't, set a placeholder for the first value in string array
%   MUST also be VERTICAL vectors--n rows, 1 column. They will be combined into one n x 3 array by batch file processing.
% For files: use "/" as folder delimiter for compatibility with Unix/Mac and Windows. Start the path AFTER root balcal path (for now)
calfile = ["/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv";...
"/1MoreExamples/12 DATA SETS - BALFIT Comparisons/11. LargeArtificial-NoisyPerfect/MC60E-LargeArtificial-NoisyPerfect-2018_cal_rand.csv"];
calfile = pwd + calfile;


% validation files
valfile = ["";...
"/1MoreExamples/12 DATA SETS - BALFIT Comparisons/11. LargeArtificial-NoisyPerfect/MC60E-LargeArtificial-NoisyPerfect-2018_cal_rand.csv"];
valfile = pwd + valfile;

% approximation files
apprxfile = ["";""];

% output_location = pwd;     % output_location defines ONE place for the location of all output files. Can be omitted--default = outputs saved in same location as calfiles

%% Algebraic Model Options
modelTag = 'full';          % Analogous to the tags in the GUI--options are:
                                % 'full'
                                % 'truncated'
                                % 'custom'
                                % 'balanceType'
                                % 'termSelect'


%% GRBF Options
grbf = ones(nfile);         % GRBF Mode on (1) or off (0)
basis = 10*ones(nfile);     % Number of basis functions
selfTerm = 4*ones(nfile);   % Self-termination options:
                                % 1: No early termination
                                % 2: PRESS Termination
                                % 3: Prediction Interval Termination
                                % 4: VIF + Prediction Interval Termination (recommended/default)
min_eps = 0.07*ones(nfile); % default: 0.07
max_eps = 1.0*ones(nfile);  % default: 1.0
rbf_vif_thresh = 10;        % default: 10