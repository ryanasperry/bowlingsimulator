function [x, y] = plot_circle(pos, r)
th = 0:pi/50:2*pi;
x = r * cos(th) + pos(1);
y = r * sin(th) + pos(2);
end