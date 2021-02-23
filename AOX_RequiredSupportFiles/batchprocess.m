function [calfile, valfile, apprxfile, bgmode, vmode, amode, outloc] = batchprocess(infile)
    % BATCHPROCESS: BATCH INPUT FILE PROCESSING. 
    % Run at runbutton callback if batch mode enabled to send file names and desired input parameters.
    % Outputs:
    %   inpaths: paths for each file to be analyzed, string vector
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
    inpaths = [calfile, valfile, apprxfile];
    vmode = zeros(nfile,1);
    amode = zeros(nfile,1);
    bmode = zeros(nfile,1);
    gmode = zeros(nfile,1);
    outloc = strings(nfile,1);

    if exist('output_location','var')
        outloc(:) = char(output_location);
        def_out = 1;
    else
        def_out = 0;
    end

    for i = 1:nfile
        [caldir,~,~] = fileparts(calfile(i));
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
    end









end