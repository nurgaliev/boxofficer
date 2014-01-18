function [net,tr] = trainModel(input, target, layers)
net = feedforwardnet(layers);
net.trainParam.max_fail=100;
net.trainParam.min_grad = 0;
net.trainParam.mu_max = 1.00e+20;
[net,tr] = train(net,input,target);
