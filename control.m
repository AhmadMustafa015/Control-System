function varargout = control(varargin)
% CONTROL MATLAB code for control.fig
%      CONTROL, by itself, creates a new CONTROL or raises the existing
%      singleton*.
%
%      H = CONTROL returns the handle to a new CONTROL or the handle to
%      the existing singleton*.
%
%      CONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROL.M with the given input arguments.
%
%      CONTROL('Property','Value',...) creates a new CONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before control_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to control_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help control

% Last Modified by GUIDE v2.5 07-Aug-2018 15:24:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @control_OpeningFcn, ...
                   'gui_OutputFcn',  @control_OutputFcn, ...
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


% --- Executes just before control is made visible.
function control_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to control (see VARARGIN)

% Choose default command line output for control
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes control wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global M tfinal K;
M=1;
tfinal=10;
K=1;
set(handles.editK,'string',num2str(K))


% --- Outputs from this function are returned to the command line.
function varargout = control_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function simulationT_Callback(hObject, eventdata, handles)
% hObject    handle to simulationT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simulationT as text
%        str2double(get(hObject,'String')) returns contents of simulationT as a double


% --- Executes during object creation, after setting all properties.
function simulationT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simulationT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_coef.
function button_coef_Callback(hObject, eventdata, handles)
% hObject    handle to button_coef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coefficent
uiwait(coefficent)
global D; 
global N;
tft= tf(N,D);
fshow = evalc('tft');
set(handles.transf,'string',fshow)

% --- Executes on button press in button_tran.
function button_tran_Callback(hObject, eventdata, handles)
% hObject    handle to button_tran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global M D N tfinal;
% excitationF =get(handles.excitation , 'SelectedObject');
assignin('base' ,'M' , M);
assignin('base' ,'D' , D);
assignin('base' ,'N' , N);
assignin('base' ,'tfinal' , tfinal); 
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid


% --- Executes on button press in button_stat.
function button_stat_Callback(hObject, eventdata, handles)
% hObject    handle to button_stat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M D N tfinal;
assignin('base' ,'M' , M);
assignin('base' ,'D' , D);
assignin('base' ,'N' , N);
assignin('base' ,'tfinal' , tfinal); 
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid

% --- Executes on button press in button_root.
function button_root_Callback(hObject, eventdata, handles)
% hObject    handle to button_root (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global D N tfinal M K;
assignin('base' ,'M' , M);
assignin('base' ,'K' , K);
assignin('base' ,'D' , D);
assignin('base' ,'N' , N);
assignin('base' ,'tfinal' , tfinal); 
axes(handles.axes1);
rlocus(N,D);
title('Root Locus');
grid
sys=tf(N,D);
K=rlocfind(sys);
assignin('base' ,'K' , K);
set(handles.editK,'string',num2str(K))
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid




% --- Executes on button press in button_rout.
function button_rout_Callback(hObject, eventdata, handles)
% hObject    handle to button_rout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in b1.
function b1_Callback(hObject, eventdata, handles)
% hObject    handle to b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of b1
global D N tfinal M K;
assignin('base' ,'M' , M);
assignin('base' ,'K' , K);
assignin('base' ,'D' , D);
assignin('base' ,'N' , N);
tfinal =get(handles.slider6 ,'value');
assignin('base' ,'tfinal' , tfinal); 
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid

% --- Executes during object creation, after setting all properties.
function excitation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to excitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in b2.
function b2_Callback(hObject, eventdata, handles)
% hObject    handle to b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of b2
global D N tfinal M K;
assignin('base' ,'M' , M);
assignin('base' ,'K' , K);
assignin('base' ,'D' , D);
assignin('base' ,'N' , N);
tfinal =get(handles.slider6 ,'value');
assignin('base' ,'tfinal' , tfinal); 
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid

% --- Executes when selected object is changed in excitation.
function excitation_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in excitation 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M;
switch(get(eventdata.NewValue ,'Tag'))
    case 'b1'
        M = 1;
    case 'b2'
        M = 2;
    case 'b3'
        M = 3;
end


% --- Executes on button press in b3.
function b3_Callback(hObject, eventdata, handles)
% hObject    handle to b3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of b3
global D N tfinal M K;
assignin('base' ,'M' , M);
assignin('base' ,'K' , K);
assignin('base' ,'D' , D);
assignin('base' ,'N' , N);
tfinal =get(handles.slider6 ,'value');
assignin('base' ,'tfinal' , tfinal); 
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global tfinal;
tfinal = get(handles.slider ,'value');


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global D N tfinal M K;
assignin('base' ,'M' , M);
assignin('base' ,'K' , K);
assignin('base' ,'D' , D);
assignin('base' ,'N' , N);
tfinal =get(handles.slider6 ,'value');
assignin('base' ,'tfinal' , tfinal); 
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement


% --- Executes on slider movement.
function sliderK_Callback(hObject, eventdata, handles)
% hObject    handle to sliderK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global D N tfinal M K;
K = get(handles.sliderK,'value');
assignin('base' ,'M' , M);
assignin('base' ,'K' , K);
assignin('base' ,'tfinal' , tfinal); 
axes(handles.axes1);
rlocus(N,D);
hold on
poless=rlocus(N,D,K);
plot(real(poless),imag(poless),'s','MarkerSize',7,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor',[1 .6 .6])
hold off
title('Root Locus');
grid
assignin('base' ,'K' , K);
set(handles.editK,'string',num2str(K))
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid

% --- Executes during object creation, after setting all properties.
function sliderK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function transf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to transf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over transf.
function transf_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to transf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editK_Callback(hObject, eventdata, handles)
% hObject    handle to editK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editK as text
%        str2double(get(hObject,'String')) returns contents of editK as a double


% --- Executes during object creation, after setting all properties.
function editK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enterK.
function enterK_Callback(hObject, eventdata, handles)
% hObject    handle to enterK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global D N tfinal M K;
K = str2double(get(handles.editK,'string'));
assignin('base' ,'M' , M);
assignin('base' ,'K' , K);
assignin('base' ,'tfinal' , tfinal); 
axes(handles.axes1);
rlocus(N,D);
hold on
poless=rlocus(N,D,K);
plot(real(poless),imag(poless),'s','MarkerSize',7,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor',[1 .6 .6])
hold off
title('Root Locus');
grid
assignin('base' ,'K' , K);
set(handles.editK,'string',num2str(K))
sim('control_simulink');
axes(handles.axes3)
plot(t,y,'r')
title('Transfer Function')
grid
sim('control_simulink');
axes(handles.axes2)
plot(t,er,'b')
title('Static Error')
grid


% --- Executes on button press in bode.
function bode_Callback(hObject, eventdata, handles)
% hObject    handle to bode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global D N;
axes(handles.axes3)
margin(N,D);

% --- Executes on button press in nyquist.
function nyquist_Callback(hObject, eventdata, handles)
% hObject    handle to nyquist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global D N tfinal M K;
sys=tf(N,D);
axes(handles.axes2)
nyquist(sys)
grid