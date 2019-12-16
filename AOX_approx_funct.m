function [aprxINminGZapprox,loadPI_approx]=AOX_approx_funct(coeff,natzerosapprox,excessVecapprox,FLAGS,seriesapprox,series2approx,pointIDapprox,loadlist,output_location,GRBF,ANOVA,pct)
%Function performs all calculations and outputs for approximation.  This
%function can be called by both the main AOX_balcal code or the standalone
%approximation code

%INPUTS:
%  coeff = Calibration Coefficients
%  natzerosapprox  =  Natural zero voltages
%  excessVecapprox  =  Approximation voltages
%  FLAGS  =  User option flags
%  seriesapprox  =  Series labels
%  series2approx  =  Series2 labels
%  pointIDapprox  =  data point IDs 
%  loadlist  =  channel load labels
%  output_location  =  save location for output files
%  GRBF  =  Structure containing GRBF centers, widths, and coefficients if RBFs were placed in calibration
%  ANOVA  =  ANOVA results needed for calculating PI
%  pct  =  Percent confidence level for PI

%OUTPUTS:
% aprxINminGZapprox = Global Load Approximation
% loadPI_approx = Prediction Interval for Global Load Approximations

%natural zeros (also called global zeros)
globalZerosapprox = mean(natzerosapprox,1);

% Subtract the Global Zeros from the Inputs
dainputsapprox = excessVecapprox-globalZerosapprox;

% Call the Algebraic Subroutine
comINapprox = balCal_algEqns(FLAGS.model,dainputsapprox,seriesapprox,0);

%LOAD APPROXIMATION
%define the approximation for inputs minus global zeros
aprxINapprox = comINapprox*coeff;        %to find approximation AJM111516
aprxINminGZapprox.ALG = aprxINapprox;

if FLAGS.loadPI==1
    loadPI_approx.ALG=calc_PI(ANOVA,pct,comINapprox,aprxINapprox); %Calculate load PI
else
    loadPI_approx='PI NOT COMPUTED';
end

%OUTPUT
fprintf('\n ********************************************************************* \n');

%OUTPUTING APPROXIMATION WITH PI FILE
if FLAGS.approx_and_PI_print==1
    section='APPROX ALG';
    load_and_PI_file_output(aprxINminGZapprox.ALG,loadPI_approx.ALG,pointIDapprox,seriesapprox,series2approx,loadlist,output_location,section)

elseif FLAGS.excel == 1
    %Output approximation load approximation
    filename = 'APPROX ALG Global Load Approximation.csv';
    approxinput=aprxINminGZapprox.ALG;
    description='APPROXIMATION ALGEBRAIC MODEL LOAD APPROXIMATION';
    print_approxcsv(filename,approxinput,description,pointIDapprox,seriesapprox,series2approx,loadlist,output_location);
else
    fprintf('\nAPPROXIMATION ALGEBRAIC MODEL LOAD APPROXIMATION RESULTS: Check aprxINminGZapprox in Workspace \n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    RBF SECTION FOR APPROXIMATION     AJM 6/29/17                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%goal to use centers, width and coefficients to approxate parameters against
%independent data

if FLAGS.balCal == 2

    comINapprox_RBF=create_comIN_RBF(dainputsapprox,GRBF.epsHist,GRBF.center_daHist,GRBF.h_GRBF); %Generate comIN for RBFs
    comINapprox_algRBF=[comINapprox, comINapprox_RBF]; %Combine comIN from algebraic terms and RBF terms to multiply by coefficients
    
    aprxINminGZ2approx=comINapprox_algRBF*GRBF.coeff_algRBFmodel; %find approximation with alg and RBF Coefficients
    
    if FLAGS.loadPI==1
        loadPI_approx.GRBF=calc_PI(GRBF.ANOVA,pct,comINapprox_algRBF,aprxINminGZ2approx); %Calculate load PI
    else
        loadPI_approx='PI NOT COMPUTED';
    end
    
    %OUTPUT
    aprxINminGZapprox.GRBF=aprxINminGZ2approx;
    
    fprintf('\n ********************************************************************* \n');
    if FLAGS.approx_and_PI_print==1
        section='APPROX GRBF';
        load_and_PI_file_output(aprxINminGZapprox.GRBF,loadPI_approx.GRBF,pointIDapprox,seriesapprox,series2approx,loadlist,output_location,section)
        
    elseif FLAGS.excel == 1
        %Output approximation load approximation
        filename = 'APPROX GRBF Global Load Approximation.csv';
        approxinput=aprxINminGZapprox.GRBF;
        description='APPROXIMATION ALGEBRAIC+GRBF MODEL LOAD APPROXIMATION';
        print_approxcsv(filename,approxinput,description,pointIDapprox,seriesapprox,series2approx,loadlist,output_location);
    else
        fprintf('\nAPPROXIMATION ALGEBRAIC+GRBF MODEL LOAD APPROXIMATION RESULTS: Check aprxINminGZapprox in Workspace \n');
    end
     
end
% END APPROXIMATION GRBF SECTION