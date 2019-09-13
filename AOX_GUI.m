% Version 11: Last modified on 6/11/18
function varargout = AOX_GUI(varargin)
% AOX_GUI MATLAB code for AOX_GUI.fig
%      AOX_GUI, by itself, creates a new AOX_GUI or raises the existing
%      singleton*.
%
%      H = AOX_GUI returns the handle to a new AOX_GUI or the handle to
%      the existing singleton*.
%
%      AOX_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AOX_GUI.M with the given input arguments.
%
%      AOX_GUI('Property','Value',...) creates a new AOX_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AOX_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AOX_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AOX_GUI

% Last Modified by GUIDE v2.5 31-Jul-2019 16:35:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @AOX_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @AOX_GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before AOX_GUI is made visible.
function AOX_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AOX_GUI (see VARARGIN)
set(handles.figure1, 'units', 'normalized', 'position', [0.15 0.1 0.5 0.8])
set(handles.output_location,'String',pwd);
global VERSION
VERSION = 16;
try
    
    [nasalogo,~,aln] = imread('nasa.png','BackgroundColor',[0.941, 0.941, 0.941]);
    axes(handles.axesNASA);
    imshow(nasalogo, []);
    
    [ricelogo,~,alr] = imread('rice.png','BackgroundColor',[0.941, 0.941, 0.941]);
    axes(handles.axesRice);
    imshow(ricelogo, []);
    
end

% Choose default command line output for AOX_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes AOX_GUI wait for user response (see UIRESUME)
[CurrentPath,~,~] = fileparts(mfilename('fullpath'));
fileName = [CurrentPath,filesep,'default.ini'];

actionpanel_SelectionChangeFcn(handles.calibrate, eventdata, handles)

if exist(fileName,'file')
    try
        load(fileName,'-mat');
        
        versionCheck(default);
        
        %set(handles.tares_FLAGcheck,'Value',default.tares);
        set(handles.disp_FLAGcheck,'Value',default.disp);
        %set(handles.grbftares_FLAGcheck,'Value',default.grbftares);
        set(handles.print_FLAGcheck,'Value',default.print);
        set(handles.res_FLAGcheck,'Value',default.res);
        set(handles.hist_FLAGcheck,'Value',default.hist);
        set(handles.outlier_FLAGcheck,'Value',default.outlier);
        outlier_FLAGcheck_Callback(handles.outlier_FLAGcheck, eventdata, handles);
        set(handles.numSTD,'String',default.numSTD);
        set(handles.zeroed_FLAGcheck,'Value',default.zeroed);
        set(handles.corr_FLAGcheck,'Value',default.corr);
        set(handles.rescorr_FLAGcheck,'Value',default.rescorr);
        set(handles.excel_FLAGcheck,'Value',default.excel);
        
        set(handles.calibrate,'Value',default.calibrate);
        set(handles.calPath,'String',default.calPath);
        set(handles.c11,'String',default.calRange{1,1});
        set(handles.c12,'String',default.calRange{1,2});
        set(handles.c21,'String',default.calRange{2,1});
        set(handles.c22,'String',default.calRange{2,2});
        set(handles.c31,'String',default.calRange{3,1});
        set(handles.c32,'String',default.calRange{3,2});
        set(handles.c41,'String',default.calRange{4,1});
        set(handles.c42,'String',default.calRange{4,2});
        set(handles.c51,'String',default.calRange{5,1});
        set(handles.c52,'String',default.calRange{5,2});
        calPath_Callback(handles.calPath, eventdata, handles)
        
        set(handles.validate,'Value',default.validate);
        set(handles.valPath,'String',default.valPath);
        set(handles.v11,'String',default.valRange{1,1});
        set(handles.v12,'String',default.valRange{1,2});
        set(handles.v21,'String',default.valRange{2,1});
        set(handles.v22,'String',default.valRange{2,2});
        set(handles.v31,'String',default.valRange{3,1});
        set(handles.v32,'String',default.valRange{3,2});
        set(handles.v41,'String',default.valRange{4,1});
        set(handles.v42,'String',default.valRange{4,2});
        set(handles.v51,'String',default.valRange{5,1});
        set(handles.v52,'String',default.valRange{5,2});
        valPath_Callback(handles.valPath, eventdata, handles)
        
        set(handles.approximate,'Value',default.approximate);
        set(handles.appPath,'String',default.appPath);
        set(handles.a11,'String',default.appRange{1,1});
        set(handles.a12,'String',default.appRange{1,2});
        set(handles.a21,'String',default.appRange{2,1});
        set(handles.a22,'String',default.appRange{2,2});
        set(handles.a31,'String',default.appRange{3,1});
        set(handles.a32,'String',default.appRange{3,2});
        set(handles.a41,'String',default.appRange{4,1});
        set(handles.a42,'String',default.appRange{4,2});
        appPath_Callback(handles.appPath, eventdata, handles)
        
        switch default.action
            case 'calibrate', actionpanel_SelectionChangeFcn(handles.calibrate, eventdata, handles)
            case 'validate', actionpanel_SelectionChangeFcn(handles.validate, eventdata, handles)
            case 'approximate', actionpanel_SelectionChangeFcn(handles.approximate, eventdata, handles)
        end
        
        set(handles.full,'Value',default.full);
        set(handles.truncated,'Value',default.truncated);
        set(handles.linear,'Value',default.linear);
        set(handles.custom,'Value',default.custom);
        set(handles.customPath,'String',default.customPath);
        if default.custom
            modelPanel_SelectionChangeFcn(handles.custom, eventdata, handles)
        end

        set(handles.grbf,'Value',default.grbf);
        set(handles.numBasisIn,'String',default.basis);
        %set(handles.grbfcoeff_FLAGcheck,'Value',default.grbf_coeff);
        %set(handles.loglog_FLAGcheck,'Value',default.loglog);
        grbf_Callback(handles.grbf, eventdata, handles);
        
        set(handles.Volt_FLAGcheck,'Value',default.Volt_FLAGcheck);
        set(handles.voltTrust,'String',default.voltTrust);
        Volt_FLAGcheck_Callback(handles.Volt_FLAGcheck, eventdata, handles);
        set(handles.anova_FLAGcheck,'Value',default.anova);
        anova_FLAGcheck_Callback(handles.anova_FLAGcheck, eventdata, handles)
        
        set(handles.loadPI_FLAGcheck,'Value',default.loadPI);
        loadPI_FLAGcheck_Callback(handles.loadPI_FLAGcheck, eventdata, handles)
        set(handles.BALFIT_Matrix_FLAGcheck,'Value',default.BALFIT_Matrix);
        set(handles.BALFIT_ANOVA_FLAGcheck,'Value',default.BALFIT_ANOVA);
        set(handles.Rec_Model_FLAGcheck,'Value',default.Rec_Model);
        set(handles.anova_pct,'String',default.anova_pct);
        set(handles.approx_and_PI_print,'Value',default.approx_and_PI_print);
        set(handles.PI_print,'Value',default.PI_print);
        
        
        set(handles.output_to_calib_FLAG,'Value',default.output_to_calib_FLAG);
        set(handles.subfolder_FLAG,'Value',default.subfolder_FLAG);
        output_to_calib_FLAG_Callback(handles.output_to_calib_FLAG, eventdata, handles)
        set(handles.output_location,'String',default.output_location);
        set(handles.calib_model_save_FLAG,'Value',default.calib_model_save_FLAG);
    catch
        disp('local default.ini may be outdated or incompatible with GUI.');
    end
