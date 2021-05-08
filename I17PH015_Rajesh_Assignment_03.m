% Clear the output window and supress any warning statements
clc
warning('off', 'all');
%-----------------------------------------------------------------------------
% Program starts from here
%-----------------------------------------------------------------------------

disp("This program is a simulation of Young double slit experiment by Rajesh Kumar Das(I17PH015)")
pause(1)

%-----------------------------------------------------------------------------
% Take inputs form the user (wavelength, slit width and distance from the screen)
%-----------------------------------------------------------------------------

l = input('Enter wavelength of the light (in nm): ');
l = l * 10^(-9); %Convert nm to m
d = input('Enter slit width (in mm): ');
d = d * 10^(-3); %Convert mm to m
D = input('Enter the distance from the screen (in m): ');

%-----------------------------------------------------------------------------
% Determing the x and y limit for the graph  
%-----------------------------------------------------------------------------

ylimit = 5*l*D/d; % y-axis limit
xlimit = 10*ylimit; % x-axis limit
xn = 250; % number of points along x-axis
yn = 250; % number of points along y-axis
xScreen = linspace(-xlimit,xlimit,xn);
yScreen = linspace(-ylimit,ylimit,yn);

%-----------------------------------------------------------------------------
% Determing the value of individual point
%-----------------------------------------------------------------------------

for i = 1:yn
    for j = 1:xn
        % Distance from the bottom slit
        L1 = sqrt(xScreen(j)^2 + (yScreen(i)-d/2)^2 + D^2);
        % Distance from the top slit
        L2 = sqrt(xScreen(j)^2 + (yScreen(i)+d/2)^2 + D^2); 
        % Calculate the phase difference from the path difference
        Phi = 2*pi*(L2-L1)/l;
        % Let's assume intensity of both the lights to be the same
        Intensity(i,j) = 4*cos(Phi/2)^2;
    end
end

%-----------------------------------------------------------------------------
% Plotting the output 
%-----------------------------------------------------------------------------

% Number of gray levels to use
NGrayLevels = 255;
% Rescale intensity to adjust max with white color
IntenGray = (Intensity/4.0)*NGrayLevels;
% Plot the image
image(xScreen,yScreen,IntenGray);
colormap(gray(NGrayLevels));
xlabel('x (m)');
ylabel('y (m)');
title('Interference pattern on the screen');