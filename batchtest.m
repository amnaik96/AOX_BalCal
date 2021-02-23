%% Example Batch Input file for AOX_Balcal, (c) Akshay Naik, NASA AOX 2021
% INIT, don't change

%% User Inputs
cpath   = pwd; % here to simplify the file path--pulls the parent directory of AOX_Balcal so BE CAREFUL USING THIS TO SET YOUR FILE PATHS

fmode   = [1,1]     % Program Mode for each file:
                    %   1: calibration only
                    %   2: cal + val
                    %   3: cal + approx
                    %   4: general function approximation
                    %   5: gen + val
                    %   6: gen + approx
                    %   EACH FILE MUST HAVE A MODE ASSOCIATED WITH IT.

% For files: use "/" as folder delimiter for compatibility with Unix/Mac and Windows. Start the path AFTER root balcal path (for now)
calfile = ["/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv";...
"/1MoreExamples/12 DATA SETS - BALFIT Comparisons/11. LargeArtificial-NoisyPerfect/MC60E-LargeArtificial-NoisyPerfect-2018_cal_rand.csv"];
% appfile = "/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv"
calfile = pwd + calfile;