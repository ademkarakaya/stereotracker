%main function

%haar cascade information for bounding box
%all arrays will of length 4, for  2 sets of eyes
%top left corner point

box_x = coords(1,:);
box_y = coords(2,:);
width = coords(3,:);
height = coords(4,:);

%calibration information
O_x = zeros(4,1);
O_y = zeros(4,1);

%eyeball radius measurement
r = 23; %mm

%distance of eyes from the screen
d = 400; %mm

r_iris_cal = zeros(4,1);

%test for calibration image

video = VideoReader('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\images_and_videos\6-OCT footage\10s_Footage.mp4');

I_calibration = read(video,1);
res = I_calibration;

tic
parfor i = 1:4
    I_new_crop = imcrop(I_calibration,[box_x(i),box_y(i),width(i),height(i)]);
    I_cal_bw = rgb2gray(I_new_crop);
    %testing gaussian filter
    I_cal_bw = imgaussfilt(I_cal_bw,0.5);
    %imshow(I_cal_bw);
    
    [ciris,~,~] = thresh(I_cal_bw, 20, 25);
    
    r_iris_cal(i) = ciris(3);
    %figure(1)
    %subplot(2,2,i);
    %imshow(boundim);
    %title(['Calibration Eye: ',num2str(i)])
    O_x(i) = ciris(2)+box_x(i);
    O_y(i) = ciris(1)+box_y(i);
end
toc

for i = 1:4
    res = insertShape(res,"Circle",[O_x(i), O_y(i) r_iris_cal(i)],"Color","yellow");
end

figure(1)
imshow(res);

%New point
x_new = zeros(4,1);
y_new = zeros(4,1);

x_screen = zeros(4,1);
y_screen = zeros(4,1);

I_new = read(video,200);
r_iris_new = zeros(4,1);

tic
parfor (i = 1:4)
    I_new_crop = imcrop(I_new,[box_x(i),box_y(i),width(i),height(i)]);
    I_new_crop_bw = rgb2gray(I_new_crop);
    I_new_crop_bw = imgaussfilt(I_new_crop_bw,0.5);
    [ciris,~,~] = thresh(I_new_crop_bw, 20, 25);
    %figure(2);
    %subplot(2,2,i);
    %imshow(edge(boundim,'canny'));
    %title(['Current Frame Eye: ',um2str(i)])
    x_new(i) = ciris(2)+box_x(i);
    y_new(i) = ciris(1)+box_y(i);
    
    r_iris_new(i) = ciris(3);
    [x_screen(i),y_screen(i)] = gaze_estimation(O_x(i),O_y(i),x_new(i),y_new(i),r,d);
end
toc

