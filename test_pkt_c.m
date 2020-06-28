
%%% Test
clear;
% Used: 10   5,5   10,10   10,20,30   10,20,30,40,60 
net = letter_functions.createNet('10 20 30'); 
% Used: trainlm, trainbfg, trainbr, traingda, trainr
net = letter_functions.selectTraining(net, 'trainlm'); 
% Used: tansig, purelin, hardlim, poslin, logsig, logsig
% logsig, purelin, purelin, logsig
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'poslin';
net.layers{3}.transferFcn = 'poslin';
net.layers{4}.transferFcn = 'poslin';

[inputs, targets] = letter_functions.getDataset('2');
net = letter_functions.segmentData(net, 0.90, 0.05, 0.05);

[net, tr] = letter_functions.trainFunction(net, inputs, targets);


[inputs, targets] = letter_functions.getDataset('123');
net = train(net, inputs, targets);



disp('Accuracy in the all images');
[inputs, targets] = letter_functions.getDataset('all');

accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);


disp('Accuracy in the set_1 images');
[inputs, targets] = letter_functions.getDataset('1');

accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);


disp('Accuracy in the set_2 images');
[inputs, targets] = letter_functions.getDataset('2');

accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);



disp('Accuracy in the set_3 images');
[inputs, targets] = letter_functions.getDataset('3');

accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);


    
    
    
    
   









