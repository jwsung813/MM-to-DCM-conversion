function writemha2D(fn,A,offset,spacing,type)
% writemha(fn,A,offset,spacing,type)
% fn filename
% A Volume
% offset
% spacing
% type 'uchar','float', or 'short'

Asz = size(A);
Asz(3) = 1;

fp = fopen(fn,'w');
if (fp == -1)
    error ('Cannot open mha file for writing');
end

fprintf (fp,'ObjectType = Image\n');
fprintf (fp,'NDims = 3\n');
fprintf (fp,'BinaryData = True\n');
fprintf (fp,'BinaryDataByteOrderMSB = False\n');
fprintf (fp,'Offset = ');
fprintf (fp,' %g',offset);
fprintf (fp,'\n');
fprintf (fp,'ElementSpacing = ');
fprintf (fp,' %g',spacing);
fprintf (fp,'\n');
fprintf (fp,'DimSize = ');
fprintf (fp,' %d',Asz(1:3));
fprintf (fp,'\n');
fprintf (fp,'AnatomicalOrientation = RAI\n');
if (ndims(A) == 4)
    fprintf(fp,'ElementNumberOfChannels = 3\n');
end
fprintf (fp,'TransformMatrix = 1 0 0 0 1 0 0 0 1\n');
fprintf (fp,'CenterOfRotation = 0 0 0\n');

%% This works for 3D (A stays the same), and 4D (shift left 1)
%A = shiftdim(A,3);

switch(lower(type))
    case 'uchar'
        fprintf (fp,'ElementType = MET_UCHAR\n');
        fprintf (fp,'ElementDataFile = LOCAL\n');
        fwrite (fp,A,'uint8');
    case 'short'
        fprintf (fp,'ElementType = MET_SHORT\n');
        fprintf (fp,'ElementDataFile = LOCAL\n');
        fwrite (fp,A,'int16');
    case 'ushort'
        fprintf (fp,'ElementType = MET_USHORT\n');
        fprintf (fp,'ElementDataFile = LOCAL\n');
        fwrite (fp,A,'uint16');
    case 'uint32'
        fprintf (fp,'ElementType = MET_UINT\n');
        fprintf (fp,'ElementDataFile = LOCAL\n');
        fwrite (fp,A,'uint32');
    case 'float'
        fprintf (fp,'ElementType = MET_FLOAT\n');
        fprintf (fp,'ElementDataFile = LOCAL\n');
        fwrite (fp,A,'real*4');
    otherwise
        fclose(fp);
        error ('Sorry, unsupported type');
end

fclose(fp);