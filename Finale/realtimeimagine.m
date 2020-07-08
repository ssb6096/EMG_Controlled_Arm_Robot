clear
clc
c1 = load('LDAclassifier27thapril_class1');
% c2=  load('classifier2object.mat','c2')
c2 =  load('LDAclassifier27thapril');
%%%%%%%%%%%%%%%%TEST MODEL%%%%%%%%%%%%%%%%%%
% Create the new ArmRobot object
robot = ArmRobot('COM10');

% values used Throughout
joints = [0 1 2 3 4 5];
%starting step to find center
testc = [1500 1500 1500 1500 1400 1400];
% Set configuration of the robot
robot.setServoCenters([1450 1500 1400 1475 1480 1575]);
robot.setServoBounds([555 800 900 575 575 1375],[2350 2150 2000 2400 2350 2250]);
robot.setLinkLengths([3.66 4.2 1.69 10.69 11.25 6.19 4.78]);

% Connect to the Robot
robot.connect();
val = testc;
robot.moveJoints(testc,joints);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
jarm=0;
iarm=0;
karm=0;
larm=0;
prevlabel=0;
while true
    % get data from the inlet
    [vec,ts] = inlet.pull_sample();
    % and display it
    %fprintf('%.2f\t',vec);
    %fprintf('%.5f\n',ts);
    %y = dsp.Buffer(200,1,vec)
    a=[a ;vec];
if(rem(i,250)==0)
        features_instant= preprocess_realtime_data(a(i-249:i,:));
        %features_array = [features_array;features_instant];
        %display(features_instant);
        %features_instant = dataset(features_instant1);
        %classinst(j,:)= c.predictFcn(features_instant);
        classinst1=c1.c.predictFcn(features_instant);
        display(classinst1);
    if classinst1==1
        classinst= c2.c.predictFcn(features_instant);
        classinstarray=[classinstarray;classinst];
        [m,n] = size(classinstarray);
     %if m ==3
            %label = mode(classinstarray);
               label=classinst;
           display(label);
%        if classinst ==1  display('close');
%     elseif classinst ==2 display('left');
%     elseif classinst ==3 display('open');
%     elseif classinst ==4 display('right');
%     elseif classinst ==5 display('up');
%     elseif classinst ==6 display('down');
%     if modeclass ==1     display('close');
%     elseif modeclass ==2 display('left');
%     elseif modeclass ==3 display('open');
%     elseif modeclass ==4 display('right');
%     elseif modeclass ==5 display('up');
%     elseif modeclass ==6 display('down');
       if label==0
           label=prevlabel;
       end
       for step = 0:0.5:1.5
        switch label
            case 2  
            iarm = iarm -step;
            if 750<val(1)&&val(1)<2300
            val(1)=val(1)+iarm;
            end
            robot.moveJoints(val,joints);
%             pause(0.5);
            case 4
            jarm = jarm+step;
            if 600<val(1)&&val(1)<2300
            val(1)=val(1)+jarm;
            end
            robot.moveJoints(val,joints);
%             pause(0.5);
            case 5
            karm = karm-step;
            if 600<val(3)&&val(3)<1900
            val(3)=val(3)+karm;
            end
            robot.moveJoints(val,joints);
%             pause(0.5);
            case 6
            larm = larm+step;
            if val(3)>600&&val(3)<1900
            val(3)=val(3)+larm;
            end
            robot.moveJoints(val,joints);
%             pause(0.5);
            case 1
            val(6)=2100;
            robot.moveJoints(val,joints);
%             pause(0.5);
            case 3 
            val(6)=1400;
            robot.moveJoints(val,joints);
%             pause(0.5);
        end
       end
        robot.moveJoints(val,joints);

        classinstarray=0;
        a=zeros(1,10);
        m=1;
        i=1;
        labelpre=label;
    %end
    end
end
i=i+1;
end