end

uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AOX_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.figure1);


% --- Executes on button press in tares_FLAGcheck.
function tares_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to tares_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tares_FLAGcheck


% --- Executes on button press in hist_FLAGcheck.
function hist_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to hist_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hist_FLAGcheck


% --- Executes on button press in loglog_FLAGcheck.
function loglog_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to loglog_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loglog_FLAGcheck



function numBasisIn_Callback(hObject, eventdata, handles)
% hObject    handle to numBasisIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numBasisIn as text
%        str2double(get(hObject,'String')) returns contents of numBasisIn as a double


% --- Executes during object creation, after setting all properties.
function numBasisIn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numBasisIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runbutton.
function runbutton_Callback(hObject, eventdata, handles)
% hObject    handle to runbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);
%outStruct.tares = get(handles.tares_FLAGcheck,'Value');
outStruct.disp = get(handles.disp_FLAGcheck,'Value');
%outStruct.grbftares = get(handles.grbftares_FLAGcheck,'Value');
outStruct.print = get(handles.print_FLAGcheck,'Value');
outStruct.res = get(handles.res_FLAGcheck,'Value');
outStruct.hist = get(handles.hist_FLAGcheck,'Value');
outStruct.outlier = get(handles.outlier_FLAGcheck,'Value');
outStruct.numSTD = str2num(get(handles.numSTD,'String'));
%outStruct.loglog = get(handles.loglog_FLAGcheck,'Value');
outStruct.zeroed = get(handles.zeroed_FLAGcheck,'Value');
outStruct.corr = get(handles.corr_FLAGcheck,'Value');
outStruct.rescorr = get(handles.rescorr_FLAGcheck,'Value');
outStruct.excel = get(handles.excel_FLAGcheck,'Value');

switch get(get(handles.modelPanel,'SelectedObject'),'Tag')
    case 'full', outStruct.model = 1;
    case 'truncated', outStruct.model = 2;
    case 'linear', outStruct.model = 3;
    case 'custom'
        outStruct.model = 4;
        customPath = get(handles.customPath,'String');
        outStruct.customMatrix = csvread(customPath,1,1);
end

outStruct.grbf = 1 + get(handles.grbf,'Value');
outStruct.basis = str2num(get(handles.numBasisIn,'String'));

outStruct.voltFlag = get(handles.Volt_FLAGcheck,'Value');
outStruct.voltTrust = str2num(get(handles.voltTrust,'String'));
outStruct.anova = get(handles.anova_FLAGcheck,'Value');
outStruct.loadPI = get(handles.loadPI_FLAGcheck,'Value');
outStruct.BALFIT_Matrix = get(handles.BALFIT_Matrix_FLAGcheck,'Value');
outStruct.BALFIT_ANOVA = get(handles.BALFIT_ANOVA_FLAGcheck,'Value');
outStruct.Rec_Model = get(handles.Rec_Model_FLAGcheck,'Value');
outStruct.anova_pct= str2num(get(handles.anova_pct,'String'));
outStruct.approx_and_PI_print = get(handles.approx_and_PI_print,'Value');
outStruct.PI_print = get(handles.PI_print,'Value');

outStruct.output_location=get(handles.output_location,'String');
outStruct.subfolder_FLAG=get(handles.subfolder_FLAG,'Value');
outStruct.calib_model_save_FLAG=get(handles.calib_model_save_FLAG,'Value');

cal.type = 'calibrate';
cal.Path = get(handles.calPath,'String');
[~,~,calext] = fileparts(cal.Path);
switch calext
    case '.csv'
        cal.Range{1} = [get(handles.c11,'String'),'..',get(handles.c12,'String')];
        cal.CSV(1,:) = a12rc(get(handles.c11,'String'));
        cal.Range{2} = [get(handles.c21,'String'),'..',get(handles.c22,'String')];
        cal.CSV(2,:) = a12rc(get(handles.c21,'String'));
        cal.Range{3} = [get(handles.c31,'String'),'..',get(handles.c32,'String')];
        cal.CSV(3,:) = a12rc(get(handles.c31,'String'));
        cal.Range{4} = [get(handles.c41,'String'),'..',get(handles.c42,'String')];
        cal.CSV(4,:) = a12rc(get(handles.c41,'String'));
        cal.Range{5} = [get(handles.c51,'String'),'..',get(handles.c52,'String')];
        cal.CSV(5,:) = a12rc(get(handles.c51,'String'));
        
        cal.loadend          = a12rc(get(handles.c12,'String'));
        cal.voltend          = a12rc(get(handles.c22,'String'));
        
        outStruct.savePathcal = loadCSV(cal);
    case '.cal'
        outStruct.savePathcal = cal.Path;
end

outStruct.valid = get(handles.validate,'Value');
if outStruct.valid == 1
    val.type = 'validate';
    val.Path = get(handles.valPath,'String');
    [~,~,valext] = fileparts(val.Path);
    switch valext
        case '.csv'
            val.Range{1} = [get(handles.v11,'String'),'..',get(handles.v12,'String')];
            val.CSV(1,:) = a12rc(get(handles.v11,'String'));
            val.Range{2} = [get(handles.v21,'String'),'..',get(handles.v22,'String')];
            val.CSV(2,:) = a12rc(get(handles.v21,'String'));
            val.Range{3} = [get(handles.v31,'String'),'..',get(handles.v32,'String')];
            val.CSV(3,:) = a12rc(get(handles.v31,'String'));
            val.Range{4} = [get(handles.v41,'String'),'..',get(handles.v42,'String')];
            val.CSV(4,:) = a12rc(get(handles.v41,'String'));
            val.Range{5} = [get(handles.v51,'String'),'..',get(handles.v52,'String')];
            val.CSV(5,:) = a12rc(get(handles.v51,'String'));
            outStruct.savePathval = loadCSV(val);
        case '.val'
            outStruct.savePathval = val.Path;
    end
end

outStruct.approx = get(handles.approximate,'Value');
if outStruct.approx == 1
    app.type = 'approximate';
    app.Path = get(handles.appPath,'String');
    [~,~,appext] = fileparts(app.Path);
    switch appext
        case '.csv'
            app.Range{1} = [get(handles.a11,'String'),'..',get(handles.a12,'String')];
            app.CSV(1,:) = a12rc(get(handles.a11,'String'));
            app.Range{2} = [get(handles.a21,'String'),'..',get(handles.a22,'String')];
            app.CSV(2,:) = a12rc(get(handles.a21,'String'));
            app.Range{3} = [get(handles.a31,'String'),'..',get(handles.a32,'String')];
            app.CSV(3,:) = a12rc(get(handles.a31,'String'));
            app.Range{4} = [get(handles.a41,'String'),'..',get(handles.a42,'String')];
            app.CSV(4,:) = a12rc(get(handles.a41,'String'));
            outStruct.savePathapp = loadCSV(app);
        case '.app'
            outStruct.savePathapp = app.Path;
    end
