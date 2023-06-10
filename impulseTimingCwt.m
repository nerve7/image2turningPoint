function [risePks,fallPks] = impulseTimingCwt(data,bgData,scale,minPeakWidth)
dataNorm = dataLightNoiseNorm(data,bgData);
coefs = dataCwt(dataNorm,scale);
optedCoefs = optCoefs(coefs,scale);
[risePks,fallPks] = getTiming(optedCoefs,minPeakWidth);
end

function [dataNorm] = dataLightNoiseNorm(data,bgInt)
dataNorm=zeros(size(data));
maxD=max(max(data,[],3),[],2);
for i=1:size(data,1)
    dataNorm(i,:,:)=(data(i,:,:)-bgInt(i))/(maxD(i)-bgInt(i));
end
end

function [coefs] = dataCwt(dataNorm,scale)
wname='haar';
coefs=zeros(size(dataNorm));
for i=1:size(dataNorm,2)
    for j=1:size(dataNorm,3)
        s=dataNorm(:,i,j);
        coefs(:,i,j) = cwt(s,scale,wname);
    end
end
end

function [optedData] = optCoefs(coefs,scale)
optedData=zeros(size(coefs));
temp = imbinarize(abs(coefs)).*coefs;
optedData(scale:end-scale,:,:)=temp(scale:end-scale,:,:);
end

function [risePks,fallPks] = getTiming(optedData,minPeakWidth)
optedDataNeg=-optedData;
[risePks,fallPks]=deal(cell(size(optedData,2),size(optedData,3)));
for i=1:size(optedData,2)
    for j=1:size(optedData,3)
        [fallPks{i,j}.ints,fallPks{i,j}.ind,fallPks{i,j}.w,fallPks{i,j}.p]...
            = findpeaks(optedData(:,i,j),'MinPeakWidth',minPeakWidth);
        [risePks{i,j}.ints,risePks{i,j}.ind,risePks{i,j}.w,risePks{i,j}.p]...
            = findpeaks(optedDataNeg(:,i,j),'MinPeakWidth',minPeakWidth);
    end
end
end