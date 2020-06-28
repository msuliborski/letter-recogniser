
%%% Test
clear;
% Used: 10   5,5   10,10   10,20,30   10,20,30,40,60 
net = letter_functions.createNet('10 20 30'); 
% Used: trainlm, trainbfg, trainbr, traingda, trainr
net = letter_functions.selectTraining(net, 'trainlm'); 
% Used: tansig, purelin, hardlim, poslin, logsig, logsig
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';
net.layers{4}.transferFcn = 'purelin';

[inputs, targets] = letter_functions.getDataset('2');
net = letter_functions.segmentData(net, 0.90, 0.05, 0.05);

[net, tr] = letter_functions.trainFunction(net, inputs, targets);


[inputs, targets] = letter_functions.getDataset('123');
net = train(net, inputs, targets);


[inputs, targets] = letter_functions.getDataset('custom');
net = letter_functions.segmentData(net, 0.30, 0.35, 0.35);
net = train(net, inputs, targets);


disp('Accuracy in the all images');
[inputs, targets] = letter_functions.getDataset('all');

accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);


disp('Accuracy in the set_custom A images');
[inputs, targets] = letter_functions.readDataSetVowel('set_custom', 'A', [1 0 0 0 0]);
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);

disp('Accuracy in the set_custom E images');
[inputs, targets] = letter_functions.readDataSetVowel('set_custom', 'E', [0 1 0 0 0]);
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);

disp('Accuracy in the set_custom I images');
[inputs, targets] = letter_functions.readDataSetVowel('set_custom', 'I', [0 0 1 0 0]);
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);

disp('Accuracy in the set_custom O images');
[inputs, targets] = letter_functions.readDataSetVowel('set_custom', 'O', [0 0 0 1 0]);
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);

disp('Accuracy in the set_custom U images');
[inputs, targets] = letter_functions.readDataSetVowel('set_custom', 'U', [0 0 0 0 1]);
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);

disp('Accuracy in the set_custom images');
[inputs, targets] = letter_functions.getDataset('custom');
accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
disp(accuracy);

    
    
    
    
   









