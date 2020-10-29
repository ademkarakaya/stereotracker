%Captures Webcam snapshots directly and writes to workingDir.

workingDir = 'D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\images_and_videos';
fn1 = ['da' '.jpg'];
fn2 = ['db' '.jpg'];
fn3 = ['dab' '.jpg'];
full1 = fullfile(workingDir,fn1);
full2 = fullfile(workingDir,fn2);
full3 = fullfile(workingDir,fn3);

%% Camera Definition

camL = webcam(1);
camR = webcam(2);
camL.Resolution = '1920x1080';
camR.Resolution = '1920x1080';
camR.Zoom = 100;
camL.Zoom = 100;
camR.Tilt = 0;
camL.Tilt = 0;
camR.WhiteBalance = 3000;
camL.WhiteBalance = 3000;

pause(1);

%% Snapshot
img1 = snapshot(camL);
img2 = snapshot(camR);




imwrite(img1,full1);
imwrite(img2,full2);

img3 = zeros(1080,3840,3);
img3 = cast(img3,'uint8');
img3(:,1:1920,:) = img1;
img3(:,1921:3840,:) = img2;

imwrite(img1,full1);
imwrite(img2,full2);
imwrite(img3,full3);

