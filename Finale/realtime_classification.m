function realtime_classification(m1)
%% instantiate the library
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
d=zeros(1,32);
c=0;
disp('Now receiving data...');
i=1;
while true
    % get data from the inlet
    [vec,ts] = inlet.pull_sample();
    % and display it
%     fprintf('%.2f\t',vec);
%     fprintf('%.5f\n',ts);
%  y = dsp.Buffer(200,1,vec)
    a =  [a
          vec];
    
    if(rem(i,200)==0)
        d= preprocess_test_data(a(i-199:i,:));
        display(d);
       classinst= m1.predictFcn(d);
      % c=[c;classinit];
    end
    i=i+1;
end
end