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

w = [-0.8 0.8 -0.8 0.8 0 1.6];
% R.plot3d(q0,'tilesize',0.1,'workspace',w,'nowrist','path','E:\学习电子资源\大三下\机器人学\大作业\UR06_ultimate\meshes');
light('position',[1 1 1],'color','w'); %打光

%正运动学和逆运动学和雅可比示例
m = [1 1 1 1 1 1];
q0 = [0 0 0 0 0 0];
q = [pi/8 -pi/3 pi/2 -pi/4 -pi/2 pi/3];
t=[0:0.01:2];
% ctraj:末端执行器直线运动;jtraj:关节运动
g=jtraj(q0,q,t);
T = R.fkine(q);
T1 = transl(0.5,0.5,0.5);
q1 = R.ikine(T1);
g1=jtraj(q0,q1,t);
J = R.jacob0(q);
disp(J);
% R.plot3d(g1,'tilesize',0.1,'workspace',w,'wrist','path','E:\学习电子资源\大三下\机器人学\大作业\UR06_ultimate\meshes'...
%    , 'movie','逆向运动学.gif');
%直线运动
% Tc=ctraj(T0,T1,50);
% tt = transl(Tc);
% plot2(tt,'r');grid on;
% T0 = R.fkine(theta1);
% T1 = R.fkine(theta2);