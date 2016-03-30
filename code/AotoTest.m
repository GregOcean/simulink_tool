function varargout = AotoTest(varargin)
% AOTOTEST M-file for AotoTest.fig
%      AOTOTEST, by itself, creates a new AOTOTEST or raises the existing
%      singleton*.
%
%      H = AOTOTEST returns the handle to a new AOTOTEST or the handle to
%      the existing singleton*.
%
%      AOTOTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AOTOTEST.M with the given input arguments.
%
%      AOTOTEST('Property','Value',...) creates a new AOTOTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AotoTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AotoTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AotoTest

% Last Modified by GUIDE v2.5 30-Mar-2016 16:33:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AotoTest_OpeningFcn, ...
                   'gui_OutputFcn',  @AotoTest_OutputFcn, ...
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

% 全局变量
% 获取函数 getappdata(handles.aim_gui_tag_where_var_defined, 'defined_global_variable')
% 'sim_file' simulink 模型文件
% 'sfunc_file' s-function 模型文件
% 'bus_file' 

% --- Executes just before AotoTest is made visible.
function AotoTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AotoTest (see VARARGIN)

% Choose default command line output for AotoTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AotoTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% 初始化树状控件,弃用ActiveX控件
% init_tree(handles);
% 使用matlab7版本前可用的uitree控件
init_uitree(handles);

% --- Outputs from this function are returned to the command line.
function varargout = AotoTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_OpenSimMod.
function pushbutton_OpenSimMod_Callback(hObject, eventdata, handles)
% 用户选择并打开单个Simulation模型，保存文件路径
% hObject    handle to pushbutton_OpenSimMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 打开.m后缀文件，将file = [filename,filepath]存入全局变量sim_file
file = open_file(1);
setappdata(handles.pushbutton_OpenSimMod, 'sim_file', file);

% --- Executes on button press in pushbutton_OpenSFuncMod.
function pushbutton_OpenSFuncMod_Callback(hObject, eventdata, handles)
% 用户选择并打开单个S-Function模型，保存文件路径(无测试文件，暂缓)
% hObject    handle to pushbutton_OpenSFuncMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% 打开.m后缀文件，将file = [filename,filepath]存入全局变量sfunc_file
file = open_file(1);
setappdata(handles.pushbutton_OpenSFuncMod, 'sfunc_file', file);

% --- Executes on button press in pushbutton_OpenBusDef.
function pushbutton_OpenBusDef_Callback(hObject, eventdata, handles)
% 用户选择并打开多个Bus定义文件，保存所有文件路径为之后的解析接口做准备，并将Bus文件名显示在右侧列表中
% hObject    handle to pushbutton_OpenBusDef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 打开.m后缀文件，将file = [filename,filepath]存入全局变量sfunc_file
file = open_file(2);
setappdata(handles.pushbutton_OpenSFuncMod, 'bus_file', file);


function edit_ShowSimModName_Callback(hObject, eventdata, handles)
% 显示打开的Simulation模型路径和名称
% hObject    handle to edit_ShowSimModName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ShowSimModName as text
%        str2double(get(hObject,'String')) returns contents of edit_ShowSimModName as a double
set(handles.edit_ShowSimModName,'string',' ');
M = getappdata(handles.pushbutton_OpenSimMod, 'sim_file');
string1 = sprintf('%s', strcat(M{1},M{2}));
set(handles.edit_ShowSimModName, 'String', string1);

% --- Executes during object creation, after setting all properties.
function edit_ShowSimModName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ShowSimModName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ShowSFunModName_Callback(hObject, eventdata, handles)
% 显示打开的S-Function模型路径和名称
% hObject    handle to edit_ShowSFunModName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ShowSFunModName as text
%        str2double(get(hObject,'String')) returns contents of edit_ShowSFunModName as a double
set(handles.edit_ShowSFunModName,'string',' ');
M = getappdata(handles.pushbutton_OpenSFuncMod, 'sfunc_file');
string1 = sprintf('%s', strcat(M{1},M{2}));
set(handles.edit_ShowSFunModName, 'String', string1);

% --- Executes during object creation, after setting all properties.
function edit_ShowSFunModName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ShowSFunModName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ShowBusFiles.
function listbox_ShowBusFiles_Callback(hObject, eventdata, handles)
% 显示打开的所有Bus文件
% hObject    handle to listbox_ShowBusFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_ShowBusFiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ShowBusFiles


% --- Executes during object creation, after setting all properties.
function listbox_ShowBusFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ShowBusFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_SimulateSimModel.
function pushbutton_SimulateSimModel_Callback(hObject, eventdata, handles)
% 对Simulation模型进行模拟，由于输入已经在GenInputData中生成好了，这里只需一个执行函数
% hObject    handle to pushbutton_SimulateSimModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_GenInputData.
function pushbutton_GenInputData_Callback(hObject, eventdata, handles)
% 生成输入数据
% hObject    handle to pushbutton_GenInputData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 根据AnalyseInports和用户设置的结果为simulat和Sfunction模型产生相同的输入模块集合。

% --- Executes on button press in pushbutton_SimulateSFuncModel.
function pushbutton_SimulateSFuncModel_Callback(hObject, eventdata, handles)
% 对SFunction模型进行模拟，由于输入已经在GenInputData中生成好了，这里只需一个执行函数
% hObject    handle to pushbutton_SimulateSFuncModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_CheckSimResult.
function pushbutton_CheckSimResult_Callback(hObject, eventdata, handles)
% 查看Simulation结果文件（暂缓）
% hObject    handle to pushbutton_CheckSimResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_CheckSFuncResult.
function pushbutton_CheckSFuncResult_Callback(hObject, eventdata, handles)
% 查看S-Function模型结果文件（暂缓）
% hObject    handle to pushbutton_CheckSFuncResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_CompareResult.
function pushbutton_CompareResult_Callback(hObject, eventdata, handles)
% 结果对比(暂缓开发)
% hObject    handle to pushbutton_CompareResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_AnalyseInports.
function pushbutton_AnalyseInports_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_AnalyseInports (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 解析输入信号，在左侧的list控件中显示可能的多个输入Bus信号。
% 调用并实现get_inport_name.m，该函数功能参考origin_sample中的getModelBusName.
