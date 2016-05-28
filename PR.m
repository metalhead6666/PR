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

% Last Modified by GUIDE v2.5 28-May-2016 23:00:32

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
handles.selected_indexes = [];
handles.data = [];
handles.selected_columns = [];
handles.target = [];
handles.scaling_choice = 1;
handles.class_choice = 1;
handles.ft_red_choice = 1;
handles.dimension_chosen = -1;

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
    elseif handles.dimension_chosen <= 0 || isnan(handles.dimension_chosen)
        errordlg('Please, insert a valid dimension.', 'Error');
    else
        [~, len] = size(handles.selected_indexes);
        
        if len > 0
            aux = [];
            selected = handles.selected_indexes;
            for i=1:len
                %disp(handles.data(:,selected(i)+1));
                aux = [aux handles.data(:,selected(i)+1)];
            end
            handles.selected_columns = aux;
            
            
            [~,len] = size(handles.data);
            
            handles.target = handles.data(:,len);
            
            [target, predicted] = main(handles);
            
            %size(target)
            %size(predicted)
            figure
            plotconfusion(target, predicted);
            
            %disp(handles.target(1:10));
            %disp(aux);            
            %assignin('base', 'aux', aux);
        end
        
        
        
        guidata(hObject, handles);
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
    if handles.file_chosen ~= 0
        handles.class_choice = get(hObject, 'Value');
        guidata(hObject, handles);
    end
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


% --- Executes on selection change in ft_red_listbox.
function ft_red_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to ft_red_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns ft_red_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ft_red_listbox
    if handles.file_chosen ~= 0
        handles.ft_red_choice = get(hObject, 'Value');
        guidata(hObject, handles);
    end


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
    if handles.file_chosen ~= 0
        handles.scaling_choice = get(hObject, 'Value');
        guidata(hObject, handles);
    end


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
        
        %Load File
        %disp(filename);
        [num,txt] = xlsread(filename);
        %disp('File loaded successfully!');
        handles.data = num;
        %size(txt)
        
        %Insert elements in the listbox
        columns = {'None', 'Kruskal-Wallis'};
        set(handles.feature_selection_box, 'String', columns);
        handles.selected_indexes = get(handles.feature_selection_box,'Value');
        
        string_list = {'Before'; 'After'; 'None'};        
        set(handles.scaling_listbox, 'String', string_list);
        string_list = {'PCA'; 'LDA'};
        set(handles.ft_red_listbox, 'String', string_list);
        string_list = {'Minimum Distance Classifier', 'Mahalanobis Distance Classifier', 'Support Vector Machine', 'k-NN'};
        set(handles.class_listbox, 'String', string_list);
        
        set(handles.dimension_textbox, 'Style', 'edit');
        set(handles.knn_neigh, 'Style', 'edit');
        handles.dimension_chosen = str2double(get(handles.dimension_textbox, 'String'));        

        
        %disp(size(handles.data));
        
        guidata(hObject, handles);
    end


% --- Executes on selection change in feature_selection_box.
function feature_selection_box_Callback(hObject, eventdata, handles)
% hObject    handle to feature_selection_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %contents = cellstr(get(hObject,'String'));% returns feature_selection_box contents as cell array
	%disp(contents);
    %contents{get(hObject,'Value')} returns selected item from feature_selection_box
    
    if handles.file_chosen ~= 0
        handles.selected_indexes = get(hObject, 'Value');        
        guidata(hObject, handles);
    end
    

    
% --- Executes during object creation, after setting all properties.
function feature_selection_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to feature_selection_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function percentage_slider_Callback(hObject, eventdata, handles)
% hObject    handle to percentage_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

    val = int32(get(hObject,'Value'));
    set(handles.edit_train,'String',num2str(val));
    set(handles.edit_test,'String',num2str(100-val));
    


% --- Executes during object creation, after setting all properties.
function percentage_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percentage_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_train_Callback(hObject, eventdata, handles)
% hObject    handle to edit_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_train as text
%        str2double(get(hObject,'String')) returns contents of edit_train as a double


% --- Executes during object creation, after setting all properties.
function edit_train_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white'); 
end



function edit_test_Callback(hObject, eventdata, handles)
% hObject    handle to edit_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_test as text
%        str2double(get(hObject,'String')) returns contents of edit_test as a double


% --- Executes during object creation, after setting all properties.
function edit_test_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on feature_selection_box and none of its controls.
function feature_selection_box_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to feature_selection_box (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function dimension_textbox_Callback(hObject, eventdata, handles)
% hObject    handle to dimension_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dimension_textbox as text
%        str2double(get(hObject,'String')) returns contents of dimension_textbox as a double
    if handles.file_chosen ~= 0
        handles.dimension_chosen = str2double(get(hObject, 'String'));        
        guidata(hObject, handles);
    end
    
% --- Executes during object creation, after setting all properties.
function dimension_textbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimension_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',num2str(1));



function knn_neigh_Callback(hObject, eventdata, handles)
% hObject    handle to knn_neigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of knn_neigh as text
%        str2double(get(hObject,'String')) returns contents of knn_neigh as a double


% --- Executes during object creation, after setting all properties.
function knn_neigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to knn_neigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
