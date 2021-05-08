% Clear the output window and suppress any warning statements
clc
warning('off', 'all');
%-----------------------------------------------------------------------------
% Begin the program
%-----------------------------------------------------------------------------
disp("This program is a simulation a gravitational waves of a pulsating body by Rajesh Kumar Das(I17PH015)")
pause(1)
%-----------------------------------------------------------------------------
% Define the values of variables
%-----------------------------------------------------------------------------
x = linspace(-50, 50, 200);
y = linspace(-50, 50, 200);
k = 0.1;
count = 1;
f = 0.1;
%-----------------------------------------------------------------------------
% Determing the value of individual point
%-----------------------------------------------------------------------------
[X, Y] = meshgrid(x, y);
R = sqrt(X.^2 + Y.^2);
%-----------------------------------------------------------------------------
% Plotting the graph
%-----------------------------------------------------------------------------
while f <= 2 * pi
    Z = sin((2 * pi - f) * k * R);
    surf(X, Y, Z, 'facecolor', 'b', 'edgecolor', 'k');
    hold on
    [a, b, c] = sphere(20);
    surf(a * 5, b * 5, c * 5 + 8, 'facecolor', 'r', 'edgecolor', 'w');
    axis equal;
    pause(0.01)
    hold off;
    M(count) = getframe;
    count = count + 1;
    f = f + 0.1;
endwhile
