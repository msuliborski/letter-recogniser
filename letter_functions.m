function[inputs, targets] = readDataSetVowel(set, vowel, matrixLabel)
    inputs = [];
    targets = [];
    filePath = strcat(set, '/', vowel, '/');
    extension = '*.png';
    folder_pngs_path = strcat(filePath, extension);
    images  = dir([folder_pngs_path ]);
    nfile = max(size(images));
    
    for i=1:nfile
        image = imread([myDirAlone a(i).name]);
        OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
        inputs(:,end+1) = OneDArray;
        targets(:,end+1) = matrixLabel;
    end
end


function[inputs, targets] = readDataSet(set)
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
    
    [inputA, targetA] =  readDataSetVowel(set, 'A', [1 0 0 0 0]);
    [inputE, targetE] =  readDataSetVowel(set, 'E', [0 1 0 0 0]);
    [inputI, targetI] =  readDataSetVowel(set, 'I', [0 0 1 0 0]);
    [inputO, targetO] =  readDataSetVowel(set, 'O', [0 0 0 1 0]);
    [inputU, targetU] =  readDataSetVowel(set, 'U', [0 0 0 0 1]);
    
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