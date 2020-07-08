Feature Extraction
function [ssi, ssc, wamp, logan ] = featureexTime(x)
%Simple Squared Integral
ssi = sum((x).^2);
%Slope Sign change
for i = 1:1:length(x)
    if ((x(i)-x(i-1)*(x(i)-x(i+1)))>0)
        a=1;
    else 
        a=0;
    end
    ssc = sum(a);
end
%Willison Amplitude
for i = 1:1:length(x)
    if (abs(x(i)-x(i+1))>0)
        a=1;
    else 
        a=0;
    end
    wamp = sum(a);
end
%log Detector
logan = e.^((1/length(x)).*sum(log(abs(x))));
