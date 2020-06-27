clear;
inputs = [];
targets = [];

[inputs, targets] = letter_functions.readDataSet('set_1');
net = feedforwardnet([10]);
net = letter_functions.selectTraining(net, 'trainlm');
net = letter_functions.selectActivation(net, 'purelin');
[net, tr] = letter_functions.trainFunction(net, inputs, targets);
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy)