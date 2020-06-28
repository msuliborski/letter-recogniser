
%%% Test
clear;
% Used: 10   5,5   10,10   10,20,30   10,20,30,40,60 
net = letter_functions.createNet('10 20 30'); 
% Used: trainlm, trainbfg, trainbr, traingda, trainr
net = letter_functions.selectTraining(net, 'trainbfg'); 
% Used: tansig, purelin, hardlim, poslin, logsig, logsig
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';
%net.layers{4}.transferFcn = 'tansig';
%net.layers{5}.transferFcn = 'tansig';
net.layers{4}.transferFcn = 'purelin';

[inputs, targets] = letter_functions.getDataset('2');
net = letter_functions.segmentData(net, 0.7, 0.15, 0.15);


[net, tr] = letter_functions.trainFunction(net, inputs, targets);
plotperf(tr) 



disp('Accuracy in the all images');
[inputs, targets] = letter_functions.getDataset('all');

accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);


disp('Accuracy in the test set');
inputs = inputs(:, tr.testInd);
targets = targets(:, tr.testInd);

accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);

    
    
    
    
   









