% ��״�ؼ��Ķ�������
function treeControl()
global mc hf;
hf=figure('Position',[300,300,500,300],'Name','treeview����',...
'Color',[0.925,0.914,0.847],'MenuBar','none','NumberTitle','off');

%���������Ͻ��Ҽ������˵������������е��ü���ʾ
mc=uicontextmenu('Parent',hf);%�Ҽ��˵�
mu1=uimenu(mc,'label','�˵�1');
mu2=uimenu(mc,'label','�˵�2');
mu3=uimenu(mc,'label','�˵�3');
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
h_node.Text='�й�';
h_node.Key='R1';
h_node.Expanded=true;
%R1���ڵ��Key��4-�ӽڵ㣬R1C1���ӽڵ��Key�����һ��Ϊ����
h_node(1)=h_nodes.Add('R1',4,'R1C1','�㶫');
h_node(2)=h_nodes.Add('R1C1',4,'R1C1C1','����');
h_node(3)=h_nodes.Add('R1C1',4,'R1C1C2','����');
h_node(4)=h_nodes.Add('R1C1',4,'R1C1C3','��ݸ'); 

registerevent(h_tv,@nodeclick_event);

%��������������ButtonDownFcn��ButtonUpFcn�������Ա��������ط��Ҽ�ʱ�������Ҽ������˵�
set(hf,'WindowButtonDownFcn',@WINButttonDownFcn);
set(hf,'WindowButtonUpFcn',@WINButttonDownFcn);
%Tabs();
%subpig();
end



function nodeclick_event(varargin)  
global mc hf;
       if ~isempty(mc)&&~ishandle(mc)
           mc=uicontextmenu('Parent',hf);%�Ҽ��˵�
           mu1=uimenu(mc,'label','�˵�1');
           mu2=uimenu(mc,'label','�˵�2');
           mu3=uimenu(mc,'label','�˵�3');
           set(hf,'uicontextmenu',mc);
       end

     ev=varargin{end};
     para=varargin{end-1};
     switch ev
     %�ڵ㵥����Ӧ�¼��������Ӧ�Ľڵ㣬����ڵ������
     case 'NodeClick'
             nd=para.Node;
             nd.Expanded = 1;
             nd.Checked = 1;
             disp(nd.text)
             
      %�Ҽ������˵���Ӧ      
     case 'MouseDown'
        a=varargin{end-1};
        b = a.Button;%=1Ϊ�����2Ϊ�Ҽ�
        htvX=a.x;    % �����X����
        htvY=a.y;    % �����Y����
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

%�û��ڽ���������ط��Ҽ�ʱ�������Ҽ��˵�
if ~isempty(mc)&&ishandle(mc)
       delete(mc)
end

end