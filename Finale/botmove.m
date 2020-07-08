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

%robot.moveJoints(testc, joints);
val = testc;
label=2;
%movelabel(val,label,joints);
robot.moveJoints(testc,joints);


%function  movelabel(val, label,joints)
    iarm=0;
    jarm=0;
while true
     if label==2  
        iarm = iarm -0.25;
        if 750<val(1)&&val(1)<2300
        val(1)=val(1)+iarm;
        end
        robot.moveJoints(val,joints);
        
    elseif label==4
        jarm = jarm+0.25;
        if 600<val(1)&&val(1)<2300
        val(1)=val(1)+jarm;
        end
        robot.moveJoints(val,joint);
    elseif label ==5
        iarm = iarm-0.25;
       if 950<val(3)&&val(3)<1950
        val(3)=val(3)+iarm;
       end
        robot.moveJoints(val,joints);
    elseif label ==6
        iarm = iarm+0.25;
        if val(3)>950&&val(3)<1950
        val(3)=val(3)+iarm;
        end
    robot.moveJoints(val,joints);
     elseif label==1
         val(6)=2200;
         robot.moveJoints(val,joints);
     else
        val(6)=1400;
        robot.moveJoints(val,joints);
    end
    
   
   
end
 robot.delete();