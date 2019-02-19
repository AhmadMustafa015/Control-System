function varargout = coefficent(varargin)
% COEFFICENT MATLAB code for coefficent.fig
%      COEFFICENT, by itself, creates a new COEFFICENT or raises the existing
%      singleton*.
%
%      H = COEFFICENT returns the handle to a new COEFFICENT or the handle to
%      the existing singleton*.
%
%      COEFFICENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COEFFICENT.M with the given input arguments.
%
%      COEFFICENT('Property','Value',...) creates a new COEFFICENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coefficent_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coefficent_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coefficent

% Last Modified by GUIDE v2.5 02-Aug-2018 12:40:53
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coefficent_OpeningFcn, ...
                   'gui_OutputFcn',  @coefficent_OutputFcn, ...
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

% --- Executes just before coefficent is made visible.
function coefficent_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coefficent (see VARARGIN)
global N;
global D;
clear D
clear N
% Choose default command line output for coefficent
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coefficent wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coefficent_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_coef_Callback(hObject, eventdata, handles)
% hObject    handle to edit_coef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_coef as text
%        str2double(get(hObject,'String')) returns contents of edit_coef as a double


% --- Executes during object creation, after setting all properties.
function edit_coef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_coef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in buttton_done.
function buttton_done_Callback(hObject, eventdata, handles)
% hObject    handle to buttton_done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global D;
global N;
if isempty(D)
    f = warndlg('Please Enter Denominator Coefficent', 'Error','warn');
    uiwait(f)
elseif isempty(N)
    f = msgbox('Please Enter Numerator Coefficent', 'Error','warn');
    uiwait(f)
else
    delete(handles.figure1);
end
% --- Executes on button press in button_nextN.
function button_nextN_Callback(hObject, eventdata, handles)
% hObject    handle to button_nextN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coufN =str2num(get(handles.edit_coef ,'string'));
global N;
N= coufN;




function edit_coefD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_coefD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_coefD as text
%        str2double(get(hObject,'String')) returns contents of edit_coefD as a double


% --- Executes during object creation, after setting all properties.
function edit_coefD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_coefD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_nextD.
function button_nextD_Callback(hObject, eventdata, handles)
% hObject    handle to button_nextD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coefD = str2num(get(handles.edit_coefD,'string'));
global D;
D=coefD;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
