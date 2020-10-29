%%% Test code for running Haar Cascade implementations



clear all
close all

video = VideoReader('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\images_and_videos\6-OCT footage\Footage_80_1.mp4');
frameno = 81;

image = read(video,frameno);

%image = imread('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\stereotracker\test_centre.png');

tic
[coords,extract] = extractEyesOCVPoints(image);
toc


eye1 = imcrop(image,[coords(1,1) coords(2,1) coords(3,1) coords(4,1)]);
eye2 = imcrop(image,[coords(1,2) coords(2,2) coords(3,2) coords(4,2)]);
eye3 = imcrop(image,[coords(1,3) coords(2,3) coords(3,3) coords(4,3)]);
eye4 = imcrop(image,[coords(1,4) coords(2,4) coords(3,4) coords(4,4)]);

figure(1)
imshow(extract)


figure(2)
subplot(2,2,1)
imshow(eye1)
subplot(2,2,2)
imshow(eye2)
subplot(2,2,3)
imshow(eye3)
subplot(2,2,4)
imshow(eye4)

imwrite(extract,'result.png');
imwrite(eye1,'Reye1.png');
imwrite(eye2,'Reye2.png');
imwrite(eye3,'Reye3.png');
imwrite(eye4,'Reye4.png');
save('Rcoords.mat','coords');
writematrix(coords,'Rcoords.txt');
