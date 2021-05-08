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

function ret = fxt(x, t, vx0, k)
    func = vx0 .* exp(-k .* t);
    ret = func;
endfunction

function ret = fyt(y, t, vy0, k)
    func = (vy0 + 9.8 ./ k) .* exp(-k .* t) - 9.8 ./ k;
    ret = func;
endfunction

figure();
k = 50;

while k > 0.4
    x = x0;
    y = y0;
    t = 0;
    xm = [];
    ym = [];
    tm = [];
    i = 1;

    for i = 1:T
        xm(i) = x;
        ym(i) = y;
        tm(i) = t;
        % for x
        k1x = fxt(x, t, vx0, k);
        k2x = fxt((x + h ./ 2), (t + h .* k1x ./ 2), vx0, k);
        k3x = fxt((x + h ./ 2), (t + h .* k2x ./ 2), vx0, k);
        k4x = fxt((x + h), (t + h .* k3x), vx0, k);
        x = x + h .* (k1x + 2 .* k2x + 2 .* k3x + k4x) ./ 6;
        % for y
        k1y = fyt(x, t, vy0, k);
        k2y = fyt((x + h ./ 2), (t + h .* k1y ./ 2), vy0, k);
        k3y = fyt((x + h ./ 2), (t + h .* k2y ./ 2), vy0, k);
        k4y = fyt((x + h), (t + h .* k3y), vy0, k);
        y = y + h .* (k1y + 2 .* k2y + 2 .* k3y + k4y) ./ 6;
        % for t
        t = t + h;

    endfor

    plot(xm, ym);
    ylim ([0 max(ym)])
    grid on;
    title("y vs x")
    xlabel("x")
    ylabel("y")
    hold on;

    k = k / 2;
endwhile
