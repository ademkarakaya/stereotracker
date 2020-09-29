%%% Taking snapshots from webcam. Converting snapshots to video.

clc
clear all
close all

workingDir = 'D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Offline_Gaze_Rec_Cap\Legday';
mkdir(workingDir);
mkdir(workingDir,'images');


%% Camera Definition

cam1 = webcam('Chicony');
cam1.WhiteBalance = 2800;
imset = zeros(480,640,3,30);

ii = 1;

for a = 1:30
   
    
   img = snapshot(cam1);
   filename = [sprintf('%03d',ii) '.jpg'];
   fullname = fullfile(workingDir,'images',filename);
   imwrite(img,fullname);
   ii = ii + 1;
    
end

imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,'leg_day.avi'));
outputVideo.FrameRate = 7.5;
open(outputVideo)

for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,'images',imageNames{ii}));
   writeVideo(outputVideo,img)
end

legdayAvi = VideoReader(fullfile(workingDir,'leg_day.avi'));

ii = 1;
while hasFrame(legdayAvi)
   mov(ii) = im2frame(readFrame(legdayAvi));
   ii = ii+1;
end

figure 1
imshow(mov(1).cdata, 'Border', 'tight')
movie(mov,1,legdayAvi.FrameRate)
