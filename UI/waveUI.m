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

% UIWAIT makes waveUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
    [Author, DimY, DimZ, DimT, WaveData, SaveTo] = safeRead(filename);
    set(handles.edit2, 'string', Author);
    set(handles.edit3, 'string', num2str(uint32(str2double(DimY))));
    set(handles.edit7, 'string', num2str(uint32(str2double(DimZ))));
    set(handles.edit8, 'string', num2str(uint32(str2double(DimT))));
    set(handles.edit5, 'string', WaveData);
    set(handles.edit6, 'string', SaveTo);
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
saveText = get(handles.pushbutton5, 'string');
if (~strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', [saveText '*']);
end


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
saveText = get(handles.pushbutton5, 'string');
if (~strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', [saveText '*']);
end


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

saveText = get(handles.pushbutton5, 'string');
if (~strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', [saveText '*']);
end


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
saveText = get(handles.pushbutton5, 'string');
if (~strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', [saveText '*']);
end


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
function [interpolated] = pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

numExH = 16;
numExW = 1;
numTim = 20;

fileCSV = get(handles.edit5, 'string');

dimY = uint32(str2double(get(handles.edit3, 'string')));
dimZ = uint32(str2double(get(handles.edit7, 'string')));
dimT = uint32(str2double(get(handles.edit8, 'string')));

M = processWaveCSV(fileCSV, [dimY dimZ dimT]);

if (~isempty(M))
    % Set current axes
    axes(handles.axes5);

    load_pic = imread('Loading.png');
    imshow(load_pic,'Parent',gca,'InitialMagnification',100);
    drawnow;

    interpolatedM = average(M, [numExH numExW numTim]);
    F = render(M, interpolatedM, 'embed');
    cla reset;
    axis off;

    % Play movie
    movv = F;
    movie(gca, movv, 999); 
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[saveOutName, pathToSaveOut] = uiputfile('*.mhd', 'Select a Wave Header file');
if ((sum(saveOutName) ~= 0) && (sum(pathToSaveOut) ~=0))
    set(handles.edit6, 'string', [pathToSaveOut saveOutName]);
end


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%fprintf(get(handles.edit6, 'String'))
textToWrite = containers.Map({'Author', 'DimY', 'DimZ', 'DimT', 'WaveData','SaveTo'},{get(handles.edit2,'String'), get(handles.edit3,'String'), get(handles.edit7,'String'), get(handles.edit8,'String'), get(handles.edit5,'String'), get(handles.edit6,'String')});
fileToWrite = get(handles.edit6,'String');
if (strcmp(fileToWrite,''))
    fprintf('Please enter valid file name and location to save metadata.');
else
    writeWaveMetadata(fileToWrite, textToWrite);
    set(handles.edit1, 'string', fileToWrite);
    
    saveText = get(handles.pushbutton5, 'string');
    if (strcmp(saveText(end),'*'))
        set(handles.pushbutton5, 'string', saveText(1:end-1));
    end
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

saveText = get(handles.pushbutton5, 'string');
if (~strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', [saveText '*']);
end


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

saveText = get(handles.pushbutton5, 'string');
if (~strcmp(saveText(end),'*'))
    set(handles.pushbutton5, 'string', [saveText '*']);
end


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
if (exist('interpolated','var') == 1)
    
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, newpath] = uigetfile('*.csv', 'Select a Wave Data file');
if ((sum(filename) ~= 0) && (sum(newpath) ~= 0)) % If file selected
    set(handles.edit5, 'string', [newpath filename]);
end
