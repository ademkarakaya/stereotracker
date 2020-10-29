function [x, y] = gaze_estimation(O_x, O_y, eye_x, eye_y,r,d)

 

%gaze estimation using 3D eyeball model
%radius of eye assumption (between 22 and 24 mm)
%need to create an inbetween function to create image

 

%calibration points
%O_x is x reference point 
%O_y is y reference point

 

%current coordinates of iris centre
%eye_x is current x point
%eye_y is current y point

 

%difference between origin and new iris centre
diff_x = 0.294*(eye_x - O_x); %convert pixel to mm
diff_y = 0.294*(eye_y - O_y); %convert pixel to mm

 

%angle calculations
beta = asin(diff_y./r);
alpha = asin(diff_x./(r.*cos(beta)));

 

%estimated point on screen
x = (d+r).*tan(alpha);
y = (d+r).*sec(alpha).*tan(beta);