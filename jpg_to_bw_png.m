


% Specify the folder where the files live.
myFolder = 'C:\Users\Michael\Documents\Knowledge-and-Reasoning---NN\custom';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(myFolder)
	errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease select another folder.', myFolder);
	uiwait(warndlg(errorMessage));
	myFolder = uigetdir();
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.png'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
numFiles = length(theFiles);
if numFiles == 0
	warningMessage = sprintf('Warning: no JPG images found in the folder:\n%s', myFolder);
	uiwait(warnuser(warningMessage));
	return;
end
for k = 1 : numFiles
	baseFileName = theFiles(k).name;
	fullFileName = fullfile(myFolder, baseFileName);
	fprintf('Now reading %s (#%d of %d).\n', fullFileName, k, numFiles);
	% Now do whatever you want with this file name,
	% such as reading it in as an image array with imread()
    
    a = imread(fullFileName)
    
    [rows, columns, numberOfColorChannels] = size(a);
    if numberOfColorChannels < 3
      continue;
    end
    
    b = rgb2gray(a)
    imageArray = imbinarize(b, 0.3)
    
    
	% Write it out as a PNG file.
	baseFileName = strrep(lower(baseFileName), '.jpg', '.png');
	outputFileName = fullfile(myFolder, baseFileName)
	fprintf(1, 'Now writing %s\n', outputFileName);
 	imwrite(imageArray, outputFileName);
end
