# - --------------------------------------------------------------------
# Planetary Motion using Runge Kutta Method
# - --------------------------------------------------------------------
clc;
clear all;
# - --------------------------------------------------------------------
# Initial Values
# - --------------------------------------------------------------------
global G M;
#G = 6.67408 * 10 ** -11;
#M = 1.989 * 10 ** 30;
G = 100;
M = 1;
r = 10;
T = 1200;
dt = 0.05;
time = 0:dt:(T - 1) * dt;
clf;
hold on;
e0(1) = -0.85;
e = 1;
x(1) = r;
y(1) = 0;
vx(1) = -2;
vy(1) = sqrt((e0(e) + 1) * G * M / r);
# - --------------------------------------------------------------------
# RK Method to solve the equations
# - --------------------------------------------------------------------

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

# - --------------------------------------------------------------------
# Animation
# - --------------------------------------------------------------------
title ("Spiral Motion of particle moving under influence of centeral force", "fontsize", 15);
comet(x, y);
# - --------------------------------------------------------------------
# END of Program
# - --------------------------------------------------------------------
