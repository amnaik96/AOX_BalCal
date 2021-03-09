function [infiles, bgmode, vmode, amode, outloc, alg_opt, grbf_opt] = batchprocess(infile)
    % BATCHPROCESS: BATCH INPUT FILE PROCESSING. 
    % Run at runbutton callback if batch mode enabled to send file names and desired input parameters.
    % Outputs:
    %   infiles: paths for each file to be analyzed, string vector
    %   bgmode: mode of balcal (balcal or general approximation), vector
    %   vmode: handles.Validate, vector
    %   amode: handle.Approximate, vector
    %   outloc: location of outputs. Can be specified in input file; default behavior matches directory of inpath for each file
    %   algmod: algebraic model choice, vector
    %   grbfs??
    
    % Input file needs to be run as a MATLAB script (therefore, MUST be formatted as a MATLAB script)
    % Checks for the right extension. Will convert to .m file if it is not already .m (best practice: use .m or a text file in MATLAB syntax)
    [tdir,tfile,f_ext] = fileparts(infile);
    if strcmp(f_ext,".m") == 0
        in_run = fullfile(tdir, [tfile, '.m']);
        copyfile(infile, in_run);
    else
        in_run = infile;
    end

    run(in_run); % Runs the .m input file to bring variables into workspace

    %% Process Input Info
    % preallocations
    vmode = zeros(nfile,1);
    amode = zeros(nfile,1);
    bmode = zeros(nfile,1);
    gmode = zeros(nfile,1);
    outloc = strings(nfile,1);
    alg_opt = struct();
    grbf_opt = struct();

    % Process input file variables
    infiles = [calfile, valfile, apprxfile];
    if exist('output_location','var')
        outloc(:) = char(output_location);
        def_out = 1;
    else
        def_out = 0;
    end

    for i = 1:nfile
        [caldir,~,~] = fileparts(infiles(i,1));
        if def_out == 0
            outloc(i) = char(caldir);
        end
        % bcmode directly controls balcal or gen approx mode
        switch pmode(i)
        case 1
            bmode(i) = 1;
            gmode(i) = 0;
        case 2
            bmode(i) = 0;
            gmode(i) = 1;
        end
        bgmode = [bmode, gmode];
        % check fmode to assign val and approx handles
        switch fmode(i)
        case {2,5}
            vmode(i) = 1;
            amode(i) = 0;
        case {3,6}
            vmode(i) = 0;
            amode(i) = 1;
        end
        % algebraic model options
        alg_opt(i).modelTag = char(modelTag(i));
        alg_opt(i).balance_type = balance_type(i);
        alg_opt(i).customTerms = char(customTerms(i));
        alg_opt(i).customFile = customFile(i);
        % grbf model options
        grbf_opt(i).grbf = grbf(i);
        grbf_opt(i).basis = basis(i);
        grbf_opt(i).selfTerm = selfTerm(i); % takes the string corresponding to the value in GUI already.
        grbf_opt(i).min_eps = min_eps(i);
        grbf_opt(i).max_eps = max_eps(i);
        grbf_opt(i).thresh = rbf_vif_thresh(i);
    end









end