function varargout = waveUI(varargin)
% WAVEUI MATLAB code for waveUI.fig
%      WAVEUI, by itself, creates a new WAVEUI or raises the existing
%      singleton*.
%
%      H = WAVEUI returns the handle to a new WAVEUI or the handle to
%      the existing singleton*.
%
%      WAVEUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVEUI.M with the given input arguments.
%
%      WAVEUI('Property','Value',...) creates a new WAVEUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before waveUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to waveUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help waveUI


% Last Modified by GUIDE v2.5 15-Apr-2013 14:01:03


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @waveUI_OpeningFcn, ...
                   'gui_OutputFcn',  @waveUI_OutputFcn, ...
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


%Added by Steven
% addpath utility
% global movv2;
% global movie_playing;
% movie_playing = 0;


% --- Executes just before waveUI is made visible.
function waveUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to waveUI (see VARARGIN)

% Choose default command line output for waveUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


set(gcf,'CloseRequestFcn',@my_closefcn)

% UIWAIT makes waveUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function my_closefcn(hObject, eventdata, handles, varargin)
timers = timerfindall;
if(numel(timers)>0)
    stop(timerfindall);
    delete(timerfindall);
end
delete(gcf);
%setGlobal('closing',true);


% --- Outputs from this function are returned to the command line.
function varargout = waveUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, newpath] = uigetfile('*.mhd', 'Select a Wave Header file');
if ((sum(filename) ~= 0) && (sum(newpath) ~= 0))% If file selected
    set(handles.edit1, 'string', filename);
    [Author, DimY, DimZ, DimT, WaveData] = safeRead(filename);
    set(handles.edit2, 'string', Author);
    set(handles.edit3, 'string', num2str(uint32(str2double(DimY))));
    set(handles.edit7, 'string', num2str(uint32(str2double(DimZ))));
    set(handles.edit8, 'string', num2str(uint32(str2double(DimT))));
    set(handles.edit5, 'string', WaveData);
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
modifiedMetadata(handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
modifiedMetadata(handles);


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

value = get(handles.edit3, 'string');
value = uint32(str2double(value));
set(handles.edit3, 'string', num2str(value));

modifiedMetadata(handles);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
modifiedMetadata(handles);


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function [] = pushbutton3_Callback(hObject, eventdata, handles)
%% Display a preview of the current excitation pattern
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Show loading image
loading_axis=axes('position',[.1  .1  1  1]);
load_pic = imread('Loading.png');
imshow(load_pic,'Parent',loading_axis,'InitialMagnification',100);
drawnow;

try % removing any stored data from a previously viewed wave
    timer = getGlobal('timer');
    stop(timer);
    delete(timer);
    handles.M ='';
    handles.interpolatedM = '';
    handles.axis1 = '';
    handles.axis2 = '';
    handles.numFrames = '';
    axis1 = getGlobal('axis1');
    axis2 = getGlobal('axis2');
        cla(axis1,'reset')
        axis(axis1,'off');
    cla(axis2,'reset')
    axis(axis2,'off');
    guidata(gcf,handles);

    
    assert(~isfield(handles,'interpolatedM'));
catch
    
end


%Read from the GUI
fileCSV = get(handles.edit5, 'string');

orig_dimY = str2double(get(handles.edit3, 'string'));
orig_dimZ = str2double(get(handles.edit7, 'string'));
orig_dimT = str2double(get(handles.edit8, 'string'));

%These are the dimensions of the exciters in the wave tank
numExH = 16;
numExW = 1;

%We assume that we don't need to interpolate in the time dimension
numTim = orig_dimT;


debug('reading from csv: %s',fileCSV);
M = processWaveCSV(fileCSV, [orig_dimY orig_dimZ orig_dimT]);

if (~isempty(M))
    debug('averaging');
    averaged_M_raw = average(M, [numExH numExW numTim]);
    
    debug('making drawable');
    M = makeDrawable(M);

    averaged_M = makeDrawable(averaged_M_raw);
    averaged_size = size(averaged_M);
   
    cla reset 
    axis off

    axis1 = axes('position',[.35 .1 .3 .8],'visible','off');
    axis2 = axes('position',[.7 .1 .3 .8],'visible','off');
    
    set(gcf,'WindowButtonDownFcn',{@my_button_down_fcn,axis1,axis2})
    set(gcf,'WindowButtonUpFcn',@my_button_up_fcn)
    
    %make these variables available outside this function
    setGlobal('interpolatedM',averaged_M);
    setGlobal('interpolatedM_raw',averaged_M_raw);
    setGlobal('M',M);
    setGlobal('axis1',axis1);
    setGlobal('axis2',axis2);
    
    setGlobal('numFrames',averaged_size(3));
    setGlobal('curView',[-37.5,30]);
    setGlobal('lastView',[-37.5,30]);
   
    playMovie();
    
    
    %handle closing the figure
    setGlobal('closing',false);
    try
        while(~getGlobal('closing'))
            pause(1);
        end
    catch
        delete(gcf);
    end
    delete(gcf);
    
end


function playMovie()
%% Internal, sets up a timer to display frames of the preview
timers = timerfindall;

if numel(timers) > 0
    stop(timers);
    delete(timers);
end

T = timer('TimerFcn',{@playMovieCallback},'Period',.08,'ExecutionMode','fixedRate','BusyMode','queue');
setGlobal('timer',T);
setGlobal('timeslice',1);
pause(0.5);
start(T);


function  playMovieCallback(src,evt)
%% Internal, displays the next frame of the preview and increments the time
    time = getGlobal('timeslice');
    setGlobal('timeslice',time+1);
    playMovieFrame(time);

function playMovieFrame(time)
%% Internal, displays an arbitrary frame of the preview
length = getGlobal('numFrames');

M = getGlobal('M');
interpM = getGlobal('interpolatedM');
axis1 = getGlobal('axis1');
axis2 = getGlobal('axis2');
my_view = getGlobal('curView');
surfRender(M,interpM,mod(time,length)+1,axis1,axis2,my_view);

    
   
function my_button_down_fcn(hObject, eventdata,axis1,axis2)
%% Internal, captures mouse press to halt preview playback
t = timerfindall;

if(strcmp(t.Running,'on'))
    stop(t);
end

pos=get(hObject,'CurrentPoint');
setGlobal('startX',pos(1));
setGlobal('startY',pos(2));
setGlobal('endX',pos(1));
setGlobal('endY',pos(2));
setGlobal('numMoves',1);

set(gcf,'WindowButtonMotionFcn',{@my_button_motion_fcn})


function my_button_motion_fcn(hObject, eventdata)
%% Internal, captures mouse motion to change the viewpoint of the surfaces

    previous_endx=getGlobal('endX');
    previous_endy=getGlobal('endY');


cur_end=get(hObject,'CurrentPoint');
    
relative_movement = [cur_end(1)-previous_endx cur_end(2)-previous_endy];


    previousView = getGlobal('lastView');

    
    relative_movement(1) = -3*relative_movement(1);%-37.5;
    relative_movement(2) = -3*relative_movement(2);%+30;
    
    my_view = [previousView(1)+relative_movement(1) previousView(2)+relative_movement(2)];
    setGlobal('curView',my_view);
    playMovieFrame(getGlobal('timeslice'));

function my_button_up_fcn(hObject, eventdata)
%% Internal, captures mouse release and resumes playback of the preview
t = timerfindall;
if(strcmp(t.Running,'off'))
    start(t);
end
[az,el] = view;
setGlobal('lastView',[az,el]);

set(gcf,'WindowButtonMotionFcn','')



function setGlobal(name,value)
%% Adds a variable to the guidata
fig = gcf;
handles = guidata(fig);
handles.(name)=value;
guidata(fig,handles);
 
    
function [value] = getGlobal(name)
%% Gets a variable from guidata
fig = gcf;
handles = guidata(fig);
value = handles.(name);

return 


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveAs(handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%fprintf(get(handles.edit6, 'String'))
fileToWrite = get(handles.edit1,'String');
if (isempty(fileToWrite))
    saveAs(handles);
else
    save(handles, fileToWrite);
end


function saveAs(handles)
[saveOutName, pathToSaveOut] = uiputfile('*.mhd', 'Select a Wave Header file');
if ((sum(saveOutName) ~= 0) && (sum(pathToSaveOut) ~=0))
    fileToWrite = [pathToSaveOut saveOutName];
    set(handles.edit1, 'string', fileToWrite);
    save(handles, fileToWrite);
end


function save(handles, fileToWrite)
textToWrite = containers.Map({'Author', 'DimY', 'DimZ', 'DimT', 'WaveData'},{get(handles.edit2,'String'), get(handles.edit3,'String'), get(handles.edit7,'String'), get(handles.edit8,'String'), get(handles.edit5,'String')});

writeWaveMetadata(fileToWrite, textToWrite);
saveText = get(handles.pushbutton5, 'string');
if (strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', saveText(1:end-1));
end


function modifiedMetadata(handles)

saveText = get(handles.pushbutton5, 'string');
if (~strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', [saveText '*']);
end



% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton3.
function pushbutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

value = get(handles.edit7, 'string');
value = uint32(str2double(value));
set(handles.edit7, 'string', num2str(value));

modifiedMetadata(handles);


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

value = get(handles.edit8, 'string');
value = uint32(str2double(value));
set(handles.edit8, 'string', num2str(value));

modifiedMetadata(handles);


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (isfield(handles,'interpolatedM_raw'))
    [saveOutName, pathToSaveOut] = uiputfile('*.txt', 'Select a location to save new wave data.');
    if ((sum(saveOutName) ~= 0) && (sum(pathToSaveOut) ~=0))
        fileToWrite = [pathToSaveOut saveOutName];
        exportToLewos(handles.interpolatedM_raw, fileToWrite);
    end
else
    fprintf('Error: Generate data by pressing "Run Simulation" before exporting.\n');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, newpath] = uigetfile('*.csv', 'Select a Wave Data file');
if ((sum(filename) ~= 0) && (sum(newpath) ~= 0)) % If file selected
    set(handles.edit5, 'string', [newpath filename]);
    modifiedMetadata(handles);
end