end

outStruct.cancel = 0;

handles.output = outStruct;
guidata(hObject, handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    outStruct.cancel = 1;
    handles.output = outStruct;
    guidata(hObject,handles);
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes when selected object is changed in modelPanel.
function modelPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in modelPanel
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.custom)
    set(handles.customPath, 'Enable', 'on');
    set(handles.customFind, 'Enable', 'on');
else
    set(handles.customPath, 'Enable', 'off');
    set(handles.customFind, 'Enable', 'off');
end

% --- Executes on button press in cancelbutton.
function cancelbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outStruct.cancel = 1;
handles.output = outStruct;
guidata(hObject,handles);
uiresume(handles.figure1);

function calPath_Callback(hObject, eventdata, handles)
% hObject    handle to calPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of calPath as text
%        str2double(get(hObject,'String')) returns contents of calPath as a double
[~,~,ext] = fileparts(get(hObject,'String'));
try
    if strcmp(ext,'.csv')
        %set(handles.calSave, 'Enable', 'on');
        set(handles.c11, 'Enable', 'on');
        set(handles.c12, 'Enable', 'on');
        set(handles.c21, 'Enable', 'on');
        set(handles.c22, 'Enable', 'on');
        set(handles.c31, 'Enable', 'on');
        set(handles.c32, 'Enable', 'on');
        set(handles.c41, 'Enable', 'on');
        set(handles.c42, 'Enable', 'on');
        set(handles.c51, 'Enable', 'on');
        set(handles.c52, 'Enable', 'on');
    else
        %set(handles.calSave, 'Enable', 'off');
        if strcmp(ext,'.cal')
            load(get(hObject,'String'), '-mat', 'cal');
            splitrange = split(cal.Range,'..');
        else
            splitrange=cell(1,5,2);
        end
        
        set(handles.c11, 'Enable', 'off', 'String', splitrange{1,1,1});
        set(handles.c12, 'Enable', 'off', 'String', splitrange{1,1,2});
        set(handles.c21, 'Enable', 'off', 'String', splitrange{1,2,1});
        set(handles.c22, 'Enable', 'off', 'String', splitrange{1,2,2});
        set(handles.c31, 'Enable', 'off', 'String', splitrange{1,3,1});
        set(handles.c32, 'Enable', 'off', 'String', splitrange{1,3,2});
        set(handles.c41, 'Enable', 'off', 'String', splitrange{1,4,1});
        set(handles.c42, 'Enable', 'off', 'String', splitrange{1,4,2});
        set(handles.c51, 'Enable', 'off', 'String', splitrange{1,5,1});
        set(handles.c52, 'Enable', 'off', 'String', splitrange{1,5,2});
    end
    output_to_calib_FLAG_Callback(handles.output_to_calib_FLAG, eventdata, handles)
catch
    disp('Problem occurred while reading Calibration file')
end


% --- Executes during object creation, after setting all properties.
function calPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calFind.
function calFind_Callback(hObject, eventdata, handles)
% hObject    handle to calFind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile('*.csv;*.cal');
if FileName ~= 0
    [CurrentPath,~,~] = fileparts(mfilename('fullpath'));
    CurrentPath = [CurrentPath,filesep];
    if strcmp(CurrentPath,PathName)
        FullPath = FileName;
    else
        FullPath = [PathName,FileName];
    end
    set(handles.calPath,'String',FullPath)
end
calPath_Callback(handles.calPath, eventdata, handles);


function valPath_Callback(hObject, eventdata, handles)
% hObject    handle to valPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valPath as text
%        str2double(get(hObject,'String')) returns contents of valPath as a double
[~,~,ext] = fileparts(get(hObject,'String'));
try
    if strcmp(ext,'.csv')
        %set(handles.valSave, 'Enable', 'on');
        set(handles.v11, 'Enable', 'on');
        set(handles.v12, 'Enable', 'on');
        set(handles.v21, 'Enable', 'on');
        set(handles.v22, 'Enable', 'on');
        set(handles.v31, 'Enable', 'on');
        set(handles.v32, 'Enable', 'on');
        set(handles.v41, 'Enable', 'on');
        set(handles.v42, 'Enable', 'on');
        set(handles.v51, 'Enable', 'on');
        set(handles.v52, 'Enable', 'on');
    else
        %set(handles.valSave, 'Enable', 'off');
        if strcmp(ext,'.val')
            load(get(hObject,'String'), '-mat', 'val');
            splitrange = split(val.Range,'..');
        else
            splitrange=cell(1,5,2);
        end
        
        set(handles.v11, 'Enable', 'off', 'String', splitrange{1,1,1});
        set(handles.v12, 'Enable', 'off', 'String', splitrange{1,1,2});
        set(handles.v21, 'Enable', 'off', 'String', splitrange{1,2,1});
        set(handles.v22, 'Enable', 'off', 'String', splitrange{1,2,2});
        set(handles.v31, 'Enable', 'off', 'String', splitrange{1,3,1});
        set(handles.v32, 'Enable', 'off', 'String', splitrange{1,3,2});
        set(handles.v41, 'Enable', 'off', 'String', splitrange{1,4,1});
        set(handles.v42, 'Enable', 'off', 'String', splitrange{1,4,2});
        set(handles.v51, 'Enable', 'off', 'String', splitrange{1,5,1});
        set(handles.v52, 'Enable', 'off', 'String', splitrange{1,5,2});
    end
catch
    disp('Problem occurred while reading Validation file');
end

