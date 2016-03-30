function file = open_file(num_file)
% Detailed explanation goes here
% Open one file (for model file) or multiple files(for bus files)
% num_file == 1 : open 1 file
% else : open multiple files

if nargin == 0 || num_file == 1
    %gui�д��ļ�
    [filename,filepath]=uigetfile('*.mdl','���ļ�');
    file={filename,filepath};
elseif nargin == 1 && num_file > 1
    %gui�д��ļ�
    [filename,filepath]=uigetfile('*.m','���ļ�','MultiSelect','on');
    file={filename,filepath};
end


%fid=fopen(file,'rt');%read txt
%filep=strcat(filepath,filename);


