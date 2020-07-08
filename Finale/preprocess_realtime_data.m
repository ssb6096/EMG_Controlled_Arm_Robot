function  features = preprocess_realtime_data(data)
sam_freq = 200;
meandata1 = mean(data(:,2));
meandata2 = mean(data(:,3));
meandata3 = mean(data(:,4));
meandata4 = mean(data(:,5));
meandata5 = mean(data(:,6));
meandata6 = mean(data(:,7));
meandata7 = mean(data(:,8));
meandata8 = mean(data(:,9));
data1 = data(:,2) - meandata1;
data2 = data(:,3) - meandata2; 
data3 = data(:,4) - meandata3;
data4 = data(:,5) - meandata4;
data5 = data(:,6) - meandata5;
data6 = data(:,7) - meandata6;
data7 = data(:,8) - meandata7;
data8 = data(:,9) - meandata8; %REMOVING DC COMPONENT
feature1=zeros(0,0);
feature2=zeros(0,0);
feature3=zeros(0,0);
feature4=zeros(0,0);
feature5=zeros(0,0);
feature6=zeros(0,0);
feature7=zeros(0,0);
feature8=zeros(0,0);


    
    %%%%%%%%%%%%%%%TAKING FFT OF CHUNK OF DATA%%%%%%%%%%%%
    chunk_data1_fft = abs(fft(data1));
    chunk_data2_fft = abs(fft(data2));
    chunk_data3_fft = abs(fft(data3));
    chunk_data4_fft = abs(fft(data4));
    chunk_data5_fft = abs(fft(data5));
    chunk_data6_fft = abs(fft(data6));
    chunk_data7_fft = abs(fft(data7));
    chunk_data8_fft = abs(fft(data8));
    %%%%%%%%%%%%%%%%%FILTER%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     chunk_data1_lowpass = lowpass(chunk_data1_fft,60,sam_freq);%make it butter
%     chunk_data2_lowpass = lowpass(chunk_data2_fft,60,sam_freq);
%     chunk_data3_lowpass = lowpass(chunk_data3_fft,60,sam_freq);
%     chunk_data4_lowpass = lowpass(chunk_data4_fft,60,sam_freq);
%     chunk_data5_lowpass = lowpass(chunk_data5_fft,60,sam_freq);
%     chunk_data6_lowpass = lowpass(chunk_data6_fft,60,sam_freq);
%     chunk_data7_lowpass = lowpass(chunk_data7_fft,60,sam_freq);
%     chunk_data8_lowpass = lowpass(chunk_data8_fft,60,sam_freq);
    %figure, freqz(chunk_data1_lowpass)
%     chunk_data1_wdenoise = wdenoise(chunk_data1_fft);
%     chunk_data2_wdenoise = wdenoise(chunk_data2_fft);
%     chunk_data3_wdenoise = wdenoise(chunk_data3_fft);
%     chunk_data4_wdenoise = wdenoise(chunk_data4_fft);
%     chunk_data5_wdenoise = wdenoise(chunk_data5_fft);
%     chunk_data6_wdenoise = wdenoise(chunk_data6_fft);
%     chunk_data7_wdenoise = wdenoise(chunk_data7_fft);
%     chunk_data8_wdenoise = wdenoise(chunk_data8_fft);
    d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',sam_freq);   
    %figure, freqz(d)
    chunk_data1_filter = filtfilt(d,chunk_data1_fft);
    chunk_data2_filter = filtfilt(d,chunk_data2_fft);
    chunk_data3_filter = filtfilt(d,chunk_data3_fft);
    chunk_data4_filter = filtfilt(d,chunk_data4_fft);
    chunk_data5_filter = filtfilt(d,chunk_data5_fft);
    chunk_data6_filter = filtfilt(d,chunk_data6_fft);
    chunk_data7_filter = filtfilt(d,chunk_data7_fft);
    chunk_data8_filter = filtfilt(d,chunk_data8_fft);
    %%%%%%%%%%%%%TAKING IFFT OF CHUNK OF DATA%%%%%%%%%%
    chunk_data1_ifft = abs(ifft(chunk_data1_filter));
    chunk_data2_ifft = abs(ifft(chunk_data2_filter));
    chunk_data3_ifft = abs(ifft(chunk_data3_filter));
    chunk_data4_ifft = abs(ifft(chunk_data4_filter));
    chunk_data5_ifft = abs(ifft(chunk_data5_filter));
    chunk_data6_ifft = abs(ifft(chunk_data6_filter));
    chunk_data7_ifft = abs(ifft(chunk_data7_filter));
    chunk_data8_ifft = abs(ifft(chunk_data8_filter));
    %%%%%%%%%%%%%%APPEND PROCESSED CHUNK%%%%%%%%%%%%%%%%%%%%%
    chunk_data1 = [data1; chunk_data1_ifft];  
    chunk_data2 = [data2; chunk_data2_ifft];
    chunk_data3 = [data3; chunk_data3_ifft];
    chunk_data4 = [data4; chunk_data4_ifft];
    chunk_data5 = [data5; chunk_data5_ifft];
    chunk_data6 = [data6; chunk_data6_ifft];
    chunk_data7 = [data7; chunk_data7_ifft];
    chunk_data8 = [data8; chunk_data8_ifft];
   
    %%%%%%%%%%%%%EXTRACT FEATURES%%%%%%%%%%%%%%%%%%%%%
    extract1 = extract_realtime(chunk_data1_ifft);
    extract2 = extract_realtime(chunk_data2_ifft);
    extract3 = extract_realtime(chunk_data3_ifft);
    extract4 = extract_realtime(chunk_data4_ifft);
    extract5 = extract_realtime(chunk_data5_ifft);
    extract6 = extract_realtime(chunk_data6_ifft);
    extract7 = extract_realtime(chunk_data7_ifft);
    extract8 = extract_realtime(chunk_data8_ifft);
    %%%%%%%%%%%%%%%APPEND FEATURES%%%%%%%%%%%%%%%%%%%%%
    feature1 = [feature1; extract1];
    feature2 = [feature2; extract2];
    feature3 = [feature3; extract3];
    feature4 = [feature4; extract4];
    feature5 = [feature5; extract5];
    feature6 = [feature6; extract6];
    feature7 = [feature7; extract7];
    feature8 = [feature8; extract8];
   

processed_data = [data1; data2;data3;data4;data5;data6;data7;data8];
features1 = [feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8];
%features = transpose(features1);
% display(features1);
%data_label_final = [data_label;data_label;data_label;data_label;data_label;data_label;data_label;data_label;];
features = normalize(features1(:,1:32));
% features=features1;
%figure, subplot(2,1,1); plot(1:length(features1(:,1)),features1(:,1)); subplot(2,1,2); plot(1:length(features(:,1)),features(:,1));
%figure, subplot(2,1,1); plot(1:length(features1(:,2)),features1(:,2)); subplot(2,1,2); plot(1:length(features(:,2)),features(:,2));
end