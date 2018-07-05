load nnweights.mat;
hiddenLayerSize = 120;
net = patternnet(hiddenLayerSize);
inputs=csvread('B:\sem5\project\MLP_NN\MLP_NN\saveprise\input.csv');
targets=csvread('B:\sem5\project\MLP_NN\MLP_NN\saveprise\target.csv');
net = configure(net,inputs',targets');
net = setwb(net,a);
outputs=net(inputs');
plotconfusion(outputs,targets');