classdef letter_functions
    methods(Static)
        function[inputs, targets] = readDataSetVowel(set_name, vowel, matrixLabel)
        inputs = [];
        targets = [];
        filePath = fullfile(set_name, vowel);
        filePath1 = strcat(filePath, '\');
        %extension = '/*.png';
        folder_pngs_path =  strcat(filePath1, '*.png');
        images  = dir(folder_pngs_path );
        nfile = max(size(images));

        for i=1:nfile
            image = imread([filePath1 images(i).name]);
            OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
            inputs(:,end+1) = OneDArray;
            targets(:,end+1) = matrixLabel;
        end
     end
    function[inputs, targets] = readDataSet(set_name)
        inputA = [];
        inputE = [];
        inputI = [];
        inputO = [];
        inputU = [];

        targetA = [];
        targetE = [];
        targetI = [];
        targetO = [];
        targetU = [];

        [inputA, targetA] =  letter_functions.readDataSetVowel(set_name, 'A', [1 0 0 0 0]);
        [inputE, targetE] =  letter_functions.readDataSetVowel(set_name, 'E', [0 1 0 0 0]);
        [inputI, targetI] =  letter_functions.readDataSetVowel(set_name, 'I', [0 0 1 0 0]);
        [inputO, targetO] =  letter_functions.readDataSetVowel(set_name, 'O', [0 0 0 1 0]);
        [inputU, targetU] =  letter_functions.readDataSetVowel(set_name, 'U', [0 0 0 0 1]);

        inputs = [inputA inputE inputI inputO inputU];
        targets = [targetA targetE targetI targetO targetU];
    end

    function net = createNet(netInfo)

        networkConfiguration = [];
        networkConfiguration = stringToArray(netInfo);
        net = feedforwardnet(networkConfiguration);

    end


    function net = selectTraining(netIn, trainFunction)
        net = netIn;
        net.trainFcn = trainFunction;
    end

    function net = selectActivation(netIn, actvationFunction)
        net = netIn;
        layerCount = size(net.Layers);

        for i=1:layerCount
            net.layers{i}.transferFcn = actvationFunction;
        end
    end

    function [net, tr] = trainFunction(netIn, inputs, targets)
        net = netIn;
       [net, tr] =  train(net, inputs, targets);
    end

    function accuracy = getAccuracyForVowelFolder(net, set, vowel)
        matrixVowel = [];
        inputs = [];
        targets = [];

        if vowel == 'A'
            matrixVowel = [1 0 0 0 0];
        elseif vowel == 'E'
             matrixVowel = [0 1 0 0 0];
        elseif vowel == 'I'
             matrixVowel = [0 0 1 0 0];
        elseif vowel == 'O'
             matrixVowel = [0 0 0 1 0];
        elseif vowel == 'U'
             matrixVowel = [0 0 0 0 1];
        end

        [inputs, targets] = readDataSetVowel(set, vowel, matrixVowel);
        out = sim(net, inputs);

        r = 0;
        for i=1:size(out,2)               
          [a b] = max(out(:,i));         
          [c d] = max(targets(:,i));  
          if b == d                      
              r = r+1;
          end
        end

        accuracy = r/size(out,2)*100;
    end

    function accuracy = getAccuracyForSet(net, set)
        inputs = [];
        targets = [];

        [inputs, targets] = readDataSet(set);
        out = sim(net, inputs);

        r = 0;
        for i=1:size(out,2)               
          [a b] = max(out(:,i));          
          [c d] = max(targets(:,i))  ;
          if b == d                      
              r = r+1;
          end
        end

        accuracy = r/size(out,2)*100;
    end
    
    function accuracy = getAccuracyOfInput(net, inputs, targets)
        out = sim(net, inputs);

        r = 0;
        for i=1:size(out,2)               
          [a b] = max(out(:,i));        
          [c d] = max(targets(:,i));  
          if b == d                      
              r = r+1;
          end
        end

        accuracy = r/size(out,2)*100;
    end  
    
    end

end