%%% Test code for running CPU and GPU Haar Cascade implementations

clear all
close all

image = imread('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Capstone_Matlab_Files\Calibration_Photos\Damian-c1.png');
image2 = imread('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Capstone_Matlab_Files\Calibration_Photos\Damian-c2.png');
imGPU1 = gpuArray(rgb2gray(image));
imGPU2 = gpuArray(image2);

tic
a = extractEyesOCV(imGPU1);
toc
tic
b = extractEyesOCV(imGPU2);
toc
figure(1)
subplot(1,2,1)
imshow(a)
subplot(1,2,2)
imshow(b)