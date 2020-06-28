classdef letter_functions
    methods(Static)
        function[inputs, targets] = getDataset(type)
            inputsSet1 = [];
            targetsSet1 = [];

            inputsSet2 = [];
            targetsSet2 = [];

            inputsSet3 = [];
            targetsSet3 = [];

            inputsSetCustom = [];
            targetsSetCustom = [];

            inputsSet123 = [];
            targetsSet123 = [];

            inputsSetAll = [];
            targetsSetAll = [];
            
            if strcmp(type, '1') 
                [inputs, targets] = letter_functions.readDataSet('set_1');
            elseif strcmp(type, '2') 
                [inputs, targets] = letter_functions.readDataSet('set_2');
            elseif strcmp(type, '3')
                [inputs, targets] = letter_functions.readDataSet('set_3');
            elseif strcmp(type, 'custom')
                [inputs, targets] = letter_functions.readDataSet('set_custom');
            elseif strcmp(type, '123')
                [inputsSet1, targetsSet1] = letter_functions.readDataSet('set_1');
                [inputsSet2, targetsSet2] = letter_functions.readDataSet('set_2');
                [inputsSet3, targetsSet3] = letter_functions.readDataSet('set_3');
                inputs = [inputsSet1 inputsSet2 inputsSet3];
                targets = [targetsSet1 targetsSet2 targetsSet3];
            elseif strcmp(type, 'all')
                [inputsSet1, targetsSet1] = letter_functions.readDataSet('set_1');
                [inputsSet2, targetsSet2] = letter_functions.readDataSet('set_2');
                [inputsSet3, targetsSet3] = letter_functions.readDataSet('set_3');
                [inputsSetCustom, targetsSetCustom] = letter_functions.readDataSet('set_custom');
                inputsSet123 = [inputsSet1 inputsSet2 inputsSet3];
                targetsSet123 = [targetsSet1 targetsSet2 targetsSet3];
                inputs = [inputsSet123 inputsSetCustom];
                targets = [targetsSet123 targetsSetCustom];
            end
        end
        
        function[inputs, targets] = readDataSetVowel(set_name, vowel, matrixLabel)
            inputs = [];
            targets = [];
            filePath = fullfile(set_name, vowel);
            filePath1 = strcat(filePath, '\');
            %extension = '/*.png';
            folder_pngs_path =  strcat(filePath1, '*.png');
            images  = dir(folder_pngs_path);
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
            networkConfiguration = letter_functions.stringToNumericArray(netInfo);
            net = feedforwardnet(networkConfiguration);

        end


        function net = selectTraining(netIn, trainFunction)
            net = netIn;
            net.trainFcn = trainFunction;
        end
        
        function net = segmentData(netIn, trainRatio, valRatio, restRatio)
            net = netIn;
            net.divideFcn = 'dividerand';
            net.divideParam.trainRatio = trainRatio;
            net.divideParam.valRatio = valRatio;
            net.divideParam.testRatio = restRatio;
        end

        function net = selectActivation(netIn, actvationFunction)
            net = netIn;
            layerCount = size(net.Layers);

            for i=1:(layerCount-1)
                net.layers{i}.transferFcn = actvationFunction;
            end
            net.layers{layerCount}.transferFcn = 'purelin';
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

            [inputs, targets] = letter_functions.readDataSet(set);
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
        
        function output = classifyImageFromFilename(net, filename)
            letter_functions.convImgToBinary(filename);
            output = letter_functions.classifyImage(net,imread(filename));
        end
        
        
        function output = classifyImage(net, image)
            my_imgA_set_3 = [];
            targetA_set_3 = [];
            nfile = max(size(image));
            OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
            OneDArray = OneDArray';

            out = sim(net, OneDArray);
            [m,i] = max(out);

            if i == 1 
                output = 'A';
            elseif i == 2 
                output = 'E';
            elseif i == 3
                output = 'I';
            elseif i == 4 
                output = 'O';
            elseif i == 5
                output = 'U';
            end
        end

        function accuracy = getAccuracyOfInput(net, inputs, targets)
            out = sim(net, inputs);
            plotconfusion(targets, out)
            
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
        
        function convImgToBinary(pathToImage)
            if ~isfile(pathToImage)
                disp('It is not a file!');
                return;
            end

            theFile = dir(fullfile(pathToImage));

            baseFileName = theFile.name;
            fullFileName = fullfile(pathToImage);
            fprintf('Now reading \n');

            image = imread(fullFileName);

            if islogical(image)
                return;
            end

            [rows, columns, numberOfColorChannels] = size(image);
            if numberOfColorChannels == 3
                greyImage = rgb2gray(image);
            else
                greyImage = image;
            end

            binaryImageArray = imbinarize(greyImage, 0.5);

            baseFileName = strrep(fullFileName, '.jpg', '.png');
            outputFileName = fullfile(baseFileName);
            fprintf(1, 'Now deleting previous file \n');
            delete(fullFileName)
            fprintf(1, 'Now writing \n');
            imwrite(binaryImageArray, outputFileName);
        end

        function convFolderToBinary(pathToFolder)
            if ~isfolder(pathToFolder)
                disp('It is not a folder!');
                return;
            end
            filePatternPNG = fullfile(pathToFolder, '*.png');
            filePatternJPG = fullfile(pathToFolder, '*.jpg');
            theFiles = [dir(filePatternPNG); dir(filePatternJPG)];
            numFiles = length(theFiles);
            if numFiles == 0 
                disp('No files in the folder!');
                return;
            end

            for i = 1 : numFiles
                baseFileName = theFiles(i).name;
                fullFileName = fullfile(pathToFolder, baseFileName);
                fprintf('Now reading %s (#%d of %d).\n', fullFileName, i, numFiles);

                image = imread(fullFileName);

                if islogical(image)
                    continue;
                end

                [rows, columns, numberOfColorChannels] = size(image);
                if numberOfColorChannels == 3
                    greyImage = rgb2gray(image);
                else
                    greyImage = image;
                end

                binaryImageArray = imbinarize(greyImage, 0.5);

                baseFileName = strrep(lower(baseFileName), '.jpg', '.png');
                outputFileName = fullfile(pathToFolder, baseFileName);
                fprintf(1, 'Now deleting previous file %s\n', outputFileName);
                delete(fullFileName)
                fprintf(1, 'Now writing %s\n', outputFileName);
                imwrite(binaryImageArray, outputFileName);
            end
        end


        function arr = stringToNumericArray(string)
            arr = split(string, ' ');
            arr = arr';
            for i = 1 : size(arr, 2)
                arr{1, i} = str2num(arr{1, i});
            end
            arr = cell2mat(arr);
        end
		
		function saveNetwork(name, net)
			save('name', net);
		end
		
        
    end  
end