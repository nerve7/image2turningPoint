function [ dataSet ] = readTif( fileName )
%READTIF 

fl=dir(fileName);
fl(2)=[];
fl(1)=[];
imNum=1:length(fl);
siz=size(imread(fullfile(fileName,fl(1).name)));
dataSet=zeros(length(imNum),siz(1),siz(2));
for i=1:length(imNum)
    data=imread(fullfile(fileName,fl(imNum(i)).name));
    dataSet(i,:,:)=data;
end

end

