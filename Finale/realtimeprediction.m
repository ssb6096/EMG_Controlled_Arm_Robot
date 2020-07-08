function realtimeprediction(c)
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an EMG stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EMG'); end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});
a=[0 0 0 0 0 0 0 0 0 0];
features_array=zeros(1,32);
classinst=[];
classinstarray=0;
disp('Now receiving data...');
i=1;j=1;
while true
    % get data from the inlet
    [vec,ts] = inlet.pull_sample();
    % and display it
%     fprintf('%.2f\t',vec);
%     fprintf('%.5f\n',ts);
%  y = dsp.Buffer(200,1,vec)
       a=[a ;vec]; 
    if(rem(i,250)==0)
        features_instant= preprocess_realtime_data(a(i-249:i,:));
        %features_array = [features_array;features_instant];
%          display(features_instant);
        %features_instant = dataset(features_instant1);
       %classinst(j,:)= c.predictFcn(features_instant);
       classinst=c.predictFcn(features_instant);
       classinstarray=[classinstarray classinst];
       if length(classinstarray)==5
       modeclass = mode(classinstarray);
       if modeclass==1
        display('close');
    elseif modeclass==2
        display('left');
    elseif modeclass ==3
        display('open');
    elseif modeclass ==4
        display('right');
    elseif modeclass ==5
        display('up');
    elseif modeclass==6
        display('down');
    end
       
    classinstarray=zero(1);
   end
    i=i+1;
    end
end
end
