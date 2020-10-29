# Online Stereo-Video Based Eye Tracking For Non-Compliant Subjects
*D.Duric, A.Karakaya. RMIT University Capstone Project 2020*

This is a stereo-video camera setup designed to track an individual's gaze. It is currently a proof-of-concept that demonstrates the main components the system relies on.
It is currently contained within the stereovideo.mlapp application file that can be run on MATLAB.

## How to run this system

### Setup
There are a couple of things you need before you can start the application. It is expected that you have the latest version of MATLAB (R2020a at the time of writing this):

Firstly, download the computer vision toolbox from MATLAB. Once that is done, follow the steps to operate the following [support package](https://www.mathworks.com/help/vision/ug/install-and-use-computer-vision-toolbox-opencv-interface.html) that allows for OpenCV in C++ written MEX files. You need to ensure you have the correct compiler for this to work and to link it to MATLAB. I suggest you use [this video](https://www.mathworks.com/videos/using-opencv-with-matlab-97710.html) if you're getting stuck.

| Operating System | Compiler                                                          |
|------------------|-------------------------------------------------------------------|
| Windows® 64 bit  | Microsoft® Visual Studio® 2015 Professional or Visual Studio 2017 |
| Linux® 64 bit    | gcc-4.9.3 (g++)                                                   |
| Mac 64 bit       | Xcode 6.2.0 (Clang++)                                             |

Once that is done, first try to compile one of the OpenCV example files.

If that's successful, attempt to compile the file 'extractEyesOCVPoints.cpp' using MexOpenCV. The command for this is:
> \>\> mexOpenCV extractEyesOCVPoints.cpp -compatibleArrayDims

if it compiles successfully, then congrats. You've got through the hardest part.

### Filming test footage
Jump on OBS and set the resolution to 3840x1080 for both output and canvas size. Set the left and right cameras on top of your monitor, with the two cameras meeting at the centre, and note the distance between you and the monitor in mm (you can use 'centre.jpg' in the supplementary files). Make sure that the camera isn't tilted (use a water level for that if you like). When filming, make sure you use a head clamp (or something comfortable to rest your head on and stop it from moving.) Ensure you look at the centre point of the monitor to create 'ground truth' and then test by looking at different parts of the screen. The output video should have the left camera on the left, and right camera on the right.

### Testing if it worked (Configuring Haar Cascade)
The 'haartest.m' file is used to test the parameters of the haar cascade function and see if it's working as intended. The parameters have to be manually configured in the C++ file currently, but parametrisation options could be something added in the future. At the moment though, it's set pretty conservatively to operate with a person roughly 400mm away from the camera. It's not perfect, sometimes it'll miss an eye or detect another, but we've left the option to configure the Haar cascade to you.

The input video required is two separate cameras of 1920x1080 (3840x1080 total) side by side of the subject's face. You could manually read an image if you want to change it.

To configure the Haar cascade, open up 'extractEyesOCVPoints.cpp' and configure the lines "X.cascade_detectMultiScale(...)" where X is the object of interest (face, eye etc.)
[Use this](https://docs.opencv.org/3.4/d1/de5/classcv_1_1CascadeClassifier.html#aaf8181cb63968136476ec4204ffca498) to figure out the syntax. [Use this](https://stackoverflow.com/questions/20801015/recommended-values-for-opencv-detectmultiscale-parameters) for further understanding.

### Test Pt. 2 - Daugman's algorithm
In the 'supplementary files' folder, there is also a file called 'daugman_test_no_haar.m' which is self explanatory. The first loop is to find calibration points, the second is to find the estimated gaze. You can get bounding boxes from a previously performed haar cascade or manually set a bounding box.

### Running the application
Once you're happy with everything being configured and all nice, you can use the 'stereovideo.mlapp' application and follow the prompts. Go through each tab in order **except the second one because it isn't required.** Both the test files are not linked to the main file, so if you're looking to create a final test image, configure the app manually. Just make sure you also have the 'integrodifferential_operator' file and its content in MATLAB's path as well too before running it. 

**It takes about 2.5 seconds of processing per frame, although there is minimal optimisation in the code at the moment as it was intended as a proof-of-concept and not a full-fledged final product (it's loading frames and writing frames to a video file for demo purposes, not exactly efficient...) This means it'll take roughly over an hour to make a minute video of 30fps.** The result of the application once it's done processing is a video of Daugman's algorithm in action, as well as a CSV file containing the mean estimated gaze.

### Further mappings
The CSV file can then be used in conjunction with 'GraphVideo.m' to create a video that maps the movement of the eye. 

## How does it work?
To summarise the system, there are 4 components that enable gaze estimation: Stereo Camera Capture, Haar Cascade segmentation, Daugman's Algorithm and Geometric Gaze Estimation.

### Stereo Camera Capture

Based on the tests that we perform in its current state, we record footage of 3840x1080 (i.e two 1920x1080 videos side-by-side). The most ideal way of performing this is using OBS. Ideally, future work will see recordings being performed live.

### Haar Cascade Segmentation
Based on [this work.](https://en.wikipedia.org/wiki/Viola%E2%80%93Jones_object_detection_framework)
To further simply what this is, it uses binary images (haar features) to detect features of objects, specifically, parts of the faces and eyes. Once it finds what it's looking for, a bounded box is applied. We use these bounds to eliminate the rest of the image from processing.

### Daugman's algorithm
Originally used for Iris Recognition, it's an efficient algorithm to find the Iris (and pupil) of an individual. We only segment the iris due to the fact that it's hard to distinguish the pupil from the iris in some scenarios and it isn't worth doing so anyway. This was chosen over the more popular Hough transform for both less processing power required and allowing approximation of eye movement.

### Geometric Gaze Estimation
[Based off this paper](https://ieeexplore.ieee.org/document/7820784) which effectively uses some clever and simple geometry to estimate the gaze position. You can backtrack from the 'gaze_estimation.m' file but effectively there's two perpendicular triangles made with the centre of the eye ball, the origin and the estimated point of gaze. Alpha is the X angle direction and Beta is the angle in the Y direction.

## Supplementary Files and other notes
These were other pieces of code that we had written as an attempt for GPU haar cascade implementation, Webcam implementation and other bits that may or may not be functional. The most interesting one is the 'discreteDeltaPixels.m' because that shows you the possible discrete resolution and change when the centre of the eye moves between pixels, effectively plotting the monitor/plane. Some cpp files such as the example haar cascades were files from OpenCV archives that we used as reference to write the Haar cascade code in MEX. These files aren't required, but they show what ambitions we've had with this project initially. Frame converter splits the video every couple frames into images of 1920x1080, which was initially to be used for MATLAB's stereovideo calibration tool as it requires pictures of a checkerboard canvas. This also relates back to the second tab of stereovideo.mlapp which does the same thing. Haar_video.mlapp is a crack at live video, though it was just way too laggy and poorly implemented.

