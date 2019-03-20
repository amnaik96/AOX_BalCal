% Copyright ©2017 Andrew Meade.  All Rights Reserved.
function [comINvec,comLZvec]=balCal_algEqns_indirect2(themodel_FLAG,numeqns,ndim,numdatapts,numseries,thelasttare,inputmatrix,lzmatrix)

if themodel_FLAG == 1
    % start of full set
    % make the 160 combinations
    
    looper = 1;
    for m=1:ndim
        comINvec(looper,:) = inputmatrix(:,m);
        comLZvec(looper,:) = lzmatrix(:,m);
        looper = looper+1;
    end
    
    
    for m=1:ndim
        comINvec(looper,:) = abs(inputmatrix(:,m));
        comLZvec(looper,:) = abs(lzmatrix(:,m));
        looper = looper+1;
    end
    
    
    for m=1:ndim
        comINvec(looper,:) = inputmatrix(:,m).^2;
        comLZvec(looper,:) = lzmatrix(:,m).^2;
        looper = looper+1;
    end
    
    
    for m=1:ndim
        comINvec(looper,:) = inputmatrix(:,m).*abs(inputmatrix(:,m));
        comLZvec(looper,:) = lzmatrix(:,m).*abs(lzmatrix(:,m));
        looper = looper+1;
    end
    
    
    for k=1:ndim-1
        for m=k+1:ndim
            comINvec(looper,:) = inputmatrix(:,k).*inputmatrix(:,m);
            comLZvec(looper,:) = lzmatrix(:,k).*lzmatrix(:,m);
            looper = looper+1;
        end
    end
    
    
    for k=1:ndim-1
        for m=k+1:ndim
            comINvec(looper,:) = abs((inputmatrix(:,k)).*(inputmatrix(:,m)));
            comLZvec(looper,:) = abs((lzmatrix(:,k)).*(lzmatrix(:,m)));
            looper = looper+1;
        end
    end
    
    
    for k=1:ndim-1
        for m=k+1:ndim
            comINvec(looper,:) = inputmatrix(:,k).*abs(inputmatrix(:,m));
            comLZvec(looper,:) = lzmatrix(:,k).*abs(lzmatrix(:,m));
            looper = looper+1;
        end
    end
    
    
    for k=1:ndim-1
        for m=k+1:ndim
            comINvec(looper,:) = abs(inputmatrix(:,k)).*(inputmatrix(:,m));
            comLZvec(looper,:) = abs(lzmatrix(:,k)).*(lzmatrix(:,m));
            looper = looper+1;
        end
    end
    
    
    for m=1:ndim
        comINvec(looper,:) = inputmatrix(:,m).^3;
        comLZvec(looper,:) = lzmatrix(:,m).^3;
        looper = looper+1;
    end
    
    
    for m=1:ndim
        comINvec(looper,:) = abs(inputmatrix(:,m).^3);
        comLZvec(looper,:) = abs(lzmatrix(:,m).^3);
        looper = looper+1;
    end
    
    numeqns = looper-1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if themodel_FLAG == 2
    
    looper = 1;
    for m=1:ndim
        comINvec(looper,:) = inputmatrix(:,m);
        comLZvec(looper,:) = lzmatrix(:,m);
        looper = looper+1;
    end
    
    
    for m=1:ndim
        comINvec(looper,:) = inputmatrix(:,m).^2;
        comLZvec(looper,:) = lzmatrix(:,m).^2;
        looper = looper+1;
    end
    
    
    for k=1:ndim-1
        for m=k+1:ndim
            comINvec(looper,:) = inputmatrix(:,k).*inputmatrix(:,m);
            comLZvec(looper,:) = lzmatrix(:,k).*lzmatrix(:,m);
            looper = looper+1;
        end
    end
    
    numeqns = looper-1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if themodel_FLAG == 3
    
    looper = 1;
    for m=1:ndim
        comINvec(looper,:) = inputmatrix(:,m);
        comLZvec(looper,:) = lzmatrix(:,m);
        looper = looper+1;
    end
    
    numeqns = looper-1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for loopk=1:numdatapts
    comINvec(numeqns+1,loopk) = 0.0;
    comLZvec(numeqns+1,loopk) = 1.0;
end

end