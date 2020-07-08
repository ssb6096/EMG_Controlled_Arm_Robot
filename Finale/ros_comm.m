rosinit(ipaddress)
msg = rosmessage(p);
msg.Data=4
p=rospublisher('text','std_msgs/Float64');
send(p,msg)
p=rospublisher('text','std_msgs/Float64');
send(p,msg)