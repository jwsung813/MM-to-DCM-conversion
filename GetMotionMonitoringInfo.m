function [SliceDimensionXInmm, SliceDimensionYInmm, SliceDimensionZInmm, ...
    Rows, Columns] = GetMotionMonitoringInfo(FractionFolder)

folder_ExamCards = sprintf('%s\\ExamCards',FractionFolder);

strings_info = {'"SliceDimensionXInmm":'; ...
    '"SliceDimensionYInmm":'; ...
    '"SliceDimensionZInmm":'; ...
    '"SliceThicknessInmm":'; ...
    '"Rows":'; ...
    '"Columns":'};

if exist(folder_ExamCards,'dir')
    filename_MM_ExamCardInfo = sprintf('%s\\MotionMonitoring2DImages.ExamCardInfo.json',folder_ExamCards);

    if exist(filename_MM_ExamCardInfo,'file')

        fid = fopen(filename_MM_ExamCardInfo);

        examcard_info = fread(fid);
        str_examcard_info = strcat(char(examcard_info'));

        str_examcard_info_split = strsplit(str_examcard_info,strings_info);

        str_SliceDimensionXInmm = str_examcard_info_split{2};
        str_SliceDimensionXInmm = strsplit(str_SliceDimensionXInmm,',');
        str_SliceDimensionXInmm = str_SliceDimensionXInmm{1};
        SliceDimensionXInmm = str2double(str_SliceDimensionXInmm);

        str_SliceDimensionYInmm = str_examcard_info_split{3};
        str_SliceDimensionYInmm = strsplit(str_SliceDimensionYInmm,',');
        str_SliceDimensionYInmm = str_SliceDimensionYInmm{1};
        SliceDimensionYInmm = str2double(str_SliceDimensionYInmm);

        str_SliceDimensionZInmm = str_examcard_info_split{4};
        str_SliceDimensionZInmm = strsplit(str_SliceDimensionZInmm,',');
        str_SliceDimensionZInmm = str_SliceDimensionZInmm{1};
        SliceDimensionZInmm = str2double(str_SliceDimensionZInmm);

        str_Rows = str_examcard_info_split{6};
        str_Rows = strsplit(str_Rows,',');
        str_Rows = str_Rows{1};
        Rows = str2double(str_Rows);

        str_Columns = str_examcard_info_split{7};
        str_Columns = strsplit(str_Columns,'\n');
        str_Columns = str_Columns{1};
        Columns = str2double(str_Columns);

        fclose(fid);
    else
        fprintf('Mootion Monitoring ExamCards file does not exist for %s.',FractionFolder)

        SliceDimensionXInmm = nan;
        SliceDimensionYInmm = nan;
        Rows = nan;
        Columns = nan;
    end

else
    fprintf('ExamCards folder does not exist for %s.',FractionFolder)
    
    SliceDimensionXInmm = nan;
    SliceDimensionYInmm = nan;
    Rows = nan;
    Columns = nan;
end

