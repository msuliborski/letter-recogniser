
%%% Test
for i = 1:1
    clear;
    disp(i);
    % Used: 10   5,5   10,10   10,20,10   10,30,50,30,10 
    net = letter_functions.createNet('10'); 
    % Used: trainlm, trainbfg, trainbr, traingda, trainr
    net = letter_functions.selectTraining(net, 'trainlm'); 
    % Used: tansig, purelin, hardlim, poslin, logsig, logsig
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'purelin';

    [inputs, targets] = letter_functions.getDataset('2');
    net = letter_functions.segmentData(net, 0.7, 0.15, 0.15);
    
    
    [net, tr] = letter_functions.trainFunction(net, inputs, targets);
    
   
    
    
    % Accuracy in the total of examples
    out = sim(net, inputs);
    plotconfusion(targets, out)
    plotperf(tr)  


    r=0;
    for i=1:size(out,2)               
      [a b] = max(out(:,i));          
      [c d] = max(irisTargets(:,i));  
      if b == d                      
          r = r+1;
      end
    end

    accuracy = r / size(out, 2) * 100;
    disp(accuracy);
    
    
    % Accuracy in the test set
    inputs = inputs(:, tr.testInd);
    targets = targets(:, tr.testInd);

    out = sim(net, inputs);

    r=0;
    for i=1:size(tr.testInd,2)               
      [a b] = max(out(:,i));         
      [c d] = max(TTargets(:,i));  
      if b == d                 
          r = r + 1;
      end
    end
    accuracy = r / size(tr.testInd, 2) * 100;
    disp(accuracy);
    
    
    
    
    
    
    
    
    
    
    accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
    disp(accuracy);

    [inputs, targets] = letter_functions.getDataset('all');
    accuracy = letter_functions.getAccuracyOfInput(net, inputs, targets);
    disp(accuracy);
end









