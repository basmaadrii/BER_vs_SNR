function varargout = BER_GUI(varargin)
% BER_GUI MATLAB code for BER_GUI.fig
%      BER_GUI, by itself, creates a new BER_GUI or raises the existing
%      singleton*.
%
%      H = BER_GUI returns the handle to a new BER_GUI or the handle to
%      the existing singleton*.
%
%      BER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BER_GUI.M with the given input arguments.
%
%      BER_GUI('Property','Value',...) creates a new BER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BER_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BER_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BER_GUI

% Last Modified by GUIDE v2.5 26-Apr-2017 14:59:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BER_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @BER_GUI_OutputFcn, ...
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

% --- Executes just before BER_GUI is made visible.
function BER_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BER_GUI (see VARARGIN)

% Choose default command line output for BER_GUI
handles.output = hObject;

%snr ranges from 0 to 30 dB with 2 dB step size
handles.SNR = 0 : 2 : 30;
%num of bits for each SNR value is 1e6
numbit = 1e6;
handles.bits = randi([0 1], [1 numbit]);

% Update handles structure
guidata(hObject, handles);


% This sets up the initial plot - only do when we are invisible
% so window can get raised using BER_GUI.
if strcmp(get(hObject,'Visible'),'off')
    BER(handles.bits, 'OOK', handles.SNR);
    hold on;
    BER(handles.bits, 'PRK', handles.SNR);
    BER(handles.bits, 'FSK', handles.SNR);
    legend('OOK','PRK','FSK')
    hold off;
end

% UIWAIT makes BER_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BER_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

mod = get(handles.selectMod, 'Value');
switch mod
    case 1
        BER(handles.bits, 'OOK', handles.SNR);
        hold on;
        BER(handles.bits, 'PRK', handles.SNR);
        BER(handles.bits, 'FSK', handles.SNR);
        legend('OOK','PRK','FSK')
        hold off;
    case 2
        BER(handles.bits, 'OOK', handles.SNR);
    case 3
        BER(handles.bits, 'PRK', handles.SNR);
    case 4
        BER(handles.bits, 'FSK', handles.SNR);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on selection change in selectMod.
function selectMod_Callback(hObject, eventdata, handles)
% hObject    handle to selectMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectMod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectMod


% --- Executes during object creation, after setting all properties.
function selectMod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
