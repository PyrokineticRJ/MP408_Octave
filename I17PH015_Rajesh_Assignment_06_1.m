clc
warning('off', 'all');

u = input(disp("Enter the initial velocity: "));
theta = (pi ./ 180) .* input(disp("Enter the angle in degree: "));

x0 = 0;
y0 = 0;
vx0 = u .* cos(theta);
vy0 = u .* sin(theta);
v0 = sqrt(vx0^2 + vy0^2);

Tf = 2 * vy0 / 9.8;
h = 0.01;
T = Tf ./ h;

function ret = fxt(x, t, vx0)
    func = vx0;
    ret = func;
endfunction

function ret = fyt(y, t, vy0)
    func = vy0 - 9.8 .* t;
    ret = func;
endfunction

function ret = fvxt(vx, t)
    func = 0;
    ret = func;
endfunction

function ret = fvyt(vy, t)
    func = -9.8;
    ret = func;
endfunction

x = x0;
y = y0;
vx = vx0;
vy = vy0;
t = 0;

xm = [];
ym = [];
vxm = [];
vym = [];
tm = [];

i = 1;

for i = 1:T
    xm(i) = x;
    ym(i) = y;
    vxm(i) = vx;
    vym(i) = vy;
    tm(i) = t;
    % for x
    k1x = fxt(x, t, vx0);
    k2x = fxt((x + h ./ 2), (t + h .* k1x ./ 2), vx0);
    k3x = fxt((x + h ./ 2), (t + h .* k2x ./ 2), vx0);
    k4x = fxt((x + h), (t + h .* k3x), vx0);
    x = x + h .* (k1x + 2 .* k2x + 2 .* k3x + k4x) ./ 6;
    % for y
    k1y = fyt(x, t, vy0);
    k2y = fyt((x + h ./ 2), (t + h .* k1y ./ 2), vy0);
    k3y = fyt((x + h ./ 2), (t + h .* k2y ./ 2), vy0);
    k4y = fyt((x + h), (t + h .* k3y), vy0);
    y = y + h .* (k1y + 2 .* k2y + 2 .* k3y + k4y) ./ 6;
    % for vx
    k1vx = fvxt(vx, t);
    k2vx = fvxt((vx + h ./ 2), (t + h .* k1vx ./ 2));
    k3vx = fvxt((vx + h ./ 2), (t + h .* k2vx ./ 2));
    k4vx = fvxt((vx + h), (t + h .* k3vx));
    vx = vx + h .* (k1vx + 2 .* k2vx + 2 .* k3vx + k4vx) ./ 6;
    % for vy
    k1vy = fvyt(vy, t);
    k2vy = fvyt((vy + h ./ 2), (t + h .* k1vy ./ 2));
    k3vy = fvyt((vy + h ./ 2), (t + h .* k2vy ./ 2));
    k4vy = fvyt((vy + h), (t + h .* k3vy));
    vy = vy + h .* (k1vy + 2 .* k2vy + 2 .* k3vy + k4vy) ./ 6;
    % for t
    t = t + h;
endfor

subplot(2, 2, 1)
plot(tm, xm, "color", [0.3, 0.5, 1], "linewidth", 1.5);
axis([0 max(tm) 0 max(xm)])
grid on;
title("x coordinate of particle vs time", "fontsize", 18)
xlabel("Time", "fontsize", 15)
ylabel("x coordinate", "fontsize", 15)

subplot(2, 2, 2)
plot(tm, ym, "color", [0.3, 0.5, 1], "linewidth", 1.5);
axis([0 max(tm) 0 max(ym)])
grid on;
title("y coordinate of particle vs time", "fontsize", 18)
xlabel("Time", "fontsize", 15)
ylabel("y coordinate", "fontsize", 15)

subplot(2, 2, 3)
plot(tm, vxm, "color", [0.3, 0.5, 1], "linewidth", 1.5);
axis([0 max(tm)])
grid on;
title("x coordinate of velocity of particle vs time", "fontsize", 18)
xlabel("Time", "fontsize", 15)
ylabel("x coordinate of velocity", "fontsize", 15)

subplot(2, 2, 4)
plot(tm, vym, "color", [0.3, 0.5, 1], "linewidth", 1.5);
axis([0 max(tm) min(vym) max(vym)])
grid on;
title("y coordinate of velocity of particle vs time", "fontsize", 18)
xlabel("Time", "fontsize", 15)
ylabel("y coordinate of velocity", "fontsize", 15)
