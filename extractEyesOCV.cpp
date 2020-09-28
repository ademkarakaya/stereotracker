// Working CPU Implementation of Haar cascade for MATLAB
// https://au.mathworks.com/help/matlab/matlab_external/standalone-example.html
//C:\ProgramData\MATLAB\SupportPackages\R2020a\toolbox\vision\supportpackages\visionopencv\mexOpenCV.m


// nlhs - output arguments
// plhs - output MATLAB array of pointers
// nrhs - input arguments (don't have to modify)
// prhs - input MATLAB array of pointers (do not modify)

#include "opencvmex.hpp"
#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "mex.h"
#include <math.h>
#include <stdio.h>

using namespace std;
using namespace cv;

// Global Variables
String face_cascade_name = "haarcascade_frontalface_alt.xml";
String eyes_cascade_name = "haarcascade_eye.xml";
CascadeClassifier face_cascade;
CascadeClassifier eyes_cascade;
RNG rng(12345); 

// @Function Main
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[])
{
    
    Mat frame_gray;
    std::vector<Rect> faces;
    const int *dim_array;
    int l,m,n, dims;
    
    //-- 1. Load the cascade
    if( !face_cascade.load( face_cascade_name ) )
    { 
        printf("--(!)Error loading Face Cascade\n"); return; 
    };
    if( !eyes_cascade.load( eyes_cascade_name ) )
    { 
        printf("--(!)Error loading Eye Cascade\n"); return; 
    };
    
    //-- 2. Read Input Image Frame and Dimensions (optional checking)
    //dims = mxGetNumberOfDimensions(prhs[0]);
    //dim_array = mxGetDimensions(prhs[0]);  
    //m = dim_array[0];
    //n = dim_array[1];
    //l = dim_array[2];
    //mexPrintf("Image has %d Dimensions as %d by %d by %d\n",dims,m, n, l);
    
    // --3. Create input and output matrix in memory
    
    cv::Ptr<cv::Mat> frame = ocvMxArrayToImage_uint8(prhs[0], true);

    //-- 4. Apply Classifier

    cvtColor( *frame, frame_gray, CV_BGR2GRAY );
    equalizeHist( frame_gray, frame_gray );
    
    //Detect Faces (use this to change parameters) //changed size from 30 to 50 and scale to 2
    face_cascade.detectMultiScale( frame_gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, Size(100,100) );
    size_t i = 0;
    for( i; i < faces.size(); i++ )
    {
        Point center( faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5 );
        //ellipse( *frame, center, Size( faces[i].width*0.5, faces[i].height*0.5), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );

        Mat faceROI = frame_gray( faces[i] );
        std::vector<Rect> eyes;

    //-- In each face, detect eyes //changed size from 30 to 50 and scale to 2
        eyes_cascade.detectMultiScale( faceROI, eyes, 1.3, 2, 0 |CV_HAAR_SCALE_IMAGE, Size(100,100) );

        for( size_t j = 0; j < eyes.size(); j++ )
        {
            Point center( faces[i].x + eyes[j].x + eyes[j].width*0.5, faces[i].y + eyes[j].y + eyes[j].height*0.5 );
            Point TR(faces[i].x+eyes[j].x,                  faces[i].y+eyes[j].y);
            Point BL(faces[i].x+eyes[j].x+eyes[j].width,    faces[i].y+eyes[j].y+eyes[j].height);       
            int radius = cvRound( (eyes[j].width + eyes[j].height)*0.25 );
            //circle( *frame, center, radius, Scalar( 255, 0, 0 ), 4, 8, 0 );
            rectangle(*frame,TR,BL, Scalar(255,0,0),3);
        }
    }
    plhs[0] = ocvMxArrayFromImage_uint8(*frame);
    return;
}

