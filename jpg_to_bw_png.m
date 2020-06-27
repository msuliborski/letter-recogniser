

% function test
%   % convFolderToBinary('test')
%   % convImgToBinary('test\rgb-png.png')
%   stringToNumericArray('10 24 22 2')
% end
% 
%  
% function convImgToBinary(pathToImage)
%     if ~isfile(pathToImage)
%         disp('It is not a file!');
%         return;
%     end
% 
%     theFile = dir(fullfile(pathToImage));
% 
%     baseFileName = theFile.name;
%     fullFileName = fullfile(pathToImage);
%     fprintf('Now reading \n');
% 
%     image = imread(fullFileName);
% 
%     if islogical(image)
%         return;
%     end
% 
%     [rows, columns, numberOfColorChannels] = size(image);
%     if numberOfColorChannels == 3
%         greyImage = rgb2gray(image);
%     else
%         greyImage = image;
%     end
% 
%     binaryImageArray = imbinarize(greyImage, 0.5);
% 
%     baseFileName = strrep(fullFileName, '.jpg', '.png');
%     outputFileName = fullfile(baseFileName);
%     fprintf(1, 'Now deleting previous file \n');
%     delete(fullFileName)
%     fprintf(1, 'Now writing \n');
%     imwrite(binaryImageArray, outputFileName);
% end
% 
% function convFolderToBinary(pathToFolder)
%     if ~isfolder(pathToFolder)
%         disp('It is not a folder!');
%         return;
%     end
%     filePatternPNG = fullfile(pathToFolder, '*.png');
%     filePatternJPG = fullfile(pathToFolder, '*.jpg');
%     theFiles = [dir(filePatternPNG); dir(filePatternJPG)];
%     numFiles = length(theFiles);
%     if numFiles == 0 
%         disp('No files in the folder!');
%         return;
%     end
%     
%     for i = 1 : numFiles
%         baseFileName = theFiles(i).name;
%         fullFileName = fullfile(pathToFolder, baseFileName);
%         fprintf('Now reading %s (#%d of %d).\n', fullFileName, i, numFiles);
% 
%         image = imread(fullFileName);
%         
%         if islogical(image)
%             continue;
%         end
% 
%         [rows, columns, numberOfColorChannels] = size(image);
%         if numberOfColorChannels == 3
%             greyImage = rgb2gray(image);
%         else
%             greyImage = image;
%         end
% 
%         binaryImageArray = imbinarize(greyImage, 0.5);
% 
%         baseFileName = strrep(lower(baseFileName), '.jpg', '.png');
%         outputFileName = fullfile(pathToFolder, baseFileName);
%         fprintf(1, 'Now deleting previous file %s\n', outputFileName);
%         delete(fullFileName)
%         fprintf(1, 'Now writing %s\n', outputFileName);
%         imwrite(binaryImageArray, outputFileName);
%     end
% end
% 
% 
% function arr = stringToNumericArray(string)
%     arr = split(string, ' ');
%     arr = arr';
%     for i = 1 : size(arr, 2)
%         arr{1, i} = str2num(arr{1, i});
%     end
% end
% 
% 
% 
% 
