# - --------------------------------------------------------------------
# Planetary Motion using Runge Kutta Method
# - --------------------------------------------------------------------
clc;
clear all;
# - --------------------------------------------------------------------
# Initial Values
# - --------------------------------------------------------------------
global G M;
G = 100;
M = 1;
r = 10;
slope = G * M / (4 * pi ** 2);
e0 = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7]; #eccentricities for different trajectories
T = 2800; #time
dt = 0.05; #Step size
time = 0:dt:(T - 1) * dt;
hold on;
# - --------------------------------------------------------------------
# RK Method to solve the equations
# - --------------------------------------------------------------------

for e = 1:8
    x(1) = r;
    y(1) = 0;
    vx(1) = 0;
    vy(1) = sqrt((e0(e) + 1) * G * M / r);

    function f = Fx(t, x, y, vx, vy)
        global G M;
        r = sqrt(x ** 2 + y ** 2);
        f = -G * M * x / r ** 3;
    endfunction

    function f = Fy(t, x, y, vx, vy)
        global G M;
        r = sqrt(x ** 2 + y ** 2);
        f = -G * M * y / r ** 3;
    endfunction

    for t = 1:T - 1

        dx1 = dt * vx(t);
        dy1 = dt * vy(t);

        dvx1 = dt * Fx(t * dt, x(t), y(t), vx(t), vy(t));
        dvy1 = dt * Fy(t * dt, x(t), y(t), vx(t), vy(t));

        dx2 = dt * (vx(t) + dvx1 / 2);
        dy2 = dt * (vy(t) + dvy1 / 2);

        dvx2 = dt * Fx(t * dt + dt / 2, x(t) + dx1 / 2, y(t) + dy1 / 2, vx(t) + dvx1 / 2, vy(t) + dvy1 / 2);
        dvy2 = dt * Fy(t * dt + dt / 2, x(t) + dx1 / 2, y(t) + dy1 / 2, vx(t) + dvx1 / 2, vy(t) + dvy1 / 2);

        dx3 = dt * (vx(t) + dvx2 / 2);
        dy3 = dt * (vy(t) + dvy2 / 2);

        dvx3 = dt * Fx(t * dt + dt / 2, x(t) + dx2 / 2, y(t) + dy2 / 2, vx(t) + dvx2 / 2, vy(t) + dvy2 / 2);
        dvy3 = dt * Fy(t * dt + dt / 2, x(t) + dx2 / 2, y(t) + dy2 / 2, vx(t) + dvx2 / 2, vy(t) + dvy2 / 2);

        dx4 = dt * (vx(t) + dvx3);
        dy4 = dt * (vy(t) + dvy3);

        dvx4 = dt * Fx(t * dt + dt, x(t) + dx3, y(t) + dy3, vx(t) + dvx3, vy(t) + dvy3);
        dvy4 = dt * Fy(t * dt + dt, x(t) + dx3, y(t) + dy3, vx(t) + dvx3, vy(t) + dvy3);

        dx = (dx1 + 2 * dx2 + 2 * dx3 + dx4) / 6;
        dy = (dy1 + 2 * dy2 + 2 * dy3 + dy4) / 6;
        dvx = (dvx1 + 2 * dvx2 + 2 * dvx3 + dvx4) / 6;
        dvy = (dvy1 + 2 * dvy2 + 2 * dvy3 + dvy4) / 6;

        x(t + 1) = x(t) + dx;
        y(t + 1) = y(t) + dy;
        vx(t + 1) = vx(t) + dvx;
        vy(t + 1) = vy(t) + dvy;
    endfor

    for i = 2:T - 1

        if ((sign(y(i + 1)) ~= sign(y(i))) && (x(i) > 0))
            Tmp(e) = (2 * i - 1) * dt / 2;
            break;
        endif

    endfor

    for i = 2:T - 1

        if (sign(y(i + 1)) ~= sign(y(i)))
            A(e) = (r - (x(i + 1) + x(i)) / 2) / 2;
            break;
        endif

    endfor

    # - --------------------------------------------------------------------
    # Graph Plotting::01::Trajectories
    # - --------------------------------------------------------------------
    plot(x, y);
    grid on;
endfor

legend ({["e = " num2str(e0(1))], ["e = " num2str(e0(2))], ...
    ["e = " num2str(e0(3))], ["e = " num2str(e0(4))], ["e = "
                                    num2str(e0(5))] ...
        ["e = " num2str(e0(6))]}, "location", "southwest");

title ("Particle Trajectories", "fontsize", 18);
xlabel ("X-Coordinate", "fontsize", 15, "fontweight", "bold");
ylabel ("Y-Coordinate", "fontsize", 15, "fontweight", "bold");
# - --------------------------------------------------------------------
# Graph Plotting::02::Kepler's 3rd Law
#
figure(2);
plot(Tmp.^2, A.^3, "*-");
grid on;
title ("a^3 vs T^2 of orbits of different eccentricities", "fontsize", 18);
xlabel ("T^2", "fontsize", 15, "fontweight", "bold");
ylabel ("a^3", "fontsize", 15, "fontweight", "bold");
# - --------------------------------------------------------------------
# Results
# - --------------------------------------------------------------------
disp("---------------------------------------------------------------")
disp(" Results ")
disp("---------------------------------------------------------------")
slope2 = diff(A.^3) ./ diff(Tmp.^2);
avg = (slope2(1) + slope2(2) + slope2(3) + slope2(4) + slope2(5) + slope2(6) + slope2
(7)) / 7;
disp(["Calculated slope of a^3 vs T^2 = " num2str(slope) " (i.e.,GM / 4pi^2)"
    "\nMeasured slope = " num2str(avg)]);
# - --------------------------------------------------------------------
# END of Program
# - --------------------------------------------------------------------
