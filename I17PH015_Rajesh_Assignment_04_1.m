% Clear the output window and suppress any warning statements
clc
warning('off', 'all');
%------------------------------------------------------------------------
% Begin the program
%------------------------------------------------------------------------
disp("This program is a simulation of particle in a 1D box problem by Rajesh Kumar Das(I17PH015)")
pause(1)
%------------------------------------------------------------------------
% take the inputs from the user
%------------------------------------------------------------------------
L = input('Enter the box length: ');
x0 = input('Enter the initial position of the particle: ');
v0 = input('Enter the initial velocity of the particle: ');
T = input('Enter the time period: ');
%------------------------------------------------------------------------
% Define the values of variables
%------------------------------------------------------------------------
t = 0;
dt = 0.1;
x = x0;
v = v0;
i = 1;
counter = 0;
%------------------------------------------------------------------------
% Invoke the loop to register the position of the particle baesd on the conditions
%------------------------------------------------------------------------
while t <= T
    t = i * dt;
    xm(i) = x; % to store the values of x
    x = x + v * dt; % to determine the position of the particle

    if (x <= 0 || x >= L)% condition to keep the particle in 1D box
        v = -v;
        counter = counter + 1;
    endif

    i++;
endwhile

%------------------------------------------------------------------------
% To display the number of reflections
%------------------------------------------------------------------------
disp("The total number of collisions in the given time is:")
counter
%------------------------------------------------------------------------
% To draw the boundary lines
%------------------------------------------------------------------------
xl1 = linspace(0, 0, 100);
yl1 = linspace(0, L, 100);
xl2 = linspace(L, L, 100);
yl2 = linspace(0, L, 100);
figure;
hold on
%------------------------------------------------------------------------
% Setting the x and y limit of the plot
%------------------------------------------------------------------------
x_lo = -1;
x_hi = L + 1;
y_lo = -1;
y_hi = L + 1;
%------------------------------------------------------------------------
% Plotting the graph
%------------------------------------------------------------------------
for i = 1:i - 1
    p = plot(xm(i), L / 2, ":o-r"); % plot of the particle
    plot(xl1, yl1, "k"); % plot of the boundary line
    plot(xl2, yl2, "k"); % plot of the boundary line
    axis equal
    axis square
    grid on
    axis ([x_lo x_hi y_lo y_hi])
    xlabel ("X");
    ylabel ("Potential");
    title("One Dimensional Box")
    pause(0.002);
    delete(p);
endfor
