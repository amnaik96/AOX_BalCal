function [in_comb,high,high_CELL] = balCal_algEqns(model_FLAG,in,series,intercept_FLAG,voltagelist,normFLAG)
%Function creates matrix of predictor variables for algebraic model by
%combining measured variables (voltages).  Combined terms are determined by
%the model selected

%INPUTS:
%  model_FLAG = Flag for model selected: 3=linear, 2=Trunctated, 1=Full, 4= Custom (assembled same as full)
%  in  =  Matrix of measured voltages.  Each row is observation, columns are channels
%  series  =  Series labels for each point
%  intercept_FLAG  =  Flag if series intercepts should be included. Included for calibration, not validation
%  voltagelist  =  Chanel labels for voltages
%  normFlag  =  Flag for if predictor variables should be normalized

%OUTPUTS:
%  in_comb = Maxtrix of predictor variables. Each row is an observation, each column is predictor variable
%  high = Matrix of term hierarchy
%  high_CELL = Matrix of term hierarchy with labels, mainly for debugging purposes

%'high' is matrix of term hierarchy.  To find terms needed for a variable
%to be supported: Find variable in row, go accross row to find '1' in
%columns
%'high_CELL' includes labels, mainly for debugging purposes

if nargin <6
    normFLAG = 0;
end

if normFLAG == 1
    range = max(in) - min(in);
    shift = min(in) + range/2;
    in_n = (in - shift)./(range/2);
else
    in_n = in;
end

% Detect the size of the input
n = size(in_n,1); %number of data points
d = size(in_n,2); %data dimensionality.

%Generate labels for hierarchy table
loadlist(1:d)=num2cell(1:d);
if nargin <5
    voltagelist(1:d)=num2cell(1:d);
end
[term_labels, ~]=customMatrix_labels(loadlist,voltagelist,d,d,model_FLAG,'voltages');
%FOR HIERARCHY OF TERMS: TO FIND TERMS NEEDED FOR VARIABLE TO BE SUPPORTED:
%FIND VARIABLE IN ROW, GO ACCROSS ROW TO FIND '1' IN COLUMNS

if model_FLAG == 3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%LINEAR MODEL
    in_comb = in_n;%                                                        3
    
    %Assemble hierarchy matrix
    high=zeros(size(in_comb,2));
    high_CELL=[[{" "};term_labels],[term_labels';num2cell(high)]];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    in_comb = interceptTerms(in_comb,series,intercept_FLAG);
    return
end

in_sq = in_n.^2;
in_sq_high=eye(d); %hierarchy for squared terms

j = 1;
ini_inj = zeros(n,(d^2-d)/2);
ini_inj_high=zeros((d^2-d)/2,d); %hierarchy for cross terms

for k = 1:d-1
    for m = k+1:d
        ini_inj(:,j) = in_n(:,k).*in_n(:,m);
        ini_inj_high(j,k)=1; %hierarchy for cross terms
        ini_inj_high(j,m)=1; %hierarchy for cross terms
        j = j+1;
    end
end
if model_FLAG == 2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TRUNCATED MODEL
    in_comb = [in_n,      ...                                               2
        in_sq,   ...
        ini_inj];
    
    %Assemble hierarchy matrix
    high=zeros(size(in_comb,2));
    high(d+1:2*d,1:d)=in_sq_high;
    high(2*d+1:2*d+((d^2-d)/2),1:d)=ini_inj_high;
    high_CELL=[[{" "};term_labels],[term_labels';num2cell(high)]];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    in_comb = interceptTerms(in_comb,series,intercept_FLAG);
    return
end


abs_in = abs(in);
if normFLAG == 1
    range = max(abs_in) - min(abs_in);
    shift = min(abs_in) + range/2;
    abs_in = (abs_in - shift)./(range/2);
end

in_absin = in_n.*abs_in;
in_absin_high=[eye(d),eye(d)]; %hierarchy for in_absin terms


j = 1;
abs_iniinj = zeros(n,(d^2-d)/2);
ini_absinj = zeros(n,(d^2-d)/2);
absini_inj = zeros(n,(d^2-d)/2);
abs_iniinj_high=zeros((d^2-d)/2,d); %hierarchy for absolute value cross terms
ini_absinj_high=zeros((d^2-d)/2,2*d); %hierarchy for ini_absinj terms
absini_inj_high=zeros((d^2-d)/2,2*d); %hierarchy for absini_inj terms

for k = 1:d-1
    for m = k+1:d
        abs_iniinj(:,j) = abs_in(:,k).*abs_in(:,m);
        abs_iniinj_high([j,j],[k,m])=1; %hierarchy for absolute value cross terms
        ini_absinj(:,j) = in_n(:,k).*abs_in(:,m);
        ini_absinj_high([j,j],[k,d+m])=1; %hierarchy for ini_absinj terms
        absini_inj(:,j) = abs_in(:,k).*in_n(:,m);
        absini_inj_high([j,j],[k+d,m])=1; %hierarchy for absini_inj terms
        j = j+1;
    end
end
in_cu = in_n.^3;
in_cu_high=[eye(d),zeros(d),eye(d)]; %hierarchy for cubic terms
abs_incu = abs_in.^3;
abs_incu_high=[zeros(d),eye(d),eye(d)]; %hierarchy for absolute value cubic terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FULL MODEL
in_comb = [in_n,        ...                                                 1
    abs_in,    ...
    in_sq,     ...
    in_absin,  ...
    ini_inj,   ...
    abs_iniinj,...
    ini_absinj,...
    absini_inj,...
    in_cu,     ...
    abs_incu];

%Assemble hierarchy matrix
high=zeros(size(in_comb,2));
high(2*d+1:3*d,1:d)=in_sq_high;
high(3*d+1:4*d,1:2*d)=in_absin_high;
high(4*d+1:4*d+((d^2-d)/2),1:d)=ini_inj_high;
high(4*d+((d^2-d)/2)+1:4*d+2*((d^2-d)/2),d+1:2*d)=abs_iniinj_high;
high(4*d+2*((d^2-d)/2)+1:4*d+3*((d^2-d)/2),1:2*d)=ini_absinj_high;
high(4*d+3*((d^2-d)/2)+1:4*d+4*((d^2-d)/2),1:2*d)=absini_inj_high;
high(4*d+4*((d^2-d)/2)+1:5*d+4*((d^2-d)/2),1:3*d)=in_cu_high;
high(5*d+4*((d^2-d)/2)+1:6*d+4*((d^2-d)/2),1:3*d)=abs_incu_high;
high_CELL=[[{" "};term_labels],[term_labels';num2cell(high)]];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
in_comb = interceptTerms(in_comb,series,intercept_FLAG);
end

function in_comb = interceptTerms(in_comb,series,intercept_FLAG)
%Function creates series specific intercept terms for calculating tares

%INPUTS:
%  in_comb = Maxtrix of predictor variables. Each row is an observation, each column is predictor variable
%  series  =  Series labels for each point
%  intercept_FLAG  =  Flag if series intercepts should be included. Included for calibration, not validation

%OUTPUTS:
%  in_comb = Maxtrix of predictor variables. Each row is an observation, each column is predictor variable

n = size(in_comb,1);
[~,s_1st,s_id] = unique(series);
nseries = length(s_1st);
ints = zeros(n,nseries);
ids = sub2ind(size(ints),[1:n]',s_id);
ints(ids) = 1;

if intercept_FLAG==1 %If preference for series intercepts is on, add 1's for intercept terms: (These are not included for validation)
    in_comb = [in_comb, ints];
end
end
