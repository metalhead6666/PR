function varargout = PR(varargin)
% PR MATLAB code for PR.fig
%      PR, by itself, creates a new PR or raises the existing
%      singleton*.
%
%      H = PR returns the handle to a new PR or the handle to
%      the existing singleton*.
%
%      PR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PR.M with the given input arguments.
%
%      PR('Property','Value',...) creates a new PR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PR

% Last Modified by GUIDE v2.5 08-Apr-2016 18:18:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PR_OpeningFcn, ...
                   'gui_OutputFcn',  @PR_OutputFcn, ...
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

% --- Executes just before PR is made visible.
function PR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PR (see VARARGIN)

% Choose default command line output for PR
handles.output = hObject;
handles.file_chosen = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
    if handles.file_chosen == 0
        errordlg('Please, choose a file first.', 'Error');
    end

% --- Executes on button press in quit_button.
function quit_button_Callback(hObject, eventdata, handles)
% hObject    handle to quit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close all;

% --- Executes on selection change in class_listbox.
function class_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to class_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns class_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from class_listbox


% --- Executes during object creation, after setting all properties.
function class_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to class_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ft_sel_listbox.
function ft_sel_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to ft_sel_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ft_sel_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ft_sel_listbox


% --- Executes during object creation, after setting all properties.
function ft_sel_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ft_sel_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ft_red_listbox.
function ft_red_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to ft_red_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ft_red_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ft_red_listbox


% --- Executes during object creation, after setting all properties.
function ft_red_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ft_red_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scaling_listbox.
function scaling_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to scaling_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scaling_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scaling_listbox


% --- Executes during object creation, after setting all properties.
function scaling_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scaling_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in file_chosen_button.
function file_chosen_button_Callback(hObject, eventdata, handles)
% hObject    handle to file_chosen_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)   
    [filename, ~] = uigetfile('*.xlsx');
    
    if ~isequal(filename, 0)       
        set(handles.file_chosen_field, 'String', filename);
        handles.file_chosen = 1;
        guidata(hObject, handles);
    end
