%gaze_estimation test info
clear all
close all

 

%pixel points away from origin
p = 0:25;
r = 23;
d = 400;
[x_plot, y_plot] = gaze_estimation(0,0,p,p,r,d);
%x_plot = -x_plot;
%y_plot = -y_plot;

 

figure(1)
subplot 121
plot(p,x_plot);
title('x distance vs pixel difference for 400mm distance');
xlabel('Pixel Difference');
ylabel('x distance from origin (mm)');

 

subplot 122
plot(p,y_plot);
title('y distance vs pixel difference for 400mm distance');
xlabel('Pixel Difference');
ylabel('y distance from origin (mm)');

 

figure(2)
for i = 1:length(p)
   % rectangle('Position',[-x_plot(i),-y_plot(i),2*x_plot(i),2*y_plot(i)]);
    rectangle('Position',[-x_plot(i),-y_plot(length(p)),0,2*y_plot(length(p))]);
    rectangle('Position',[-x_plot(length(p)),-y_plot(i),2*x_plot(length(p)),0]);
    rectangle('Position',[x_plot(i),-y_plot(length(p)),0,2*y_plot(length(p))]);
    rectangle('Position',[-x_plot(length(p)),y_plot(i),2*x_plot(length(p)),0]);
end
title('Discrete sectional areas for pixel difference values');
xlabel('x distance from origin (mm)');
ylabel('y distance from origin (mm)');