%% 使用神经网络模型(向后传播算法BP)解决蝗虫分类问题
clc, clear

% 第一类蝗虫的触角和翅膀
p1 = [1.24, 1.27; 1.36, 1.74; 1.38, 1.64;
 1.38, 1.82; 1.38, 1.90; 1.40, 1.70;
 1.48, 1.82; 1.54, 1.82; 1.56, 2.08];
% 第二类蝗虫的触角和翅膀
p2 = [1.14, 1.82; 1.18, 1.96; 1.20, 1.86;
  1.26, 2.00; 1.28, 2.00; 1.30, 1.96];

p = [p1; p2]';
% 分别获取触角和翅膀的最小值与最大值
pr = minmax(p);

goal = [ones(1, 9), zeros(1, 6); zeros(1, 9), ones(1, 6)];
plot(p1(:, 1), p1(:, 2), 'h', p2(:, 1), p2(:, 2), 'o');

net = newff(pr, [3, 2], {'logsig', 'logsig'});  %函数newff建立一个可训练的前馈网络
%----参数介绍-----%
% net=newff(PR,[S1 S2 ...SN],{TF1 TF2...TFN},BTF,BLF,PF）
% PR：Rx2的矩阵以定义R个输入向量的最小值和最大值；
% Si：第i层神经元个数；
% TFi：第i层的传递函数，默认函数为tansig函数；
% BTF：训练函数，默认函数为trainlm函数；
% BLF：权值/阈值学习函数，默认函数为learngdm函数；
% PF：性能函数，默认函数为mse函数。
net.trainParam.show = 10;            % 现实频率，这里设置为没训练20次显示一次
net.trainParam.lr = 0.05;                % 学习速率，这里设置为0.05
net.trainParam.goal = 1e-10;        % 训练目标最小误差
net.trainParam.epochs = 50000;  % 训练次数，这里设置为300次
net = train(net, p, goal);

% 待分类数据
x = [1.24, 1.80; 1.28, 1.84; 1.40, 2.04]';
% 分类:调用Simulink。输出的是什么信息？
y0 = sim(net, p);
y = sim(net, x);