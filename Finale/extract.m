function features = edatachunktract(datachunk)
    %output_length = length(datachunk);
    output_mean = mean(datachunk);
    output_SD = std(datachunk);
    output_max = max(datachunk);
    output_min = min(datachunk);
    output_var=var(datachunk);
    sk=skewness(datachunk);
    k=kurtosis(datachunk);
    mav=mad(datachunk);
    %Simple Squared Integral
ssi = sum((datachunk).^2);
%Slope Sign change
for i = 2:1:length(datachunk)-1
    if ((datachunk(i)-datachunk(i-1)*(datachunk(i)-datachunk(i+1)))>0)
        a=1;
    else 
        a=0;
    end
    ssc = sum(a);
end

%Willison Amplitude
for l = 1:1:(length(datachunk)-1)
    if (abs(datachunk(l)-datachunk(l+1))>0)
        a=1;
    else 
        a=0;
    end
    wamp = sum(a);
end
%log Detector
logan = exp(((1/length(datachunk)).*sum(log(abs(datachunk)))));

    features = [mav output_var ssc logan]; 
end