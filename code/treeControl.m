% 树状控件的独立例子
function treeControl()
global mc hf;
hf=figure('Position',[300,300,500,300],'Name','treeview例子',...
'Color',[0.925,0.914,0.847],'MenuBar','none','NumberTitle','off');

%在主界面上建右键弹出菜单，便于在树中调用及显示
mc=uicontextmenu('Parent',hf);%右键菜单
mu1=uimenu(mc,'label','菜单1');
mu2=uimenu(mc,'label','菜单2');
mu3=uimenu(mc,'label','菜单3');
set(hf,'uicontextmenu',mc);

pos=[10 20 150 260];
h_tv=actxcontrol('MSComctlLib.TreeCtrl.2',pos,hf);
h_tv.Style = 6;
h_tv.LineStyle = 1;
h_tv.HideSelection = 0;
h_tv.Indentation = 500;
h_tv.FullRowSelect = 1;
h_tv.SingleSel = 1;

h_nodes=h_tv.Nodes;
h_node=h_nodes.Add;
h_node.Text='中国';
h_node.Key='R1';
h_node.Expanded=true;
%R1父节点的Key，4-子节点，R1C1本子节点的Key，最后一个为名称
h_node(1)=h_nodes.Add('R1',4,'R1C1','广东');
h_node(2)=h_nodes.Add('R1C1',4,'R1C1C1','广州');
h_node(3)=h_nodes.Add('R1C1',4,'R1C1C2','深圳');
h_node(4)=h_nodes.Add('R1C1',4,'R1C1C3','东莞'); 

registerevent(h_tv,@nodeclick_event);

%在主界面上设置ButtonDownFcn和ButtonUpFcn函数，以便在其他地方右键时，消掉右键弹出菜单
set(hf,'WindowButtonDownFcn',@WINButttonDownFcn);
set(hf,'WindowButtonUpFcn',@WINButttonDownFcn);
%Tabs();
%subpig();
end



function nodeclick_event(varargin)  
global mc hf;
       if ~isempty(mc)&&~ishandle(mc)
           mc=uicontextmenu('Parent',hf);%右键菜单
           mu1=uimenu(mc,'label','菜单1');
           mu2=uimenu(mc,'label','菜单2');
           mu3=uimenu(mc,'label','菜单3');
           set(hf,'uicontextmenu',mc);
       end

     ev=varargin{end};
     para=varargin{end-1};
     switch ev
     %节点单击响应事件，点击对应的节点，输出节点的内容
     case 'NodeClick'
             nd=para.Node;
             nd.Expanded = 1;
             nd.Checked = 1;
             disp(nd.text)
             
      %右键弹出菜单响应      
     case 'MouseDown'
        a=varargin{end-1};
        b = a.Button;%=1为左键，2为右键
        htvX=a.x;    % 点击的X坐标
        htvY=a.y;    % 点击的Y坐标
        if b==2 
            if ~isempty(mc)&&ishandle(mc)
              set(mc,'Position',[htvX+10 300-htvY-20])
              set(mc,'Visible','on')
            end
        end
    otherwise
     %do nothing
     end
end

function WINButttonDownFcn(src,event)
global mc

%用户在界面的其他地方右键时，消掉右键菜单
if ~isempty(mc)&&ishandle(mc)
       delete(mc)
end

end