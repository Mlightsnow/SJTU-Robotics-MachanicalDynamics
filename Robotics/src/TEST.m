clear;
clc;
close;
%根据DH矩阵构建机器人对象
L(1) = Link('d',  0.11815,'a',0,'alpha', -pi/2 ,'qlim',[-3*pi/2 3*pi/2]);%定义连杆
L(2) = Link('d', 0.00651,'a',-0.37 ,'alpha', 0,'qlim', [-17*pi/36 53*pi/36]);L(2).offset = pi/2;
L(3) = Link('d', 0,'a',-0.3035 ,'alpha', 0 ,'qlim',[-35*pi/36 35*pi/36]);
L(4) = Link('d', 0.1135,'a',0 ,'alpha', pi/2,'qlim', [-17*pi/36 53*pi/36]);L(4).offset = -pi/2;
L(5) = Link('d', 0.1135,'a',0 ,'alpha', -pi/2,'qlim', [-3*pi/2 3*pi/2]);
L(6) = Link('d', 0.107,'a',0 ,'alpha', 0,'qlim', [-3*pi/2 3*pi/2]);
R = SerialLink(L,'name','UR06');

q0 = [0 0 0 0 0 0];
w = [-0.5 0.5 -0.5 0.5 0 1];
% R.plot3d(q0,'tilesize',0.1,'workspace',w,'nowrist','path','E:\学习电子资源\大三下\机器人学\大作业\UR06_ultimate\meshes');
light('position',[1 1 1],'color','w'); %打光
theta1=[0 0 0 0 0 0];    %机器人伸直且垂直
theta2=[-pi/2 pi/2 pi/2 -pi/2 pi/2 pi/3];
t=[0:0.01:2];
% ctraj:末端执行器直线运动;jtraj:关节运动
g=jtraj(theta1,theta2,t);
R.plot3d(g,'tilesize',0.1,'workspace',w,'nowrist','path','E:\学习电子资源\大三下\机器人学\大作业\UR06_ultimate\meshes'...
    );