l1 = 0.05; l2 = 0.025; c = 0.05; % 要优化的参数
t1 = 0.15/2-l1; t2 = 0.1/2 - l2; m1 = 0.6; m2 = 0.5; 
J1 = 0.001125;J2 = 0.0004167; g = 9.8;
q1 = 0; q2 = 0; omega1 = 0; omega2 = 0;
A = m1*t1^2+m2*l1^2+J1;
B = -m2*t2*l1*cos(q1-q2);
C = (m1*t1-m2*l1)*g*cos(q1)+c*omega1-m2*t2*l1*sin(q1-q2)*omega2^2;
E = m2*t2^2+J2;
D = -m2*t2*l1*cos(q1-q2);
F = m2*t2*l1*sin(q1-q2)*omega1^2+m2*t2*g*cos(q2)+c*omega2;
domega1 = (C*E-F*B)/(D*B-E*A);