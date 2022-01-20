% ********************** ****************
% For Deliverable 1
% Student Name: Chintan Jayeshkumar Kharadi
% Subject: Simulation and Modeling SYSC5001
% Student ID Number: 101169771
% Date: 05-02-2020
% This file is written to find Normal, Exponential distribution of Inspector
% 2's inspection time for component 2 and 3
%*****************************************

clear all;
close all;
% load the data of inspection time for component 2;find mean and
% variance
randomDataforC2 = load('servinsp22.dat');
meanC2 = mean(randomDataforC2);
varianceC2 = var(randomDataforC2);
minimumC2=min(randomDataforC2);
maximumC2=max(randomDataforC2);
xC2 = minimumC2:0.5:maximumC2;
yC2 = exppdf(xC2,meanC2); %Generating exponential distribution
ypdfC2 = pdf('Normal',xC2,meanC2,varianceC2);
tiledlayout(2,2)
nexttile
plot(xC2,yC2)
title('Exponential Distribution for Component 2')
nexttile
plot(xC2,ypdfC2)
title('Normal Distribution of Component 2')

% load the data of inspection time for component 3;find mean and
% variance
randomDataforC3 = load('servinsp23.dat');
meanC3 = mean(randomDataforC3);
varianceC3 = var(randomDataforC3);
minimumC3=min(randomDataforC3);
maximumC3=max(randomDataforC3);
xC3 = minimumC3:0.5:maximumC3;
yC3 = exppdf(xC3,meanC3); %Generating exponentail distribution
ypdfC3 = pdf('Normal',xC3,meanC3,varianceC3);
%plot the exponential distribution for c3
nexttile
plot(xC3,yC3)
title('Exponential Distribution For Component 3')
nexttile
plot(xC3,ypdfC3)
title('Normal Distribution of For Component 3')