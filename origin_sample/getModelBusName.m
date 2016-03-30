function [inportsName, outportsName] = getModelBusName(modelPath)
%   2016.1.15 Chengdu 611
% Function gets all bus names related to the model ,including inports and outports
%   modelPath: path of model you wanna analyse
%   modelName: name of the model
%   inportsName: Set of model's Inport Bus Names
%   outportsName:Set of model's Outports Bus Names
%   原代码比较愚蠢地匹配了mdl文本中的相应字段，需要重写。
%   方法样例：
% find_system('test')% 价载模型，参数为modelPath去掉mdl后缀
% ans = 
%     'test'
%     'test/In1'
%     'test/Out1'
% sys = find_system('test')
% sys = 
%     'test'
%     'test/In1'
%     'test/Out1'
% handle = get_param(sys,'Handle')%通过句柄操作模块
% handle = 
%     [14.0018]
%     [15.0023]
%     [16.0018]
% get_param(handle{2},'BusObject')
% ans =
% BUS_GNC_ADSCMD
% get_param(handle{2},'Name')
% ans =
% In1

inportsName = {};
outportsName = {};

fid = fopen(modelPath,'rt');
if fid < 1
    print('file does not exist');
end

countIn = 0;
countOut = 0;
numInport = 0;
numOutport = 0;
% 逐行读取，硬性匹配相关参数
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    % 匹配Bus名称
    T = sscanf(tline, '      BusObject		      "%s',[1,inf]);
    T = T(1 : length(T) - 1);
    % 匹配Bus输入口
    if ischar(numInport) || numInport == 0
        numInport = sscanf(tline,'    NumRootInports	    %d');
        inportsName = cell(1, numInport);
    end
    if ischar(numOutport) || numOutport == 0
        numOutport = sscanf(tline,'    NumRootOutports	    %d');
        outportsName = cell(1, numOutport);
    end
    
    if(~isempty(T)) && (countIn < numInport)
        countIn = countIn + 1;
        inportsName(countIn) = {T};
        continue;
    end
    if (~isempty(T)) && (countOut < numOutport)
        countOut = countOut + 1;
        outportsName(countOut) = {T};
    end
end

status = fclose(fid);
if status < 0
    disp('file close failed');
end