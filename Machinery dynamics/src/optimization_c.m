clc;
clear;
close;

% 质量和几何参数和阻尼系数
lDC = 0.0409; lDG = 0; lDE = 0.15; lGF = 0.1;
lCE = lDE - lDC; lDF = lGF - lDG;
l1 = lDC; l2 = lDG;
c = 0.05;
m1 = 0.6; m2 = 0.5; g = 9.8;

deltac = 0.01;
RES = zeros(1,1/deltac); n1 = 1;
Vmin = m1*g*(5-lDE/2+l1)+m2*g*(5+l1+l2-lGF/2)-53.9;
for ci = 0:deltac:5
    para = [0 l1 l2 ci];
    % 由simulink计算得到系统机械能M
    res = sim('double_pendulum');
    t = res.find('tout');
    M = res.yout{7}.Values.data;
    n = length(t);
    for i = 1:n-200
        if (-M(i)+53.9+Vmin)/Vmin < 0.001 && (-M(i+200)+53.9+Vmin)/Vmin < 0.001
            RES(n1) = t(i);
            disp(n1);
            break;
        end
    end
    n1 = n1+1;
end
plot(0.04:deltac:5,RES(5:end));
xlabel('关节阻尼系数N*M/rad/s'); ylabel('摆动时间s');grid on