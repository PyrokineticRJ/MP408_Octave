% Clear the output window and supress any warning statements
clc
warning('off', 'all');
%------------------------------------------------------------------------
% Begin the program
%------------------------------------------------------------------------
disp("This program is a simulation of various 2-D motion problems by Rajesh Kumar Das(I17PH015)")
pause(1)
disp("1. Time Parameterized 2D Motion")
disp("2. Circular Motion")
disp("3. Simple Pendulum")
disp("4. Projectile Motion")

choice = input(disp("Which program you want to execute?\n"));

switch (choice)

        %------------------------------------------------------------------------
        % Plotting the graph of particle in 2D
        %------------------------------------------------------------------------
    case 1
        % Taking values from the user
        x0 = input(disp("Enter the initial position along X: "));
        y0 = input(disp("Enter the initial position along Y: "));
        vx = input(disp("Enter the initial velocity along X: "));
        vy = input(disp("Enter the initial velocity along Y: "));
        ax = input(disp("Enter the initial acceleration along X: "));
        ay = input(disp("Enter the initial acceleration along Y: "));
        tf = input(disp("Enter the total time: "));

        % Initilize the time range
        t0 = 0
        dt = 0.1
        t = t0:dt:tf;

        % Parametric equation of position in terms of time
        x = x0 + vx * t + 0.5 * ax * t.^2;
        y = y0 + vy * t + 0.5 * ay * t.^2;

        % Plotting the graph
        for i = 1:length(t)
            plot(x(i), y(i), ":o");
            axis equal
            axis square
            grid on
            xlabel ("X");
            ylabel ("Y");
            xlim ("auto");
            ylim("auto");
            title("Change in position of particle with time")
            hold on;
            pause (0.002);
        endfor

        %------------------------------------------------------------------------
        % Plotting the graph of circular motion
        %------------------------------------------------------------------------
    case 2
        % Taking values from the user
        x0 = input(disp("Enter the initial position along X: "));
        y0 = input(disp("Enter the initial position along Y: "));
        r = input(disp("Enter the radius: "));
        tf = input(disp("Enter the total time: "));
        w = input(disp("Enter the angular frequency: "));

        % Initilize the time range
        t0 = 0
        dt = 0.1
        t = t0:dt:tf;

        % Parametric equation of position in terms of time
        x = x0 + r * cos(w * t);
        y = y0 + r * sin(w * t);

        % Setting the x and y limit of the plot
        x_lo = x0 - r - 1
        x_hi = x0 + r + 1
        y_lo = y0 - r - 1
        y_hi = y0 + r + 1

        % Plotting the graph
        for i = 1:length(t)
            plot(x(i), y(i), ":o");
            axis equal
            axis square
            grid on
            xlabel ("X");
            ylabel ("Y");
            axis ([x_lo x_hi y_lo y_hi])
            title("Circular Motion")
            hold on;
            pause (0.002);
        endfor

        %------------------------------------------------------------------------
        % Plotting the graph of pendulum
        %------------------------------------------------------------------------
    case 3
        % Taking values from the user
        x0 = input(disp("Enter the initial position along X: "));
        y0 = input(disp("Enter the initial position along Y: "));
        r = input(disp("Enter the length: "));
        theta0 = (pi / 180) * input(disp("Enter the angle in degree: "));
        tf = input(disp("Enter the total time: "));

        % Initilize the time range
        dt = 0.1;
        t0 = 0;
        t = t0:dt:tf;

        % Initilize the parameters
        T = 2 * pi * sqrt(r / 9.8);
        w = 2 * pi / T;
        theta = theta0 * cos(t * w);

        % Parametric equation of position in terms of time
        x = x0 + r * sin(theta);
        y = y0 - r * cos(theta);

        % Setting the x and y limit of the plot
        x_lo = x0 - r * sin(theta0) - 1
        x_hi = x0 + r * sin(theta0) + 1
        y_lo = y0 - r - 1
        y_hi = y0 + 1

        % Plotting the graph
        for i = 1:length(t)
            plot(x(i), y(i), ":o-k");
            plot(x0, y0, ":o-r");
            axis equal
            axis square
            grid on
            xlabel ("X");
            ylabel ("Y");
            axis ([x_lo x_hi y_lo y_hi])
            title("Simple Pendulum")
            hold on;
            pause (0.002);
        endfor

        %------------------------------------------------------------------------
        % Plotting the graph of projectile motion
        %------------------------------------------------------------------------
    case 4

        % Taking values from the user
        x0 = input(disp("Enter the initial position along X: "));
        y0 = input(disp("Enter the initial position along Y: "));
        u = input(disp("Enter the initial velocity: "));
        theta = (pi / 180) * input(disp("Enter the angle in degree: "))

        % Initilize the time range
        T = 2 * u * sin(theta) / 9.8;
        dt = 0.1;
        t0 = 0;
        t = t0:dt:T;

        % Parametric equation of position in terms of time
        x = x0 + u * cos(theta) * t;
        y = y0 + u * sin(theta) * t - 0.5 * 9.8 * t.^2;

        % Plotting the graph
        for i = 1:length(t)
            plot(x(i), y(i), ":o");
            axis equal
            axis square
            grid on
            xlabel ("X");
            ylabel ("Y");
            xlim ("auto");
            ylim("auto");
            title("Projectile Motion")
            hold on;
            pause (0.002);
        endfor

        %------------------------------------------------------------------------
    otherwise
        disp("Error in input. Exiting...")
        exit
endswitch
