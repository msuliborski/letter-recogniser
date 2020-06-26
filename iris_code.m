function iris_ex()
%IRIS_DATASET Summary of this function goes here
%   Detailed explanation goes here

clear;

% Load the dataset
load iris_dataset;
load fisheriris;
clear meas;
species = species';

% Shows simplified graphics (3D) with the distribution of examples
idx_setosa = strcmp(species, 'setosa');
idx_virginica = strcmp(species, 'virginica');
idx_versicolor = strcmp(species, 'versicolor');
setosa = irisInputs([1:3], idx_setosa);
virgin = irisInputs([1:3], idx_virginica);
versi = irisInputs([1:3], idx_versicolor);
scatter3(setosa(1,:), setosa(2,:),setosa(3,:));
hold on;
scatter3(virgin(1,:), virgin(2,:),virgin(3,:), 'rs');
scatter3(versi(1,:), virgin(2,:),versi(3,:), 'gx');
legend('setosa', 'virginica', 'versicolor')
grid on
rotate3d on


% CREATE AND CONFIGURE THE NEURONAL NETWORK
% INDICATE: N? hidden layers and us by hidden layer
% TO INDICATE: Training facility: {'trainlm', 'trainbfg', traingd'}
% INDICATE: Activation functions of the hidden layers and output: {'purelin', 'logsig', 'tansig' }
% INDICATE: Dividing examples by training, validation and testing sets

net = feedforwardnet;

% COMPLETE THE REMAINING CONFIGURATION




% TRAIN
[net,tr] = train(net, irisInputs, irisTargets);
view(net);
disp(tr)
% SIMULATE
out = sim(net, irisInputs);


% VIEW PERFORMANCE

plotconfusion(irisTargets, out) % Matriz de confusao

plotperf(tr)         % Graphic with the network performance in the 3 sets           


% Calculates and shows the percentage of correct classifications in the total of examples
r=0;
for i=1:size(out,2)               % For each classification 
  [a b] = max(out(:,i));          % b holds the line where you found the highest value of the output obtained
  [c d] = max(irisTargets(:,i));  % d guards the line where you found the highest value of the desired exit
  if b == d                       % if they are on the same line, the classification was correct (increment 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %f\n', accuracy)


% SIMULATE THE NETWORK IN THE TEST SET ONLY
TInput = irisInputs(:, tr.testInd);
TTargets = irisTargets(:, tr.testInd);

out = sim(net, TInput);


%Calculates and shows the percentage of correct grades in the test set
r=0;
for i=1:size(tr.testInd,2)               %  For each classification 
  [a b] = max(out(:,i));          % b holds the line where you found the highest value of the output obtained
  [c d] = max(TTargets(:,i));  %d guards the line where you found the highest value of the desired exit
  if b == d                       % if they are on the same line, the classification was correct (increment 1)
      r = r+1;
  end
end
accuracy = r/size(tr.testInd,2)*100;
fprintf('Precisao teste %f\n', accuracy)


end

