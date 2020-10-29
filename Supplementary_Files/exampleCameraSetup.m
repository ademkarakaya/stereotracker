function stereoSetup
% Function to setup cameras
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

end
