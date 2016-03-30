function file = open_file(num_file)
% Detailed explanation goes here
% Open one file (for model file) or multiple files(for bus files)
% num_file == 1 : open 1 file
% else : open multiple files

if nargin == 0 || num_file == 1
    %gui中打开文件
    [filename,filepath]=uigetfile('*.mdl','打开文件');
    file={filename,filepath};
elseif nargin == 1 && num_file > 1
    %gui中打开文件
    [filename,filepath]=uigetfile('*.m','打开文件','MultiSelect','on');
    file={filename,filepath};
end


%fid=fopen(file,'rt');%read txt
%filep=strcat(filepath,filename);


