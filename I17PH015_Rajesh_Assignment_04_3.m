% Clear the output window and suppress any warning statements
clc
warning('off', 'all');
%------------------------------------------------------------------------
% Begin the program
%------------------------------------------------------------------------
disp("This program is a simulation of particle in a carrom board problem by Rajesh Kumar Das(I17PH015)")
pause(1)
%------------------------------------------------------------------------
% take the inputs from the user
%------------------------------------------------------------------------
L = input('Enter the box length: ');
x0 = input('Enter the initial position of the particle along x: ');
y0 = input('Enter the initial position of the particle along y: ');
v0 = input('Enter the initial velocity of the particle: ');
r = input('Enter the radius of the holes:');
theta = (pi / 180) * input('Enter the angle: ');
T = input('Enter the time period: ');
%------------------------------------------------------------------------
% Define the values of variables
%------------------------------------------------------------------------
t = 0;
dt = 0.1;
x = x0;
y = y0;
v = v0;
i = 1;
vx = v0 * cos(theta);
vy = v0 * sin(theta);
counter = 0;
%------------------------------------------------------------------------
% Invoke the loop to register the position of the particle baesd on the conditions
%------------------------------------------------------------------------
while t <= T
    t = i * dt;
    xm(i) = x; % to store the values of x
    ym(i) = y; % to store the values of y
    x = x + vx * dt; % to determine the position of the particle alogn x
    y = y + vy * dt; % to determine the position of the particle along y

    if (x <= 0 || x >= L)% condition to keep the particle in 2D box along x
        vx = -vx;
        counter = counter + 1;

    endif

    if (y <= 0 || y >= L)% condition to keep the particle in 2D box along y
        vy = -vy;
        counter = counter + 1;

    endif

    if (x^2 + y^2 <= r^2 || (x - L)^2 + y^2 <= r^2 || x^2 + (y - L)^2 <= r^2 || (x - L)^2 + (y - L)^2 <= r^2)
        break;
    endif

    i++;
endwhile

%------------------------------------------------------------------------
% To display the number of relfections
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
xl3 = linspace(0, L, 100);
yl3 = linspace(0, 0, 100);
xl4 = linspace(0, L, 100);
yl4 = linspace(L, L, 100);
figure;
hold on;
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
    p = plot(xm(i), ym(i), ":o-r"); % plot of the particle
    plot(xl1, yl1, "k"); % plot of the boundary line
    plot(xl2, yl2, "k"); % plot of the boundary line
    plot(xl3, yl3, "k"); % plot of the boundary line
    plot(xl4, yl4, "k"); % plot of the boundary line
    axis equal;
    axis square;
    grid on;
    axis ([x_lo x_hi y_lo y_hi]);
    xlabel ("X");
    ylabel ("Y");
    title("Carrom Board")
    pause(0.002);
    delete(p);
endfor
