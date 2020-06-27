clear;
inputs = [];
targets = [];

[inputs, targets] = letter_functions.readDataSet('set_1');
net = letter_functions.createNet('10')
net = letter_functions.selectTraining(net, 'trainlm');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
%net = letter_functions.selectActivation(net, 'purelin');
[net, tr] = letter_functions.trainFunction(net, inputs, targets);
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy)