
%%% Test
for i = 1:5    
    clear;
    disp(i);
    % Used: 10   5,5   10,10   10,20,30   10,20,30,40,60 
    net = letter_functions.createNet('10'); 
    % Used: trainlm, trainbfg, trainbr, traingda, trainr
    net = letter_functions.selectTraining(net, 'trainlm'); 
    % Used: tansig, purelin, hardlim, poslin, logsig
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'purelin';

    [inputs, targets] = letter_functions.getDataset('1');
    [net, tr] = letter_functions.trainFunction(net, inputs, targets);
    accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
    disp(accuracy);

    [inputs, targets] = letter_functions.getDataset('all');
    accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
    disp(accuracy);
end










