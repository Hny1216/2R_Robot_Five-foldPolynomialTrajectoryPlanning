Author = "Hny";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 初始化
sita_0 = [10;20]; sita_f = [60;100];   % 角位移
v_0 = [0;0]; v_f = [0;0];              % 角速度
a_0 = [0;0]; a_f = [0;0];              % 角加速度
tf = 31;   % 规划时间

%% 计算参数
a0 = sita_0;  a1 = v_0; a2 = a_0;
a3 = (20*(sita_f-sita_0)-(8*v_f+12*v_0)*tf+(a_f-3*a_0)*tf*tf)/(2*(tf^3));
a4 = ((-30)*(sita_f-sita_0)+(14*v_f+16*v_0)*tf-(2*a_f-3*a_0)*tf*tf)/(2*(tf^4));
a5 = (12*(sita_f-sita_0)-(6*v_f+6*v_0)*tf+(a_f-a_0)*tf*tf)/(2*(tf^5));
a = [a0,a1,a2,a3,a4,a5];

%% 计算角度，角速度和角加速度的时间函数
l1 = 1;l2 = 1;
t = [0:0.5:tf];
sita_t = a0 + a1*t + a2*(t.^2) + a3*(t.^3) + a4*(t.^4) + a5*(t.^5);
v_t = a1 + 2*a2*(t) + 3*a3*(t.^2) + 4*a4*(t.^3) + 5*a5*(t.^4);
a_t = 2*a2 + 6*a3*t + 12*a4*(t.^2) + 20*a5*(t.^3);

%% 绘制关节曲线
figure(1)
subplot(1,3,1);
plot(t,sita_t(1,:));xlabel("time(s)");ylabel("JointAngle(^o)");
subplot(1,3,2);
plot(t,v_t(1,:));xlabel("time(s)");ylabel("JointAngle(^o/s)");title("关节1");
subplot(1,3,3);
plot(t,a_t(1,:));xlabel("time(s)");ylabel("JointAngle(^o/s^2)");


figure(2)
subplot(1,3,1);
plot(t,sita_t(2,:));xlabel("time(s)");ylabel("JointAngle(^o)");
subplot(1,3,2);
plot(t,v_t(2,:));xlabel("time(s)");ylabel("JointAngle(^o/s)");title("关节2");
subplot(1,3,3);
plot(t,a_t(2,:));xlabel("time(s)");ylabel("JointAngle(^o/s^2)");

%% 绘制机器人规划曲线
x1 = l1*cosd(sita_t(1,:));
y1 = l1*sind(sita_t(1,:));
x2 = x1 + l2*cosd(sita_t(1,:)+sita_t(2,:));
y2 = y1 + l2*sind(sita_t(1,:)+sita_t(2,:));
figure("Name","机器人运动状态图");
for i = 1:length(t)
    x = [0,x1(i),x2(i)];y = [0,y1(i),y2(i)];
    plot(x,y,'-d',"Color","b");hold on;
end
xlabel("x(m)");ylabel("y(m)");
title("机器人运动状态图");