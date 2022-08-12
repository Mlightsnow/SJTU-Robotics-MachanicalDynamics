clc;
clear;
close;


lDC = 0.05; lDG = 0.025; lDE = 0.15; lGF = 0.1;
lCE = lDE - lDC; lDF = lGF - lDG;
l1 = lDC; l2 = lDG;
c = 0.05;
m1 = 0.6; m2 = 0.5; g = 9.8;
para = [0 l1 l2 c];
% 由simulink计算得到关节位置，速度，加速度
res = sim('double_pendulum');
t = res.find('tout');
q1 = res.yout{1}.Values.data;
qd1 = res.yout{2}.Values.data;
qdd1 = res.yout{3}.Values.data;
q2 = res.yout{4}.Values.data;
qd2 = res.yout{5}.Values.data;
qdd2 = res.yout{6}.Values.data;



% 几何参数和阻尼系数
lDC = 0.05; lDG = 0.025; lDE = 0.15; lGF = 0.1;
lCE = lDE - lDC; lDF = lGF - lDG;
l1 = lDC; l2 = lDG;
c = 0.05;

% 绘制EF点位置、速度、加速度
n = length(t);
xF = zeros(1,n); yF = zeros(1,n);
vF = zeros(1,n); aF = zeros(1,n);
xE = zeros(1,n); yE = zeros(1,n);
vE = zeros(1,n); aE = zeros(1,n);
for i = 1:n
    xE(i) = lCE*cos(q1(i)); yE(i) = lCE*sin(q1(i))+5;
    vxE = -lCE*qd1(i)*sin(q1(i)); vyE = lCE*qd1(i)*cos(q1(i));
    vE(i) = sqrt(vxE^2+vyE^2);
    axE = -lCE*qdd1(i)*sin(q1(i))-lCE*qd1(i)^2*cos(q1(i)); ayE = lCE*qdd1(i)*cos(q1(i))-lCE*qd1(i)^2*sin(q1(i));
    aE(i) = sqrt(axE^2+ayE^2);
    
    xF(i) = -l1*cos(q1(i))+lDF*cos(q2(i)); yF(i) = -l1*sin(q1(i))+lDF*sin(q2(i))+5;
    vxF = l1*qd1(i)*sin(q1(i))-lDF*qd2(i)*sin(q2(i)); vyF = -l1*qd1(i)*cos(q1(i))+lDF*qd2(i)*cos(q2(i));
    vF(i) = sqrt(vxF^2+vyF^2);
    axF = l1*qdd1(i)*sin(q1(i))+l1*qd1(i)^2*cos(q1(i))-lDF*qdd2(i)*sin(q2(i))-lDF*qd2(i)^2*cos(q2(i)); ayF = -l1*qdd1(i)*cos(q1(i))+l1*qd1(i)^2*sin(q1(i))-lDF*qd2(i)^2*sin(q2(i))+lDF*qdd2(i)*cos(q2(i));
    aF(i) = sqrt(axF^2+ayF^2);
end
subplot(2,4,1);
plot(t,xE');
grid on;xlabel('s');ylabel('m');
title('E点x坐标');
subplot(2,4,2);
plot(t,yE);
grid on;xlabel('s');ylabel('m');
title('E点y坐标');
subplot(2,4,3);
plot(t,vE);
grid on;xlabel('s');ylabel('m/s');
title('E速度大小');
subplot(2,4,4);
plot(t,aE);grid on;xlabel('s');ylabel('m/s2');
title('E加速度大小');
subplot(2,4,5);
plot(t,xF');
grid on;xlabel('s');ylabel('m');
title('F点x坐标');
subplot(2,4,6);
plot(t,yF);
grid on;xlabel('s');ylabel('m');
title('F点y坐标');
subplot(2,4,7);
plot(t,vF);
grid on;xlabel('s');ylabel('m/s');
title('F速度大小');
subplot(2,4,8);
plot(t,aF);grid on;xlabel('s');ylabel('m/s2');
title('F加速度大小');


fps = 60;
myVideo = VideoWriter('仿真动画1'); 
myVideo.FrameRate = fps; 
open(myVideo);
n = length(t);
% 提取关键帧
for i = 1:n
        %各点位置
        A = [-0.05 0]; B = [0.05 0]; C = [0 0.1];
        E = C + [lCE*cos(q1(i)) lCE*sin(q1(i))]; D = C + [-lDC*cos(q1(i)) -lDC*sin(q1(i))];
        F = D + [lDF*cos(q2(i)) lDF*sin(q2(i))]; G = D + [-lDG*cos(q2(i)) -lDG*sin(q2(i))];
        %绘图
        plot([A(1),B(1)],[A(2),B(2)],'black','LineWidth',2);hold on;%AB
        plot([C(1),B(1)],[C(2),B(2)],'black','LineWidth',2);hold on;%BC
        plot([A(1),C(1)],[A(2),C(2)],'black','LineWidth',2);hold on;%CA
        plot(C(1),C(2),'O','MarkerFaceColor','g','MarkerSize',10);hold on;%绘制点C 
        plot(D(1),D(2),'O','MarkerFaceColor','g','MarkerSize',10);hold on;%绘制点D 
        plot([D(1),C(1)],[D(2),C(2)],'r','LineWidth',2);hold on;%CD
        plot([D(1),G(1)],[D(2),G(2)],'r','LineWidth',2);hold on;%DG
        plot([D(1),F(1)],[D(2),F(2)],'blue','LineWidth',2);hold on;%DF
        plot([E(1),C(1)],[E(2),C(2)],'b','LineWidth',2);hold on;%CE
        axis equal; grid on;
        xlim([-0.1 0.1]);ylim([-0.1 0.2])
    frame = getframe(gcf);
    im = frame2im(frame);
    [I,map] = rgb2ind(im,128);
    writeVideo(myVideo,im); 
    if i>1
        imwrite(I,map,'仿真动画.gif','WriteMode','append','DelayTime',1/60);
    else
        imwrite(I,map,'仿真动画.gif','LoopCount',Inf,'DelayTime',1/60);
    end
    if i < n
        clf;
    end
end
close(myVideo); 