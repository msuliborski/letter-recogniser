clear;
% A section

%read A file
matrixA = [1 0 0 0 0]
matrixE = [0 1 0 0 0]
matrixI = [0 0 1 0 0]
matrixO = [0 0 0 1 0]
matrixU = [0 0 0 0 1]


my_imgA = []
my_imgE = []
my_imgI = []
my_imgO = []
my_imgU = []
images = []

my_imgA_set_2 = []
my_imgE_set_2 = []
my_imgI_set_2 = []
my_imgO_set_2 = []
my_imgU_set_2 = []

targetA = []
targetE = []
targetI = []
targetO = []
targetU = []

targetA_set_2 = []
targetE_set_2 = []
targetI_set_2 = []
targetO_set_2 = []
targetU_set_2 = []

myDir = 'set_1/A/*.png';
myDirAlone = 'set_1/A/'
a = dir([myDir]);
nfile = max(size(a)) ;

for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  %my_imgA(:,:,i) = imread([myDirAlone a(i).name]);
  my_imgA(:,end+1) = OneDArray;
  targetA(:,end+1) = matrixA;
end

%read E file
myDir = 'set_1/E/*.png';
myDirAlone = 'set_1/E/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  %my_imgE(:,:,i) = imread([myDirAlone a(i).name]);
  my_imgE(:,end+1) = OneDArray;
  targetE(:,end+1) = matrixE;
end

%read I file
myDir = 'set_1/I/*.png';
myDirAlone = 'set_1/I/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
 % my_imgI(:,:,i) = imread([myDirAlone a(i).name]);
  my_imgI(:,end+1) = OneDArray;
  targetI(:,end+1) = matrixI;
end

%read O file
myDir = 'set_1/O/*.png';
myDirAlone = 'set_1/O/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  my_imgO(:,end+1) = OneDArray;
  targetO(:,end+1) = matrixO;
end

%read U file
myDir = 'set_1/U/*.png';
myDirAlone = 'set_1/U/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  my_imgU(:,end+1)= OneDArray;
  targetU(:,end+1) = matrixU;
end

images = [my_imgA my_imgE my_imgI my_imgO my_imgU]
targets = [targetA targetE targetI targetO targetU]
net = feedforwardnet([10])
net.trainFcn = 'trainlm'

net.layers{1}.transferFcn = 'purelin';

class(images(1))

[net, tr] = train(net, images, targets);
view(net);
disp(tr);

out = sim(net, images)
%plotconfusion(images, out)

% Calculates and shows the percentage of correct ratings in the total of examples
r=0;
for i=1:size(out,2)                   % For each classification                      
  [a b] = max(out(:,i))               % b stores the line where to find the highest value of the obtained output
  [c d] = max(targets(:,i))           % d stores the line where it found the highest value of the desired output
  if b == d                           % if they are on the same line, the classification was correct (increments 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100
fprintf('Precisao total %f\n', accuracy)

% B section

myDir = 'set_2/A/*.png';
myDirAlone = 'set_2/A/'
a = dir([myDir]);
nfile = max(size(a)) ;

for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  %my_imgA(:,:,i) = imread([myDirAlone a(i).name]);
  my_imgA_set_2(:,end+1) = OneDArray;
  targetA_set_2(:,end+1) = matrixA;
end

%read E file
myDir = 'set_2/E/*.png';
myDirAlone = 'set_2/E/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  %my_imgE(:,:,i) = imread([myDirAlone a(i).name]);
  my_imgE_set_2(:,end+1) = OneDArray;
  targetE_set_2(:,end+1) = matrixE;
end

%read I file
myDir = 'set_2/I/*.png';
myDirAlone = 'set_2/I/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
 % my_imgI(:,:,i) = imread([myDirAlone a(i).name]);
  my_imgI_set_2(:,end+1) = OneDArray;
  targetI_set_2(:,end+1) = matrixI;
end

%read O file
myDir = 'set_2/O/*.png';
myDirAlone = 'set_2/O/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  my_imgO_set_2(:,end+1) = OneDArray;
  targetO_set_2(:,end+1) = matrixO;
end

%read U file
myDir = 'set_2/U/*.png';
myDirAlone = 'set_2/U/'
a = dir([myDir]);
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  my_imgU_set_2(:,end+1)= OneDArray;
  targetU_set_2(:,end+1) = matrixU;
end

images_set_2 = [my_imgA_set_2 my_imgE_set_2 my_imgI_set_2 my_imgO_set_2 my_imgU_set_2];
targets_set_2 = [targetA_set_2 targetE_set_2 targetI_set_2 targetO_set_2 targetU_set_2];

net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.70;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;

[net,tr] = train(net, images_set_2, targets_set_2);
view(net);
disp(tr)

out = sim(net, images_set_2)
%plotconfusion(images, out)

r=0;
for i=1:size(out,2)               % Para cada classificacao  
  [a b] = max(out(:,i))          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(targets_set_2(:,i))  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100
fprintf('Precision set 2 %f\n', accuracy)




%read A file
myDir = 'set_3/U/*.png';
myDirAlone = 'set_3/U/'
a = dir([myDir]);
my_imgA_set_3 = [];
targetA_set_3 = [];
nfile = max(size(a)) ; 
for i=1:nfile
  image = imread([myDirAlone a(i).name]);
  OneDArray = reshape(image',[1 size(image,1)*size(image,2)]);
  my_imgA_set_3(:,end+1)= OneDArray;
  targetA_set_3(:,end+1) = matrixU;
end

label = net( my_imgA_set_3);
outA_set_3 = sim(net,  my_imgA_set_3)

r=0;
for i=1:size(outA_set_3,2)               % Para cada classificacao  
  [a b] = max(outA_set_3(:,i))          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(targetA_set_3(:,i))  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(outA_set_3,2)*100
fprintf('Precision set 3 E case %f\n', accuracy)







