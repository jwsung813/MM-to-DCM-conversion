function mm_image = GetMotionMonitoringImage(filepath_mmimage, dir_root)

%strsplit_filepath = strsplit(filepath_mmimage,'\');

[~, ~, ~, Rows, Columns] = GetMotionMonitoringInfo(dir_root);

fid_mmimage = fopen(filepath_mmimage,'r');

% header length: 4084
% total length: 458955
% data_ = fread(fid_mmimage,458955-12500,'*ubit8');
% data = fread(fid_mmimage,500,'*ubit8');

data_header = fread(fid_mmimage,4084,'*ubit8');
%str_data_header = strcat(char(data_header'));

data_image = fread(fid_mmimage,Rows*Columns,'*ubit16');
data_image = data_image';

mm_image = reshape(data_image,[Rows Columns]);
mm_image = circshift(mm_image,[-22 0]);

fclose(fid_mmimage);