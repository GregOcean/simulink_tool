function [ ] = genTestModel( busDefPath, busNameSet, modelPath)

modelPath = 'D:\611Project\origin_sample\test.mdl';
newModelName = 'testdesign.mdl';

[inportsName, outportsName] = getModelBusName(modelPath);

busDefPath = 'D:\611Project\origin_sample';
busNameSet = cell(1,1);
busNameSet(1,1) = {'BusD6.m'};

cd(busDefPath);

for i = 1:length(busNameSet)
    fileName = busNameSet{i,1};
    funcName = fileName(1 : length(fileName) - 2);
    run(funcName);
end
% 将Bus定义中生成的object转换为workspace中的cell，从而能够读取并解析
busDef = Simulink.Bus.objectToCell();

nb_in = length(inportsName);


for i = 1 : nb_in
    % 对Bus定义进行循环查找
    % 传入参数：目标新模型名（路径）、 当前目标接口名、 Bus定义
    % 解析并给模型加入模块
    %% 目前这个函数将解析和加入信号生成模块混在一起了，实际实现需要分离这两部分功能
    %% 分别实现在按钮“生成输入”
    analyseBus(newModelName, inportsName{i,1}, busDef);
end