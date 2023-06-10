%% STEP1: data load
Data.imagesFolder='';%The folder of the images
IM=readTif(Data.imagesFolder);
%% STEP2: para set
Data.bgRange=[1,1,42,180];%Background [x1,y1,x2,y2];
Data.bgInt=mean(mean(IM(:,Data.bgRange(1):Data.bgRange(3),Data.bgRange(2):Data.bgRange(4)),3),2);
Data.scale=100;%Scale for CWT
Data.minPeakWidth=10;%The fastest rate of changes

%% STEP3: Analyze
[Data.risePks,Data.fallPks] = impulseTimingCwt(IM,Data.bgInt,...
    Data.scale,Data.minPeakWidth);

