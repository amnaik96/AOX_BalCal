function [customMatrix_rec]= modelOpt_forward(VIFthresh, customMatrix_permit, loaddimFlag, nterms, comIN0, anova_pct, targetMatrix0, high, FLAGS)
% Function searches for the 'recommended equation' using the approach
% Balfit reference B16 describes as "Forward Selection".
% Function determines optimal combination of terms to include between
% possible upper and lower bounds.
% Upper Bounds: provided current permitted customMatrix
% Lower Bounds: Linear voltage from channel and tares

%See Balfit reference B9 for more complete explanation.
%Flowchart on page 10/21

%INPUTS:
%  VIFthresh = Threshold for max allowed VIF (Balfit Search constraint 2)
%  customMatrix = Current matrix of what terms should be included in Eqn Set.
%  loaddimFlag = Dimension of load data (# channels)
%  nterms = Number of predictor terms in regression model
%  comIN0 = Matrix of predictor variables
%  anova_pct = ANOVA percent confidence level for determining significance
%  targetMatrix0 = Matrix of target load values
%  high = Matrix of term hierarchy
%  FLAGS.high_con = Flag for if term hierarchy constraint is enforced (0=
%       Off, 1= Enforced after search (model is optimized, terms required to
%       support final model are added in), 2=Enforced during search (model is
%       optimized, terms are only added if they are supported by existing model)
%  FLAGS.search_metric_flag = Flag for search metric to return: 1=PRESS (minimize),
%       2=Square Root of Residual Mean Square (minimize), 3=F-Value (maximize)
%  FLAGS.VIF_stop_flag = Flag to terminate search once VIF threshold is
%       exceeded

%OUTPUTS:
%  customMatrix_rec = Optimized recommended custom matrix

high_con=FLAGS.high_con;
search_metric_flag=FLAGS.search_metric;
VIF_stop_flag=FLAGS.VIF_stop;

fprintf('\nCalculating Recommended Eqn Set with Forward Selection Method....')

optChannel=ones(1,loaddimFlag); %Flag for if each channel should be optimized

% Normalize the data for a better conditioned matrix (Copy of what is done
% in calc_xcalib.m)
scale = max(abs(comIN0));
scale(scale==0)=1; %To avoid NaN for channels where RBFs have self-terminated
comIN0 = comIN0./scale;

%Set lower bound of search (Required Math Model)
customMatrix_req=zeros(size(customMatrix_permit));
customMatrix_req(nterms+1:end,:)=1; %Must include series intercepts
customMatrix_req(1:loaddimFlag,1:loaddimFlag)=eye(loaddimFlag); %Must include linear voltage from channel

%Define number of series included:
nseries=size(customMatrix_permit,1)-nterms;

%Initialize optimized math model as required (lower end)
customMatrix_opt=customMatrix_req;

num_permit=sum(customMatrix_permit); %Max number of terms
num_req=sum(customMatrix_req); %Min number of terms
num_terms=sum(customMatrix_opt); %Current count of terms
num_test=(num_permit-num_req)+1; %Number of models to find. 1 for every number of terms from current # to max #

%Initialize variables
VIF_met=false(max(num_test),loaddimFlag); %Matrix for storing if all terms meet VIF constraint
VIF_max=zeros(max(num_test),loaddimFlag); %Initialize variable for storing max VIF at each # terms
sig_all=false(max(num_test),loaddimFlag); %Matrix for storing if all terms are sig at each # terms
P_max=zeros(max(num_test),loaddimFlag); %Matrix for storing max coefficeint p_value at each # terms
search_metric=zeros(max(num_test), loaddimFlag); %Matrix for storing seach metric value at each # terms
if VIF_stop_flag==1
    VIF_blacklist=zeros(size(customMatrix_opt)); %Matrix for tracking terms that violate VIF limit
end

for i=1:loaddimFlag %Loop through all channels
    if optChannel(i)==1 %If optimization is turned on
        %Check initial (required) math model
        [VIF_met(1,i),VIF_max(1,i),sig_all(1,i),P_max(1,i),search_metric(1,i)]=test_combo(comIN0(:,boolean(customMatrix_opt(:,i))), targetMatrix0(:,i), anova_pct, VIFthresh, nseries, search_metric_flag, VIF_stop_flag);
        
        customMatrix_hist=zeros(size(customMatrix_opt,1),num_test(i)); %Matrix for storing custom matrix used
        customMatrix_hist(:,1)=customMatrix_opt(:,1); %First model is required model
        for j=2:num_test(i) %Loop through each # terms from current number to max number
            %Possible terms to be added are those not in current model that are in permitted model
            pos_add=zeros(size(customMatrix_opt,1),1); %Initialize as zeros
            pos_add(~boolean(customMatrix_opt(:,i)))=customMatrix_permit(~boolean(customMatrix_opt(:,i)),i); %Vector of terms that can be added
            
            if VIF_stop_flag==1 %If terminating search based on VIF limit
                pos_add(boolean(VIF_blacklist(:,i)))=0; %Don't add terms that are on 'blacklist' for exceeding VIF threshold
            end
            
            pos_add_idx=find(pos_add); %Index of possible terms for adding to model
            if high_con==2 %If enforcing hierarchy constraint during search
                %Terms are only possible for addition if they are supported
                sup_Terms=high(boolean(pos_add),:); %Matrix of terms that are needed to support each term
                sup_diff=sup_Terms-customMatrix_opt(1:nterms,i)';
                unsup_rows=any(sup_diff==1,2); %Find terms that are not supported
                pos_add_idx(boolean(unsup_rows))=[]; %Remove terms that are unsupported from possibilities to add
            end
            
            if isempty(pos_add_idx) %If no possible terms to add
                break; %Exit for loop testing increasing # of math models
            end
            
            num_pos_add=numel(pos_add_idx); %Count of terms to be tested for adding to model
            
            %Initialize
            VIF_met_temp=false(num_pos_add,1); %Matrix for storing if all terms meet VIF constraint
            VIF_max_temp=zeros(num_pos_add,1); %Initialize variable for storing max VIF at each # terms
            sig_all_temp=false(num_pos_add,1); %Matrix for storing if all terms are sig at each # terms
            P_max_temp=zeros(num_pos_add,1); %Matrix for storing max coefficeint p_value at each # terms
            search_metric_temp=zeros(num_pos_add, 1); %Matrix for storing seach metric value at each # terms
            
            for k=1:num_pos_add %Loop through, testing each possible term to add
                customMatrix_opt_temp=customMatrix_opt(:,i); %Initialize as current custom matrix
                customMatrix_opt_temp(pos_add_idx(k))=1; %Add term for test
                %Test math model with new term added
                [VIF_met_temp(k),VIF_max_temp(k),sig_all_temp(k),P_max_temp(k),search_metric_temp(k)]=test_combo(comIN0(:,boolean(customMatrix_opt_temp)), targetMatrix0(:,i), anova_pct, VIFthresh, nseries, search_metric_flag, VIF_stop_flag);
                if VIF_stop_flag==1 && VIF_met_temp(k)==0 %If adding term violates VIF limit
                    VIF_blacklist(pos_add_idx(k),i)=1; %Add term to blacklist.  Will not try to add again
                end
            end
            
            cMeet_Idx=find(all([VIF_met_temp,sig_all_temp],2)); %Index of tests that met both VIF and significance constraint tests
            if ~isempty(cMeet_Idx) %If any tests met both constraints
                [~,k_best]=min(search_metric_temp(cMeet_Idx)); %Index of best search metric out of those meeting constraints
                Idx_best=cMeet_Idx(k_best); %Index of best search metric for all possible
            else %If no tests meet both constraints
                if VIF_stop_flag==1
                    VIF_cMeet_Idx=find(VIF_met_temp); %Index of test that met VIF constraint
                    if ~isempty(VIF_cMeet_Idx) %If any tests met both constraints
                        [~,k_best]=min(search_metric_temp(VIF_cMeet_Idx)); %Index of best search metric out of those meeting constraints
                        Idx_best=VIF_cMeet_Idx(k_best); %Index of best search metric for all possible
                    else %No term combos satisfy VIF constraint
                        break; %Exit loop that is testing adding terms to model 
                    end
                else
                    [~,Idx_best]=min(search_metric_temp); %Just find minimum of search metric
                end
            end
            
            %Pick best term to add to move forward
            customMatrix_opt(pos_add_idx(Idx_best),i)=1; %Add term to customMatrix
            %Store results
            customMatrix_hist(:,j)=customMatrix_opt(:,i); %Store custom matrix
            VIF_met(j,i)=VIF_met_temp(Idx_best);
            VIF_max(j,i)=VIF_max_temp(Idx_best);
            sig_all(j,i)=sig_all_temp(Idx_best);
            P_max(j,i)=P_max_temp(Idx_best);
            search_metric(j,i)=search_metric_temp(Idx_best);
            
        end
        %Now select math model that minimizes search metric and meets both
        %constraints:
       
        cMeet_Idx=find(all([VIF_met(:,i),sig_all(:,i)],2)); %Index of tests that met both VIF and significance constraint tests
        if ~isempty(cMeet_Idx) %If any tests met both constraints
            [~,k_best]=min(search_metric(cMeet_Idx,i)); %Index of best search metric out of those meeting constraints
            Idx_best=cMeet_Idx(k_best); %Index of best search metric for all possible
            %Pick best term to add to move forward
            customMatrix_opt(:,i)=customMatrix_hist(:,Idx_best); %Add term to customMatrix
            
            if high_con==1 %If enforcing hierarchy constraint after, add in terms needed to support model
                sup_terms_mat=high(boolean(customMatrix_opt(1:nterms,i)),:); %Rows from hierarchy matrix for included terms. columns with '1' are needed to support variable
                sup_terms=any(sup_terms_mat,1); %Row vector with 1s for terms needed to support included terms
                customMatrix_opt(boolean(sup_terms),i)=1; %Include all terms needed to support currently included terms
            end
        else %No math models met both constraints: Return error message and do not optimize channel
            fprintf('\nERROR: Unable to find math model that meets constraints for channel '); fprintf(num2str(i)); fprintf('.\n');
            optChannel(i)=0;
        end
        
    end
end
%Output final model:
customMatrix_rec=customMatrix_permit; %Initialize recommended custom matrix as provided custom matrix
customMatrix_rec(:,boolean(optChannel))=customMatrix_opt(:,boolean(optChannel)); %Set optimized channels to optimal Results

fprintf('\nRecommended Equation Search Complete. \n ')
end

