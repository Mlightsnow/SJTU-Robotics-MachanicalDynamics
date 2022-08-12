clc;
clear;
close;

% 质量和几何参数和阻尼系数
lDC = 0.05; lDG = 0.025; lDE = 0.15; lGF = 0.1;
lCE = lDE - lDC; lDF = lGF - lDG;
l1 = lDC; l2 = lDG;
c = 0.05;
m1 = 0.6; m2 = 0.5; g = 9.8;

Vmin = 0; % 系统最小机械能
deltaL = 0.005;
RES = zeros(lDE/deltaL+1,lGF/2/deltaL +1, 1);
n1 = 1;
n2 = 1;
for i1 = 0:deltaL:lDE
    for i2 = 0:deltaL:lGF/2
        % 计算系统最小机械能
        if i1 <= lDE/2/(1+m2/m1)
            Vmin = m1*g*(5-lDE/2+i1)+m2*g*(5+i1+i2-lGF/2)-53.9;
        end
        if i1 > lDE/2/(1+m2/m1)
            Vmin = m1*g*(5+lDE/2-i1)+m2*g*(5-i1+i2-lGF/2)-53.9;
        end
        para = [0 i1 i2 c];
        % 由simulink计算得到系统机械能M
        res = sim('double_pendulum');
        t = res.find('tout');
        M = res.yout{7}.Values.data;
        n = length(t);
        for i = 1:n-200
            if (-M(i)+53.9+Vmin)/Vmin < 0.001 && (-M(i+200)+53.9+Vmin)/Vmin < 0.001
                RES(n1,n2, 1) = t(i);
                disp('行');disp(n1);disp('列');disp(n2);
                break;
            end
        end
        n2 = n2+1;
    end
    clc;
    n2 = 1;
    n1 = n1+1;
end
surf(RES);