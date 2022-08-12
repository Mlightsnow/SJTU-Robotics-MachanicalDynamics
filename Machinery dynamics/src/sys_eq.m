function dx = sys_eq(t,x,l1,l2,c)
%x = [q1;omega1;q2;omega2]
q1 = x(1); q2 = x(2); omega1 = x(3); omega2 = x(4);
sym q1(t); sym q2(t); sym omega1(t); sym omega2(t);
t1 = 0.15/2-l1; t2 = 0.1/2 - l2; m1 = 0.6; m2 = 0.5; 
J1 = 0.001125;J2 = 0.0004167; g = 9.8;
A = m1*t1^2+m2*l1^2+J1;
B = -m2*t2*l1*cos(q1-q2);
C = (m1*t1-m2*l1)*g*cos(q1)+c*omega1-m2*t2*l1*sin(q1-q2)*omega2^2;
E = m2*t2^2+J2;
D = -m2*t2*l1*cos(q1-q2);
F = m2*t2*l1*sin(q1-q2)*omega1^2+m2*t2*g*cos(q2)+c*omega2;
domega1 = (C*E/B-F)/(D-E*A/B);
domega2 = E/B*(-A*domega1-C);
dx = [x(2);domega1;x(4);domega2];
end