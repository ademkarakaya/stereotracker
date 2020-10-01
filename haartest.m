%%% Test code for running CPU and GPU Haar Cascade implementations



clear all
close all

image = imread('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Capstone_Matlab_Files\Calibration_Photos\Damian-c1.png');
image2 = imread('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Capstone_Matlab_Files\Calibration_Photos\Damian-c2.png');
tic
a = extractEyesOCV(image);
toc
tic
b = extractEyesOCV(image2);
toc






[point,extract] = extractEyesOCVPoints(image);
[point2,extract2] = extractEyesOCVPoints(image2);


eye1 = imcrop(image,[point(1,1) point(2,1) point(3,1) point(4,1)]);
eye2 = imcrop(image,[point(1,2) point(2,2) point(3,2) point(4,2)]);
eye3 = imcrop(image2,[point2(1,1) point2(2,1) point2(3,1) point2(4,1)]);
eye4 = imcrop(image2,[point2(1,2) point2(2,2) point2(3,2) point2(4,2)]);

figure(1)
subplot(1,2,1)
imshow(extract)
subplot(1,2,2)
imshow(extract2)

figure(2)
subplot(2,2,1)
imshow(eye1)
subplot(2,2,2)
imshow(eye2)
subplot(2,2,3)
imshow(eye3)
subplot(2,2,4)
imshow(eye4)


