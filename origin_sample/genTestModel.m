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
% ��Bus���������ɵ�objectת��Ϊworkspace�е�cell���Ӷ��ܹ���ȡ������
busDef = Simulink.Bus.objectToCell();

nb_in = length(inportsName);


for i = 1 : nb_in
    % ��Bus�������ѭ������
    % ���������Ŀ����ģ������·������ ��ǰĿ��ӿ����� Bus����
    % ��������ģ�ͼ���ģ��
    %% Ŀǰ��������������ͼ����ź�����ģ�����һ���ˣ�ʵ��ʵ����Ҫ�����������ֹ���
    %% �ֱ�ʵ���ڰ�ť���������롱
    analyseBus(newModelName, inportsName{i,1}, busDef);
end