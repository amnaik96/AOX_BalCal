cpath = pwd;
% For files: use "/" as folder delimiter for compatibility with Unix/Mac and Windows. Start the path AFTER root balcal path (for now)
calfile =["/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv";...
"/1MoreExamples/12 DATA SETS - BALFIT Comparisons/11. LargeArtificial-NoisyPerfect/MC60E-LargeArtificial-NoisyPerfect-2018_cal_rand.csv"];
% appfile = "/1MoreExamples/12 DATA SETS - BALFIT Comparisons/12. LargeArtificial-CleanPerfect/Test_MC60E-LargeArtificial-CleanPerfect-2018.csv"
calfile = pwd + calfile;