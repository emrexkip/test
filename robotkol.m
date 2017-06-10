function varargout = robotkol(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @robotkol_OpeningFcn, ...
                   'gui_OutputFcn',  @robotkol_OutputFcn, ...
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



function robotkol_OpeningFcn(hObject, ~, handles, varargin)

handles.output = hObject;
m2='Baglanti saglandi.MOTORLAR STABÝLÝZE EDÝLÝYOR';
set(handles.yazi2,'String',m2)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes robotkol wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = robotkol_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
clear all;
global a;
a=arduino('COM3');
servoAttach(a,6); % m4
servoAttach(a,5); % m3
servoAttach(a,4); % m2
servoAttach(a,3); % m1

function motor4_Callback(hObject, eventdata, handles)
global a;
sliderVal1=get(hObject,'Value');
k1=round(180*sliderVal1);
set(handles.motoryazi4,'String',num2str(k1));
servoWrite(a,6,k1); 


% --- Executes during object creation, after setting all properties.
function motor4_CreateFcn(hObject, eventdata, ~)
 
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function motor3_Callback(hObject, ~, handles)
global a;
sliderVal2=get(hObject,'Value');
k2=round(180*sliderVal2);
set(handles.motoryazi3,'String',num2str(k2));
servoWrite(a,5,k2); 

function motor3_CreateFcn(hObject, ~, handles)
 
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function motor2_Callback(hObject, eventdata, handles)
global a;
sliderVal3=get(hObject,'Value');
k3=round(180*sliderVal3);
set(handles.motoryazi2,'String',num2str(k3));
servoWrite(a,4,k3); 
function motor2_CreateFcn(hObject, eventdata, handles)
 
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function motor1_Callback(hObject, eventdata, handles)
global a;
sliderVal4=get(hObject,'Value');
k4=round(180*sliderVal4);
set(handles.motoryazi1,'String',num2str(k4));
servoWrite(a,3,k4); 
function motor1_CreateFcn(hObject, eventdata, handles)
 
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function motoryazi4_Callback(hObject, eventdata, handles)
 


% --- Executes during object creation, after setting all properties.
function motoryazi4_CreateFcn(hObject, eventdata, handles)
 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function motoryazi3_Callback(hObject, eventdata, handles)
 

% --- Executes during object creation, after setting all properties.
function motoryazi3_CreateFcn(hObject, eventdata, handles)
 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function motoryazi2_Callback(hObject, eventdata, ~)
 
function motoryazi2_CreateFcn(hObject, eventdata, handles)
 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function motoryazi1_Callback(hObject, eventdata, handles)
 


% --- Executes during object creation, after setting all properties.
function motoryazi1_CreateFcn(hObject, eventdata, handles)
 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dugme1.
 
global a;
j=str2num(get(handles.yazi1,'String'))
m2='Baglanti saglandi.MOTORLAR STABÝLÝZE EDÝLÝYOR';
set(handles.yazi2,'String',m2)



servoWrite(a,6,90); %baslangýc konumlarý
servoWrite(a,5,90); %
servoWrite(a,4,0); %
servoWrite(a,3,100); %
pause(3)
m3='STABÝLÝZASYON SAGLANDÝ.KULLANÝMA HAZÝR';
set(handles.yazi2,'String',m3)
kirmizi=0.24;
yesil=0.05;
mavi=0.15;
vid = videoinput('winvideo',2,'RGB24_320x240');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 2;
start(vid)
while(vid.FramesAcquired<=j)
    
     
    data = getsnapshot(vid);
    diff_kirmizi = imsubtract(data(:,:,1), rgb2gray(data));
    diff_kirmizi = medfilt2(diff_kirmizi, [3 3]);
    diff_kirmizi= im2bw(diff_kirmizi,kirmizi);
    diff_kirmizi = bwareaopen(diff_kirmizi,300);
    bk = bwlabel(diff_kirmizi, 8);
    stats_kirmizi = regionprops(bk, 'BoundingBox', 'Centroid','Area');
    
    
    diff_mavi = imsubtract(data(:,:,3), rgb2gray(data));
    diff_mavi = medfilt2(diff_mavi, [3 3]);
    diff_mavi= im2bw(diff_mavi,mavi);
    diff_mavi = bwareaopen(diff_mavi,300);
    bm = logical(diff_mavi, 8);
    stats_mavi = regionprops(bm, 'BoundingBox', 'Centroid','Area');
    
    diff_yesil = imsubtract(data(:,:,2), rgb2gray(data));
    diff_yesil = medfilt2(diff_yesil, [3 3]);
    diff_yesil= im2bw(diff_yesil,yesil);
    diff_yesil = bwareaopen(diff_yesil,300);
    by = bwlabel(diff_yesil, 8);
    stats_yesil = regionprops(by, 'BoundingBox', 'Centroid','Area');
    imshow(data);
   %subplot(2,2,1),imshow(data),title('orginal görüntü');
   %subplot(2,2,2), imshow(diff_kirmizi),title('kirmizi filtreleme');
   %subplot(2,2,3),imshow(diff_yesil),title('yesil');
   %subplot(2,2,4), imshow(diff_mavi),title('mavi filtreleme');
hold on 
    
    
    for object = 1:length(stats_kirmizi)
        bk = stats_kirmizi(object).BoundingBox;
        xk = stats_kirmizi(object).Centroid;
        ak = stats_kirmizi(object).Area;
       rectangle('Position',bk,'EdgeColor','r','LineWidth',2)
       plot(xk(1),xk(2), '-m+')
      
     end
       
     for object = 1:length(stats_mavi)
        bm = stats_mavi(object).BoundingBox;
        xm = stats_mavi(object).Centroid;
        am = stats_mavi(object).Area;
       rectangle('Position',bm,'EdgeColor','b','LineWidth',2)
       plot(xm(1),xm(2), '-m+')
         
  
     end
    
       
     for object = 1:length(stats_yesil)
        by = stats_yesil(object).BoundingBox;
        xy = stats_yesil(object).Centroid;
        ay = stats_yesil(object).Area;
       rectangle('Position',by,'EdgeColor','g','LineWidth',2)
       plot(xy(1),xy(2), '-m+')
    
     end
  
    
hold off  
  
end
stop(vid);
flushdata(vid);


function yazi1_Callback(hObject, eventdata, handles)
 
function yazi1_CreateFcn(hObject, ~, handles)
 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yazi2_Callback(~, eventdata, ~)




function yazi2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
