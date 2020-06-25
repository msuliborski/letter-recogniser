% A = im2bw(imread('Folder_1/A/A.jpg'),0.5)
% E = im2bw(imread('Folder_1/E/E.jpg'),0.5)
% I = im2bw(imread('Folder_1/I/I.jpg'),0.5)
% O = im2bw(imread('Folder_1/O/O.jpg'),0.5)
% U = im2bw(imread('Folder_1/U/U.jpg'),0.5)


digitDatasetPath = fullfile('Folder_1');
imds = imageDatastore(digitDatasetPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
% transform(imds,@im2bw);

labelCount = countEachLabel(imds);
img = readimage(imds,1);
size(img);

numTrainFiles = 1;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

imdsValidation = imdsTrain

layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(5)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options);

YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation)
