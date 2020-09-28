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
figure(1)
subplot(1,2,1)
imshow(a)
subplot(1,2,2)
imshow(b)