% --- Executes during object creation, after setting all properties.
function valPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in valFind.
function valFind_Callback(hObject, eventdata, handles)
% hObject    handle to valFind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile('*.csv;*.val');
if FileName ~= 0
    [CurrentPath,~,~] = fileparts(mfilename('fullpath'));
    CurrentPath = [CurrentPath,'\'];
    if strcmp(CurrentPath,PathName)
        FullPath = FileName;
    else
        FullPath = [PathName,FileName];
    end
    set(handles.valPath,'String',FullPath)
end
valPath_Callback(handles.valPath, eventdata, handles)

% --- Executes on button press in grbf.
function grbf_Callback(hObject, eventdata, handles)
% hObject    handle to grbf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of grbf
if get(hObject,'Value') == 1
    set(handles.numBasisIn,'Enable','on');
    set(handles.RBF_text,'Enable','on');
    %set(handles.loglog_FLAGcheck,'Enable','on');
    %set(handles.grbfcoeff_FLAGcheck,'Enable','on');
    %set(handles.grbftares_FLAGcheck,'Enable','on');
else
    set(handles.numBasisIn,'Enable','off');
    set(handles.RBF_text,'Enable','off');
    %set(handles.loglog_FLAGcheck,'Enable','off');
    %set(handles.grbfcoeff_FLAGcheck,'Enable','off');
    %set(handles.grbftares_FLAGcheck,'Enable','off');
end



function c11_Callback(hObject, eventdata, handles)
% hObject    handle to c11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c11 as text
%        str2double(get(hObject,'String')) returns contents of c11 as a double


% --- Executes during object creation, after setting all properties.
function c11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c21_Callback(hObject, eventdata, handles)
% hObject    handle to c21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c21 as text
%        str2double(get(hObject,'String')) returns contents of c21 as a double


% --- Executes during object creation, after setting all properties.
function c21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c41_Callback(hObject, eventdata, handles)
% hObject    handle to c41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c41 as text
%        str2double(get(hObject,'String')) returns contents of c41 as a double


% --- Executes during object creation, after setting all properties.
function c41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c31_Callback(hObject, eventdata, handles)
% hObject    handle to c31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c31 as text
%        str2double(get(hObject,'String')) returns contents of c31 as a double


% --- Executes during object creation, after setting all properties.
function c31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c51_Callback(hObject, eventdata, handles)
% hObject    handle to c51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c51 as text
%        str2double(get(hObject,'String')) returns contents of c51 as a double


% --- Executes during object creation, after setting all properties.
function c51_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c12_Callback(hObject, eventdata, handles)
% hObject    handle to c12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c12 as text
%        str2double(get(hObject,'String')) returns contents of c12 as a double


% --- Executes during object creation, after setting all properties.
function c12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c22_Callback(hObject, eventdata, handles)
% hObject    handle to c22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c22 as text
%        str2double(get(hObject,'String')) returns contents of c22 as a double


% --- Executes during object creation, after setting all properties.
function c22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c42_Callback(hObject, eventdata, handles)
% hObject    handle to c42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c42 as text
%        str2double(get(hObject,'String')) returns contents of c42 as a double


% --- Executes during object creation, after setting all properties.
function c42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c32_Callback(hObject, eventdata, handles)
% hObject    handle to c32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c32 as text
%        str2double(get(hObject,'String')) returns contents of c32 as a double


% --- Executes during object creation, after setting all properties.
function c32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c52_Callback(hObject, eventdata, handles)
% hObject    handle to c52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c52 as text
%        str2double(get(hObject,'String')) returns contents of c52 as a double


% --- Executes during object creation, after setting all properties.
function c52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v11_Callback(hObject, eventdata, handles)
% hObject    handle to v11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v11 as text
%        str2double(get(hObject,'String')) returns contents of v11 as a double


% --- Executes during object creation, after setting all properties.
function v11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v21_Callback(hObject, eventdata, handles)
% hObject    handle to v21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v21 as text
%        str2double(get(hObject,'String')) returns contents of v21 as a double


% --- Executes during object creation, after setting all properties.
function v21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v41_Callback(hObject, eventdata, handles)
% hObject    handle to v41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v41 as text
%        str2double(get(hObject,'String')) returns contents of v41 as a double


% --- Executes during object creation, after setting all properties.
function v41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v31_Callback(hObject, eventdata, handles)
% hObject    handle to v31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v31 as text
%        str2double(get(hObject,'String')) returns contents of v31 as a double


% --- Executes during object creation, after setting all properties.
function v31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v51_Callback(hObject, eventdata, handles)
% hObject    handle to v51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v51 as text
%        str2double(get(hObject,'String')) returns contents of v51 as a double


% --- Executes during object creation, after setting all properties.
function v51_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v12_Callback(hObject, eventdata, handles)
% hObject    handle to v12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v12 as text
%        str2double(get(hObject,'String')) returns contents of v12 as a double


% --- Executes during object creation, after setting all properties.
function v12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v22_Callback(hObject, eventdata, handles)
% hObject    handle to v22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v22 as text
%        str2double(get(hObject,'String')) returns contents of v22 as a double


% --- Executes during object creation, after setting all properties.
function v22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v42_Callback(hObject, eventdata, handles)
% hObject    handle to v42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v42 as text
%        str2double(get(hObject,'String')) returns contents of v42 as a double


% --- Executes during object creation, after setting all properties.
function v42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v32_Callback(hObject, eventdata, handles)
% hObject    handle to v32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v32 as text
%        str2double(get(hObject,'String')) returns contents of v32 as a double


% --- Executes during object creation, after setting all properties.
function v32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v52_Callback(hObject, eventdata, handles)
% hObject    handle to v52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v52 as text
%        str2double(get(hObject,'String')) returns contents of v52 as a double


% --- Executes during object creation, after setting all properties.
function v52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in actionpanel.
function actionpanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in actionpanel
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
calPath_Callback(handles.calPath,eventdata,handles);
set(handles.calPath, 'Enable', 'on');
set(handles.calFind, 'Enable', 'on');
if (hObject == handles.calibrate)
    set(handles.valPath, 'Enable', 'off');
    set(handles.valFind, 'Enable', 'off');
    %set(handles.valSave, 'Enable', 'off');
    set(handles.v11, 'Enable', 'off');
    set(handles.v12, 'Enable', 'off');
    set(handles.v21, 'Enable', 'off');
    set(handles.v22, 'Enable', 'off');
    set(handles.v31, 'Enable', 'off');
    set(handles.v32, 'Enable', 'off');
    set(handles.v41, 'Enable', 'off');
    set(handles.v42, 'Enable', 'off');
    set(handles.v51, 'Enable', 'off');
    set(handles.v52, 'Enable', 'off');
    
    set(handles.appPath, 'Enable', 'off');
    set(handles.appFind, 'Enable', 'off');
    %set(handles.appSave, 'Enable', 'off');
    set(handles.a11, 'Enable', 'off');
    set(handles.a12, 'Enable', 'off');
    set(handles.a21, 'Enable', 'off');
    set(handles.a22, 'Enable', 'off');
    set(handles.a31, 'Enable', 'off');
    set(handles.a32, 'Enable', 'off');
    set(handles.a41, 'Enable', 'off');
    set(handles.a42, 'Enable', 'off');
    %set(handles.zeroed_FLAGcheck,'Enable','off');
elseif hObject == handles.validate
    set(handles.valPath, 'Enable', 'on');
    set(handles.valFind, 'Enable', 'on');
    %set(handles.valSave, 'Enable', 'on');
    set(handles.v11, 'Enable', 'on');
    set(handles.v12, 'Enable', 'on');
    set(handles.v21, 'Enable', 'on');
    set(handles.v22, 'Enable', 'on');
    set(handles.v31, 'Enable', 'on');
    set(handles.v32, 'Enable', 'on');
    set(handles.v41, 'Enable', 'on');
    set(handles.v42, 'Enable', 'on');
    set(handles.v51, 'Enable', 'on');
    set(handles.v52, 'Enable', 'on');
    valPath_Callback(handles.valPath,eventdata,handles);
    
    set(handles.appPath, 'Enable', 'off');
    set(handles.appFind, 'Enable', 'off');
    %set(handles.appSave, 'Enable', 'off');
    set(handles.a11, 'Enable', 'off');
    set(handles.a12, 'Enable', 'off');
    set(handles.a21, 'Enable', 'off');
    set(handles.a22, 'Enable', 'off');
    set(handles.a31, 'Enable', 'off');
    set(handles.a32, 'Enable', 'off');
    set(handles.a41, 'Enable', 'off');
    set(handles.a42, 'Enable', 'off');
    %set(handles.zeroed_FLAGcheck,'Enable','off');
elseif hObject == handles.approximate
    set(handles.valPath, 'Enable', 'off');
    set(handles.valFind, 'Enable', 'off');
    %set(handles.valSave, 'Enable', 'off');
    set(handles.v11, 'Enable', 'off');
    set(handles.v12, 'Enable', 'off');
    set(handles.v21, 'Enable', 'off');
    set(handles.v22, 'Enable', 'off');
    set(handles.v31, 'Enable', 'off');
    set(handles.v32, 'Enable', 'off');
    set(handles.v41, 'Enable', 'off');
    set(handles.v42, 'Enable', 'off');
    set(handles.v51, 'Enable', 'off');
    set(handles.v52, 'Enable', 'off');
    
    set(handles.appPath, 'Enable', 'on');
    set(handles.appFind, 'Enable', 'on');
    %set(handles.appSave, 'Enable', 'on');
    set(handles.a11, 'Enable', 'on');
    set(handles.a12, 'Enable', 'on');
    set(handles.a21, 'Enable', 'on');
    set(handles.a22, 'Enable', 'on');
    set(handles.a31, 'Enable', 'on');
    set(handles.a32, 'Enable', 'on');
    set(handles.a41, 'Enable', 'on');
    set(handles.a42, 'Enable', 'on');
    appPath_Callback(handles.appPath,eventdata,handles);
    %set(handles.zeroed_FLAGcheck,'Enable','on');
end


% --- Executes on button press in grbfcoeff_FLAGcheck.
function grbfcoeff_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to grbfcoeff_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of grbfcoeff_FLAGcheck


% --- Executes on button press in disp_FLAGcheck.
function disp_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to disp_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of disp_FLAGcheck


% --- Executes on button press in print_FLAGcheck.
function print_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to print_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of print_FLAGcheck



% --- Executes on button press in ini_button.
function ini_button_Callback(hObject, eventdata, handles)
% hObject    handle to ini_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VERSION
default.version = VERSION;

%default.tares = get(handles.tares_FLAGcheck,'Value');
default.disp = get(handles.disp_FLAGcheck,'Value');
%default.grbftares = get(handles.grbftares_FLAGcheck,'Value');
default.print = get(handles.print_FLAGcheck,'Value');
default.res = get(handles.res_FLAGcheck,'Value');
default.hist = get(handles.hist_FLAGcheck,'Value');
default.outlier = get(handles.outlier_FLAGcheck,'Value');
default.numSTD = get(handles.numSTD,'String');
default.zeroed = get(handles.zeroed_FLAGcheck,'Value');
default.corr = get(handles.corr_FLAGcheck,'Value');
default.rescorr = get(handles.rescorr_FLAGcheck,'Value');
default.excel = get(handles.excel_FLAGcheck,'Value');

default.action = get(get(handles.actionpanel,'SelectedObject'),'tag');
default.calibrate = get(handles.calibrate,'Value');
default.calPath = get(handles.calPath,'String');
default.calRange{1,1} = get(handles.c11,'String');
default.calRange{1,2} = get(handles.c12,'String');
default.calRange{2,1} = get(handles.c21,'String');
default.calRange{2,2} = get(handles.c22,'String');
default.calRange{3,1} = get(handles.c31,'String');
default.calRange{3,2} = get(handles.c32,'String');
default.calRange{4,1} = get(handles.c41,'String');
default.calRange{4,2} = get(handles.c42,'String');
default.calRange{5,1} = get(handles.c51,'String');
default.calRange{5,2} = get(handles.c52,'String');

default.validate = get(handles.validate,'Value');
default.valPath = get(handles.valPath,'String');
default.valRange{1,1} = get(handles.v11,'String');
default.valRange{1,2} = get(handles.v12,'String');
default.valRange{2,1} = get(handles.v21,'String');
default.valRange{2,2} = get(handles.v22,'String');
default.valRange{3,1} = get(handles.v31,'String');
default.valRange{3,2} = get(handles.v32,'String');
default.valRange{4,1} = get(handles.v41,'String');
default.valRange{4,2} = get(handles.v42,'String');
default.valRange{5,1} = get(handles.v51,'String');
default.valRange{5,2} = get(handles.v52,'String');

default.approximate = get(handles.approximate,'Value');
default.appPath = get(handles.appPath,'String');
default.appRange{1,1} = get(handles.a11,'String');
default.appRange{1,2} = get(handles.a12,'String');
default.appRange{2,1} = get(handles.a21,'String');
default.appRange{2,2} = get(handles.a22,'String');
default.appRange{3,1} = get(handles.a31,'String');
default.appRange{3,2} = get(handles.a32,'String');
default.appRange{4,1} = get(handles.a41,'String');
default.appRange{4,2} = get(handles.a42,'String');

default.full = get(handles.full,'Value');
default.truncated = get(handles.truncated,'Value');
default.linear = get(handles.linear,'Value');
default.custom = get(handles.custom,'Value');
default.customPath = get(handles.customPath,'String');

default.grbf = get(handles.grbf,'Value');
default.basis = get(handles.numBasisIn,'String');
%default.grbf_coeff = get(handles.grbfcoeff_FLAGcheck,'Value');
%default.loglog = get(handles.loglog_FLAGcheck,'Value');

default.Volt_FLAGcheck=get(handles.Volt_FLAGcheck,'Value');
default.voltTrust=get(handles.voltTrust,'String');
default.anova = get(handles.anova_FLAGcheck,'Value');
default.loadPI = get(handles.loadPI_FLAGcheck,'Value');
default.BALFIT_Matrix = get(handles.BALFIT_Matrix_FLAGcheck,'Value');
default.BALFIT_ANOVA = get(handles.BALFIT_ANOVA_FLAGcheck,'Value');
default.Rec_Model = get(handles.Rec_Model_FLAGcheck,'Value');
default.anova_pct = get(handles.anova_pct,'String');
default.approx_and_PI_print = get(handles.approx_and_PI_print,'Value');
default.PI_print = get(handles.PI_print,'Value');

default.output_location=get(handles.output_location,'String');
default.output_to_calib_FLAG=get(handles.output_to_calib_FLAG,'Value');
default.subfolder_FLAG=get(handles.subfolder_FLAG,'Value');
default.calib_model_save_FLAG=get(handles.calib_model_save_FLAG,'Value');

[CurrentPath,~,~] = fileparts(mfilename('fullpath'));
fileName = [CurrentPath,filesep,'default.ini'];
save(fileName,'default');
set(hObject,'String','Saving...');
pause(1);
set(hObject,'String','Saved');
pause(0.5);
set(hObject,'String','Set as Default...')

function a = a12rc(a1)
%converts spreadsheet notation "A1" to row and column numbers  (0-based)
alpha_ind = find(isletter(a1));
alpha = abs(upper(a1(alpha_ind)))-65;
c = alpha;
a1(alpha_ind) = [];
r = str2num(a1)-1;
a = [r c];

function a1 = rc2a1(a)
r = a(1); c = a(2);
alpha = char(c+65);
num = int2str(r+1);
a1 = [alpha, num];

% --- Executes on button press in grbftares_FLAGcheck.
function grbftares_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to grbftares_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of grbftares_FLAGcheck


% --- Executes on button press in zeroed_FLAGcheck.
function zeroed_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to zeroed_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zeroed_FLAGcheck


% --- Executes on button press in outlier_FLAGcheck.
function outlier_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to outlier_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of outlier_FLAGcheck
if get(hObject,'Value') == 1
    set(handles.zeroed_FLAGcheck,'Enable','on');
    set(handles.numSTD,'Enable','on');
    set(handles.std_text,'Enable','on');

else
    set(handles.zeroed_FLAGcheck,'Enable','off');
    set(handles.numSTD,'Enable','off');
    set(handles.std_text,'Enable','off');
end


function a11_Callback(hObject, eventdata, handles)
% hObject    handle to a11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a11 as text
%        str2double(get(hObject,'String')) returns contents of a11 as a double


% --- Executes during object creation, after setting all properties.
function a11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a12_Callback(hObject, eventdata, handles)
% hObject    handle to a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a12 as text
%        str2double(get(hObject,'String')) returns contents of a12 as a double


% --- Executes during object creation, after setting all properties.
function a12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function appPath_Callback(hObject, eventdata, handles)
% hObject    handle to appPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of appPath as text
%        str2double(get(hObject,'String')) returns contents of appPath as a double
[~,~,ext] = fileparts(get(hObject,'String'));
try
    if strcmp(ext,'.csv')
        %set(handles.appSave, 'Enable', 'on');
        set(handles.a11, 'Enable', 'on');
        set(handles.a12, 'Enable', 'on');
        set(handles.a21, 'Enable', 'on');
        set(handles.a22, 'Enable', 'on');
        set(handles.a31, 'Enable', 'on');
        set(handles.a32, 'Enable', 'on');
        set(handles.a41, 'Enable', 'on');
        set(handles.a42, 'Enable', 'on');
    else
        %set(handles.appSave, 'Enable', 'off');
        if strcmp(ext,'.app')
            load(get(hObject,'String'), '-mat', 'app');
            splitrange = split(app.Range,'..');
        else
            splitrange=cell(1,4,2);
        end
        
        set(handles.a11, 'Enable', 'off', 'String', splitrange{1,1,1});
        set(handles.a12, 'Enable', 'off', 'String', splitrange{1,1,2});
        set(handles.a21, 'Enable', 'off', 'String', splitrange{1,2,1});
        set(handles.a22, 'Enable', 'off', 'String', splitrange{1,2,2});
        set(handles.a31, 'Enable', 'off', 'String', splitrange{1,3,1});
        set(handles.a32, 'Enable', 'off', 'String', splitrange{1,3,2});
        set(handles.a41, 'Enable', 'off', 'String', splitrange{1,4,1});
        set(handles.a42, 'Enable', 'off', 'String', splitrange{1,4,2});
    end
catch
    disp('Problem occurred while reading Approximation file');
end

% --- Executes during object creation, after setting all properties.
function appPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to appPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in appFind.
function appFind_Callback(hObject, eventdata, handles)
% hObject    handle to appFind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile('*.csv;*.app');
if FileName ~= 0
    [CurrentPath,~,~] = fileparts(mfilename('fullpath'));
    CurrentPath = [CurrentPath,'\'];
    if strcmp(CurrentPath,PathName)
        FullPath = FileName;
    else
        FullPath = [PathName,FileName];
    end
    set(handles.appPath,'String',FullPath)
end
appPath_Callback(handles.appPath, eventdata, handles)


% --- Executes on button press in appSave.
function appSave_Callback(hObject, eventdata, handles)
% hObject    handle to appSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in valSave.
function valSave_Callback(hObject, eventdata, handles)
% hObject    handle to valSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in calSave.
function calSave_Callback(hObject, eventdata, handles)
% hObject    handle to calSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function savePath = loadCSV(cva)
% This function pre-loads the csv's and saves the data as .mat for quicker
% reading.
% Input: type - String that changes depending on whether loading
% calibration, validation, or approximation data.
switch cva.type
    case 'calibrate'
        cal = cva;
        
        loadCapacities =     csvread(cal.Path,cal.CSV(1,1),cal.CSV(1,2),cal.Range{1});
        natzeros =           csvread(cal.Path,cal.CSV(2,1),cal.CSV(2,2),cal.Range{2});

        %Read series labels using 'readtable': JRP 19 June 19
        A=extractAfter(cal.Range{3},'..');
        bottom=str2double(regexp(A,'\d*','Match'));
        opts=delimitedTextImportOptions('DataLines',[cal.CSV(3,1)+1 bottom]);
        series_bulk=readtable(cal.Path,opts);
        series=str2double(table2array(series_bulk(:,cal.CSV(3,2)+1)));
        series2=table2array(series_bulk(:,cal.CSV(3,2)+2));
        pointID=table2array(series_bulk(:,cal.CSV(3,2)));
        clear A bottom opts series_bulk

        %         series =             csvread(cal.Path,cal.CSV(3,1),cal.CSV(3,2),cal.Range{3});
        
        targetMatrix0 =      csvread(cal.Path,cal.CSV(4,1),cal.CSV(4,2),cal.Range{4});
        excessVec0 =         csvread(cal.Path,cal.CSV(5,1),cal.CSV(5,2),cal.Range{5});
        
        try
            %             l_label1         = rc2a1([cal.CSV(1,1)-4, cal.CSV(1,2)]);
            %             l_label2         = rc2a1([cal.CSV(1,1)-4, cal.loadend(2)]);
            % %            [~,loadlabels,~] = xlsread(cal.Path,[l_label1,':',l_label2]);  %AJM 4_20_19
            %             [~,loadlabels,~] = csvread(cal.Path,[l_label1,':',l_label2]);
            
            %START: new approach, JRP 11 June 19
            file=fopen(cal.Path); %open file
            label_text1 = textscan(file,'%s','Delimiter','\n'); %read in all text
            splitlabelRow=cellstr(strsplit(string(label_text1{1}{cal.CSV(1,1)-3}),',','CollapseDelimiters',false)); %Extract row with labels
            fclose(file); %close file
            loadlabels=splitlabelRow(cal.CSV(1,2)+1:cal.loadend(2)+1); %extract load labels
            voltlabels=splitlabelRow(cal.CSV(2,2)+1:cal.voltend(2)+1); %extract voltage labels
            % read in load and voltage units, JRP 11 July 19
            splitunitRow=cellstr(strsplit(string(label_text1{1}{cal.CSV(1,1)-1}),',','CollapseDelimiters',false)); %extract row with units
            loadunits=splitunitRow(cal.CSV(1,2)+1:cal.loadend(2)+1); %extract load units 
            voltunits=splitunitRow(cal.CSV(2,2)+1:cal.voltend(2)+1); %extract voltage units
            
            try
                %START: find file description and balance name: JRP 25 July 19
                description_i=find(contains(label_text1{1},'DESCRIPTION'));
                assert(any(description_i)) %intentional error to get to cach block if 'BALANCE_NAME' is not found
                descriptionRow=cellstr(strsplit(string(label_text1{1}{description_i}),',','CollapseDelimiters',false)); %Extract row with data description
                description=descriptionRow(find(contains(descriptionRow,'DESCRIPTION'))+1);          
            catch
                description={'NO DESCRIPTION FOUND'};
            end
            clear description_i descriptionRow
            
            try
                balance_i=find(contains(label_text1{1},'BALANCE_NAME'));
                assert(any(balance_i)) %intentional error to get to cach block if 'BALANCE_NAME' is not found
                balanceRow=cellstr(strsplit(string(label_text1{1}{balance_i}),',','CollapseDelimiters',false)); %Extract row with balance name
                balance_type=balanceRow(find(contains(balanceRow,'BALANCE_NAME'))+1);
            catch
                balance_type={'NO BALANCE NAME FOUND'};
            end
            clear balance_i balanceRow
            %END:find file description and balance name: JRP 25 July 19
            clear file label_text1 splitlabelRow splitunitRow
            %END: new approach, JRP 11 June 19
           
            
            %             v_label1         = rc2a1([cal.CSV(1,1)-4, cal.CSV(2,2)]);
            %             v_label2         = rc2a1([cal.CSV(1,1)-4, cal.voltend(2)]);
            % %            [~,voltlabels,~] = xlsread(cal.Path,[v_label1,':',v_label2]);  %AJM 4_20_19
            %             [~,voltlabels,~] = csvread(cal.Path,[v_label1,':',v_label2]);
            %
            %             clear l_label1 l_label2 v_label1 v_label2
        end
        
        [~,calName,~] = fileparts(cal.Path);
        fileName = [calName,'.cal'];
        [CurrentPath,~,~] = fileparts(mfilename('fullpath'));
        savePath = [CurrentPath,filesep,fileName];
        
        clear cva calName CurrentPath
        save(savePath);
    case 'validate'
        val = cva;
        
        loadCapacitiesvalid =    csvread(val.Path,val.CSV(1,1),val.CSV(1,2),val.Range{1});
        natzerosvalid =          csvread(val.Path,val.CSV(2,1),val.CSV(2,2),val.Range{2});
        
        %Read series labels using 'readtable': JRP 19 June 19
        A=extractAfter(val.Range{3},'..');
        bottom=str2double(regexp(A,'\d*','Match'));
        opts=delimitedTextImportOptions('DataLines',[val.CSV(3,1)+1 bottom]);
        series_bulk=readtable(val.Path,opts);
        seriesvalid=str2double(table2array(series_bulk(:,val.CSV(3,2)+1)));
        series2valid=table2array(series_bulk(:,val.CSV(3,2)+2));
        pointIDvalid=table2array(series_bulk(:,val.CSV(3,2)));
        clear A bottom opts series_bulk
%         seriesvalid =            csvread(val.Path,val.CSV(3,1),val.CSV(3,2),val.Range{3});

        targetMatrixvalid =      csvread(val.Path,val.CSV(4,1),val.CSV(4,2),val.Range{4});
        excessVecvalid =         csvread(val.Path,val.CSV(5,1),val.CSV(5,2),val.Range{5});
        
        [~,valName,~] = fileparts(val.Path);
        fileNamevalid = [valName,'.val'];
        [CurrentPath,~,~] = fileparts(mfilename('fullpath'));
        savePathvalid = [CurrentPath,filesep,fileNamevalid];
        
        clear cva valName CurrentPath
        save(savePathvalid);
        savePath = savePathvalid;
    case 'approximate'
        app = cva;
        
        loadCapacitiesapprox =    csvread(app.Path,app.CSV(1,1),app.CSV(1,2),app.Range{1});
        natzerosapprox =          csvread(app.Path,app.CSV(2,1),app.CSV(2,2),app.Range{2});
        
       %Read series labels using 'readtable': JRP 19 June 19
        A=extractAfter(app.Range{3},'..');
        bottom=str2double(regexp(A,'\d*','Match'));
        opts=delimitedTextImportOptions('DataLines',[app.CSV(3,1)+1 bottom]);
        series_bulk=readtable(app.Path,opts);
        seriesapprox=str2double(table2array(series_bulk(:,app.CSV(3,2)+1)));
        series2approx=table2array(series_bulk(:,app.CSV(3,2)+2));
        pointIDapprox=table2array(series_bulk(:,app.CSV(3,2)));
        clear A bottom opts series_bulk 
%         seriesapprox =            csvread(app.Path,app.CSV(3,1),app.CSV(3,2),app.Range{3});
        
        excessVecapprox =         csvread(app.Path,app.CSV(4,1),app.CSV(4,2),app.Range{4});
        
        [~,appName,~] = fileparts(app.Path);
        fileNameapprox = [appName,'.app'];
        [CurrentPath,~,~] = fileparts(mfilename('fullpath'));
        savePathapprox = [CurrentPath,filesep,fileNameapprox];
        
        clear cva appName CurrentPath
        save(savePathapprox);
        savePath = savePathapprox;
end

% --- Executes on button press in res_FLAGcheck.
function res_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to res_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of res_FLAGcheck

function versionCheck(default)
global VERSION
mesg = 'An outdated version of default.ini was detected.';
if ~isfield(default, 'version')
    error(mesg);
elseif default.version ~= VERSION
    error(mesg);
end



function a21_Callback(hObject, eventdata, handles)
% hObject    handle to a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a21 as text
%        str2double(get(hObject,'String')) returns contents of a21 as a double


% --- Executes during object creation, after setting all properties.
function a21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a22_Callback(hObject, eventdata, handles)
% hObject    handle to a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a22 as text
%        str2double(get(hObject,'String')) returns contents of a22 as a double


% --- Executes during object creation, after setting all properties.
function a22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numSTDIn_Callback(hObject, eventdata, handles)
% hObject    handle to numSTDIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numSTDIn as text
%        str2double(get(hObject,'String')) returns contents of numSTDIn as a double


% --- Executes during object creation, after setting all properties.
function numSTDIn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSTDIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numSTD_Callback(hObject, eventdata, handles)
% hObject    handle to numSTD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numSTD as text
%        str2double(get(hObject,'String')) returns contents of numSTD as a double


% --- Executes during object creation, after setting all properties.
function numSTD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSTD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a31_Callback(hObject, eventdata, handles)
% hObject    handle to a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a31 as text
%        str2double(get(hObject,'String')) returns contents of a31 as a double


% --- Executes during object creation, after setting all properties.
function a31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a32_Callback(hObject, eventdata, handles)
% hObject    handle to a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a32 as text
%        str2double(get(hObject,'String')) returns contents of a32 as a double


% --- Executes during object creation, after setting all properties.
function a32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a41_Callback(hObject, eventdata, handles)
% hObject    handle to a41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a41 as text
%        str2double(get(hObject,'String')) returns contents of a41 as a double


% --- Executes during object creation, after setting all properties.
function a41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a42_Callback(hObject, eventdata, handles)
% hObject    handle to a42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a42 as text
%        str2double(get(hObject,'String')) returns contents of a42 as a double


% --- Executes during object creation, after setting all properties.
function a42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in corr_FLAGcheck.
function corr_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to corr_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of corr_FLAGcheck


% --- Executes on button press in rescorr_FLAGcheck.
function rescorr_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to rescorr_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rescorr_FLAGcheck


% --- Executes on button press in excel_FLAGcheck.
function excel_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to excel_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of excel_FLAGcheck



function customPath_Callback(hObject, eventdata, handles)
% hObject    handle to customPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of customPath as text
%        str2double(get(hObject,'String')) returns contents of customPath as a double


% --- Executes during object creation, after setting all properties.
function customPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to customPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in customFind.
function customFind_Callback(hObject, eventdata, handles)
% hObject    handle to customFind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile('*.csv');
if FileName ~= 0
    [CurrentPath,~,~] = fileparts(mfilename('fullpath'));
    CurrentPath = [CurrentPath,filesep];
    if strcmp(CurrentPath,PathName)
        FullPath = FileName;
    else
        FullPath = [PathName,FileName];
    end
    set(handles.customPath,'String',FullPath)
end


function voltTrust_Callback(hObject, eventdata, handles)
% hObject    handle to voltTrust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voltTrust as text
%        str2double(get(hObject,'String')) returns contents of voltTrust as a double


% --- Executes during object creation, after setting all properties.
function voltTrust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltTrust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Volt_FLAGcheck.
function Volt_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to Volt_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    set(handles.voltTrust,'Enable','on');
else
    set(handles.voltTrust,'Enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of Volt_FLAGcheck


% --- Executes on button press in anova_FLAGcheck.
function anova_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to anova_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of anova_FLAGcheck
if get(hObject,'Value') == 0
    set(handles.loadPI_FLAGcheck,'Enable','off','Value',0);
    set(handles.BALFIT_ANOVA_FLAGcheck,'Enable','off','Value',0);
    set(handles.Rec_Model_FLAGcheck,'Enable','off','Value',0);
    set(handles.anova_pct,'Enable','off');
    set(handles.anova_pct_text,'Enable','off');
    
else
    set(handles.loadPI_FLAGcheck,'Enable','on');
    set(handles.BALFIT_ANOVA_FLAGcheck,'Enable','on');
    set(handles.Rec_Model_FLAGcheck,'Enable','on');
    set(handles.anova_pct,'Enable','on');
    set(handles.anova_pct_text,'Enable','on');

end
loadPI_FLAGcheck_Callback(handles.loadPI_FLAGcheck, eventdata, handles);

% --- Executes on button press in loadPI_FLAGcheck.
function loadPI_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to loadPI_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loadPI_FLAGcheck
if get(hObject,'Value') == 0
    set(handles.approx_and_PI_print,'Enable','off','Value',0);
    set(handles.PI_print,'Enable','off','Value',0);
else
     set(handles.approx_and_PI_print,'Enable','on');
     set(handles.PI_print,'Enable','on');
end



% --- Executes on button press in BALFIT_Matrix_FLAGcheck.
function BALFIT_Matrix_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to BALFIT_Matrix_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BALFIT_Matrix_FLAGcheck


% --- Executes on button press in BALFIT_ANOVA_FLAGcheck.
function BALFIT_ANOVA_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to BALFIT_ANOVA_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BALFIT_ANOVA_FLAGcheck


% --- Executes on button press in Rec_Model_FLAGcheck.
function Rec_Model_FLAGcheck_Callback(hObject, eventdata, handles)
% hObject    handle to Rec_Model_FLAGcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Rec_Model_FLAGcheck

% --- Executes during object creation, after setting all properties.
function anova_pct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anova_pct_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function anova_pct_Callback(hObject, eventdata, handles)
% hObject    handle to anova_pct_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anova_pct_text as text
%        str2double(get(hObject,'String')) returns contents of anova_pct_text as a double


% --- Executes during object creation, after setting all properties.
function anova_pct_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anova_pct_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit57_Callback(hObject, eventdata, handles)
% hObject    handle to anova_pct_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anova_pct_text as text
%        str2double(get(hObject,'String')) returns contents of anova_pct_text as a double


% --- Executes during object creation, after setting all properties.
function edit57_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anova_pct_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in approx_and_PI_print.
function approx_and_PI_print_Callback(hObject, eventdata, handles)
% hObject    handle to approx_and_PI_print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of approx_and_PI_print


% --- Executes on button press in PI_print.
function PI_print_Callback(hObject, eventdata, handles)
% hObject    handle to PI_print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PI_print



function output_location_Callback(hObject, eventdata, handles)
% hObject    handle to output_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_location as text
%        str2double(get(hObject,'String')) returns contents of output_location as a double


% --- Executes during object creation, after setting all properties.
function output_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in output_location_button.
function output_location_button_Callback(hObject, eventdata, handles)
% hObject    handle to output_location_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selpath=uigetdir;
set(handles.output_location,'String',selpath);


% --- Executes on button press in output_to_calib_FLAG.
function output_to_calib_FLAG_Callback(hObject, eventdata, handles)
% hObject    handle to output_to_calib_FLAG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of output_to_calib_FLAG
if get(hObject,'Value') == 0
    set(handles.output_location_button,'Enable','on');
    set(handles.output_location,'Enable','on');
%     set(handles.output_location,'String',pwd);
else
    set(handles.output_location_button,'Enable','off');
    set(handles.output_location,'Enable','off');
    [calib_path,~,~]=fileparts(get(handles.calPath,'String'));
    if isempty(calib_path)==0
%         [calib_path,~,~] = fileparts(calib_path);
    else
        calib_path=pwd;
    end
    set(handles.output_location,'String',calib_path);
end


% --- Executes on button press in subfolder_FLAG.
function subfolder_FLAG_Callback(hObject, eventdata, handles)
% hObject    handle to subfolder_FLAG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of subfolder_FLAG


% --- Executes on button press in calib_model_save_FLAG.
function calib_model_save_FLAG_Callback(hObject, eventdata, handles)
% hObject    handle to calib_model_save_FLAG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of calib_model_save_FLAG
