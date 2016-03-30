function[ ] = analyseBus(newModelName, inportName, busDef)
% AnalyseBus Summary of this function goes here
%   Detailed explaination goes here
%   Analyse one inport bus and generate blocks of input to simulate bus

nb_busDef = length(busDef);
load_system(newModelName);
for  i = 1 :nb_busDef
    if(busDef{i,1}{1,1}==inportName)
        disp('find inport');
        nb_metaSignal = length(busDef{i,1}{1,4});
        for j = 1 : nb_metaSignal
            if(0 == strcmp(busDef{i,1}{1,4}{j,1}{1,3},'single'))
                metaSigName = busDef{i,1}{1,4}{j,1}{1,1};
                name = newModelName(1 : length(newModelName) - 4);
                metaSig = strcat(name,'/',metaSigName);
                % 在模型中添加Constant模块（built-in为该模块所在的组）,颜色参数没卵用
                add_block('built-in/Constant',metaSig,'BackgroundColor','yellow');
                % 设置该模块的参数（Constant模块显示名，输出值，输出类型）
                set_param('testdesign/AdsOnCmd','Value','2','OutDataTypeMode','int8');
                % 设置BusCreator
                add_block('built-in/BusCreator','testdesign/busCreator');
                set_param('testdesign/busCreator','Inputs','1','BusObject','BUS_GNC_ADSCMD')
                
                add_line('testdesign','AdsOnCmd/1','busCreator/1');
                add_line('testdesign','busCreator/1','Model/1');
            elseif(0 == strcmp( busDef{i,1}{1,4}{j,1}{1,3},'int8'))
               
            elseif(0 == strcmp( busDef{i,1}{1,4}{j,1}{1,3},'double'))
                
            else
            end
        end
        break;
    end
end