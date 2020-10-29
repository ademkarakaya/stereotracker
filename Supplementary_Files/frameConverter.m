%%% Converts video to frames in 3840 x 1080

clc;
clear all;
close all;
tic;

Folder1 = 'D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Capstone_Matlab_Files\Calibration_Photos\C1';
Folder2 = 'D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Capstone_Matlab_Files\Calibration_Photos\C2';

vid=VideoReader('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Capstone_Matlab_Files\Calibration_Photos\C920_Checkerboard.mp4');
  numFrames = vid.NumFrames;
  n=numFrames;
  
for iFrame = 1:10:n
  framet = read(vid, iFrame);
  imwrite(framet(:,1:1920,:), fullfile(Folder1, sprintf('c1_%06d.png', iFrame)));
  imwrite(framet(:,1921:3840,:), fullfile(Folder2, sprintf('c2_%06d.png', iFrame)));
end 

% 
% FileList = dir(fullfile(Folder1, '*.png'));
% 
% for iFile = 1:length(FileList)
%   aFile = fullfile(Folder1, FileList(iFile).name);
%   img   = imread(aFile);
% end