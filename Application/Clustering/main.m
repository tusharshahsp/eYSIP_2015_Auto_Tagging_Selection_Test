
% Main program that performs clustering on data based on features.csv
% file obtained after feature extraction

close all;
clear;
clc;

% Read features.csv
fprintf("\n\nReading data...\n");
inputData = csvread('features.csv');
fprintf("Data Read.\n");

% Segregate the data
question_id = inputData(:, 1);	% First column is question id
X = inputData(:, 2:8);	% Next 7 columns contain features
y = inputData(:, 9);	% Last column contains current question tag

% Some useful variables
m = size(X, 1);	% Number of training examples

% Perform mean normalization
fprintf("\n\nPerforming Mean Normalization...\n");
meanX = mean(X);	% Mean of all the features
stdX = std(X);	% Standard deviation of all the features
X = (X - meanX) ./ stdX;
X = X(:, [2, 7]);	% Uncomment this line to use selected features
fprintf("Mean Normalization Done.\n");

% Use PCA to obtain XReduced for Plotting Purposes
fprintf("\n\nRunning PCA...\n");
XReduce = pca(X, m);
fprintf("PCA Completed.\n");

% Visualize the initial data
fprintf("\n\nVisualizing initial data...\n");
plotData(XReduce, y .+ 1, m);
fprintf("Visualization done. Press any key to continue.\n");
pause;

% Perform Clustering on Data
fprintf("\n\nRunning k-Means clustering...\n");
fflush(stdout);
[centroids, labels] = cluster(X, 50, 3);
fprintf("Clustering Completed.\n");

% Assign Semantics
fprintf("\n\nAssigning Semantics...\n");
[labels, map] = assignSemanticsNew(centroids, labels);	% Change this to assignSemantics if using all features
fprintf("Semantics Assigned.\n");

% Show Manual Tagging Accuracy
accuracy = (sum((y == labels)(:)) * 100) / m;
fprintf("\n\nManual Tagging Accuracy = %f percent\n", accuracy);

% Visualize Final Data
fprintf("\n\nVisualizing final data...\n");
plotData(XReduce, labels .+ 1, m);
fprintf("Visualization done. Press any key to continue.\n\n\n");
pause;

