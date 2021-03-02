function [leftColumn, topRow]=customMatrix_labels(loadlist,voltagelist,voltdimFlag,loaddimFlag,model,combined_terms,numRBF)
%Function generates text labels for terms used in model.  Labels are used
%in annotating ANOVA outputs for properties on each coefficient

%INPUTS:
%  loadlist = Labels for each load channel
%  voltagelist = Labels for each voltage channel
%  dimFlag = Number of data channels
%  model = Model type selected (Full, Truncated, Linear, Custom)
%  combined_terms = Character array for which term type is algebraicly combined (voltage or loads)
%  numRBF = Number of RBFs placed (if any)

%OUTPUTS:
%  leftColumn = Labels for combined terms
%  topRow = Labels for target terms

%Determine what terms should be combined: voltages or loads;
if strcmp(combined_terms,{'voltages'})==1
    toplist=loadlist;
    leftlist=voltagelist;
    %Variable labels are loads
    topRow=toplist(1:loaddimFlag)';
else
    toplist=voltagelist;
    leftlist=loadlist;
    %Variable labels are loads
    topRow=toplist(1:voltdimFlag)';
end

% Term order for full equation set:
% (INTERCEPT) (1)
%  F, |F|, F*F, F*|F|, F*G, |F*G|, F*|G|, |F|*G, F*F*F, |F*F*F|, F*G*G, F*G*H, (2-13)
% |F*G*G|, F*G*|G|, |F*G*H|  (14-16)

%Initialize counter and empty variables
count5=1;
count33=1; % counts all cubic terms w/ 3 uniques
block1=cellstr('INTERCEPT');
block2=cell(voltdimFlag,1);
block3=cell(voltdimFlag,1);
block4=cell(voltdimFlag,1);
block5=cell(voltdimFlag,1);
if voltdimFlag>=2
    block6=cell(((voltdimFlag-1)*voltdimFlag)/2,1);
    block7=cell(((voltdimFlag-1)*voltdimFlag)/2,1);
    block8=cell(((voltdimFlag-1)*voltdimFlag)/2,1);
    block9=cell(((voltdimFlag-1)*voltdimFlag)/2,1);
else
    block6=[];
    block7=[];
    block8=[];
    block9=[];
end
block10=cell(voltdimFlag,1);
block11=cell(voltdimFlag,1);
if voltdimFlag>=3
    block13=cell(factorial(voltdimFlag)/(factorial(3)*factorial(voltdimFlag-3)),1);
    block16=cell(factorial(voltdimFlag)/(factorial(3)*factorial(voltdimFlag-3)),1);
else
    block13=[];
    block16=[];
end
%write text for variable names and combinations for terms 1:11, 13
for i=1:voltdimFlag
    block2(i)=leftlist(i);
    block3(i)=strcat('|',leftlist(i),'|');
    block4(i)=strcat(leftlist(i),'*',leftlist(i));
    block5(i)=strcat(leftlist(i),'*|',leftlist(i),'|');
    
    if voltdimFlag>=2
    for j=i+1:voltdimFlag
        block6(count5)=strcat(leftlist(i),'*',leftlist(j));
        block7(count5)=strcat('|',leftlist(i),'*',leftlist(j),'|');
        block8(count5)=strcat(leftlist(i),'*|',leftlist(j),'|');
        block9(count5)=strcat('|',leftlist(i),'|*',leftlist(j));
        count5=count5+1;
        if voltdimFlag>=3
        for k=j+1:voltdimFlag
            block13(count33)=strcat(leftlist(i),'*',leftlist(j),'*',leftlist(k));
            block16(count33)=strcat('|',leftlist(i),'*',leftlist(j),'*',leftlist(k),'|');
            count33=count33+1;
        end
        end
    end
    end
    block10(i)=strcat(leftlist(i),'*',leftlist(i),'*',leftlist(i));
    block11(i)=strcat('|',leftlist(i),'*',leftlist(i),'*',leftlist(i),'|');
end

% write text for variable names and combinations for 3rd deg, 2 unique terms
if voltdimFlag>=2
    block12=cell(factorial(voltdimFlag)/factorial(voltdimFlag-2),1); % F*G*G
    block14=cell(factorial(voltdimFlag)/factorial(voltdimFlag-2),1); % |F*G*G|  
    block15=cell(factorial(voltdimFlag)/factorial(voltdimFlag-2),1); % F*G*|G|
    count32=1; % count cubic terms, 2 uniques
    for i=1:voltdimFlag
        j_ind=setdiff([1:voltdimFlag],i); %Indices for inner loop
        for j=1:length(j_ind)
            block12(count32)=strcat(leftlist(i),'*',leftlist(j_ind(j)),'*',leftlist(j_ind(j)));
            block14(count32)=strcat('|',leftlist(i),'*',leftlist(j_ind(j)),'*',leftlist(j_ind(j)),'|');
            block15(count32)=strcat(leftlist(i),'*',leftlist(j_ind(j)),'*','|',leftlist(j_ind(j)),'|');
            count32=count32+1;
        end
    end
else
    block12=[];
    block14=[];
    block15=[];
end

%Select Terms based on model type selected
if model==3 % linear
    leftColumn =[block1;block2];
elseif model==2 % truncated
    leftColumn=[block1;block2;block4;block6];
else % assemble everything
    leftColumn=[block1;block2;block3;block4;block5;block6;block7;block8;block9;block10;block11;block12;block13;block14;block15;block16];
end

if nargin>=7
    if numRBF>0
        channel=repmat([1:loaddimFlag]',numRBF,1);
        rbf_leftColumn=cellstr(strcat(reshape(toplist(channel),numel(channel),1), repmat(' RBF ',numRBF*loaddimFlag,1), num2str(repelem([1:numRBF]',loaddimFlag,1))));
        leftColumn=[leftColumn;rbf_leftColumn];
    end
end
end
