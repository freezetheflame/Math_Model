% xor_madaline.m
%% 清理
close all
clear,clc

%% 第一个神经元
P1=[0,0,1,1;0,1,0,1];               % 输入向量
d1=[1,0,1,1];                       % 期望输出向量
lr=maxlinlr(P1,'bias');             % 根据输入矩阵求解最大学习率

net1=linearlayer(0,lr);             % 创建线性网络
net1=train(net1,P1,d1);             % 线性网络训练

%% 第二个神经元
P2=[0,0,1,1;0,1,0,1];               % 输入向量
d2=[1,1,0,1];                       % 期望输出向量
lr=maxlinlr(P2,'bias');             % 根据输入矩阵求解最大学习率

net2=linearlayer(0,lr);             % 创建线性网络
net2=train(net2,P2,d2);             % 线性网络训练

Y1=sim(net1,P1);Y1=Y1>=0.5;
Y2=sim(net2,P2);Y2=Y2>=0.5;
Y=~(Y1&Y2);
%% 显示
disp('第一个神经元最终权值：')      % 命令行输出
w1=[net1.iw{1,1}, net1.b{1,1}]
disp('第二个神经元最终权值：')
w2=[net2.iw{1,1}, net2.b{1,1}]
disp('第一个神经元测试输出：')
Y1
disp('第二个神经元测试输出：');
Y2
disp('最终输出：');
Y

plot([0,1],[0,1],'bo');             % 图形窗口输出
hold on;
plot([0,1],[1,0],'d');
x=-2:.2:2;
y1=1/2/w1(2)-w1(1)/w1(2)*x-w1(3)/w1(2);   % 第一条直线,1/2是区分0和1的阈值
plot(x,y1,'-');
y2=1/2/w2(2)-w2(1)/w2(2)*x-w2(3)/w2(2);   % 第二条直线，1/2是区分0和1的阈值
plot(x,y2,'--');
axis([-0.1,1.1,-0.1,1.1])
xlabel('x');ylabel('y');
title('Madaline用于求解异或逻辑')
legend('0','1','第一条直线','第二条直线');

