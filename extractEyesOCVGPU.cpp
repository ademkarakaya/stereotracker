<<<<<<< HEAD
//GPU implementation for Haar Cascade
=======
>>>>>>> db3cd330eee36df26d815b6067498eb63f98270d
// https://au.mathworks.com/help/matlab/matlab_external/standalone-example.html
//C:\ProgramData\MATLAB\SupportPackages\R2020a\toolbox\vision\supportpackages\visionopencv\mexOpenCV.m
//mexOpenCV extractEyesOCVGPU.cpp -lgpu -lmwocvgpumex -largeArrayDims

// nlhs - output arguments
// plhs - output MATLAB array of pointers
// nrhs - input arguments (don't have to modify)
// prhs - input MATLAB array of pointers (do not modify)

#include "opencvgpumex.hpp"
#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/cudaobjdetect.hpp"
#include "opencvgpumex.hpp"
#include "opencv2/cudaimgproc.hpp"
#include "gpu/mxGPUArray.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include "opencv2/cudaarithm.hpp"
#include "opencv2/cudafeatures2d.hpp"


using namespace std;
using namespace cv;

// Global Variables
String face_cascade_name = "haarcascade_frontalface_alt.xml";
String eyes_cascade_name = "haarcascade_eye.xml";
//1 - Load Classifiers
cv::Ptr<cuda::CascadeClassifier> face_cascade = cuda::CascadeClassifier::create(face_cascade_name);
cv::Ptr<cuda::CascadeClassifier> eyes_cascade = cuda::CascadeClassifier::create(eyes_cascade_name);

//RNG rng(12345);

static void convertAndResize(const cv::cuda::GpuMat &src, cv::cuda::GpuMat &gray, cv::cuda::GpuMat &resized, double scale)
{

    cv::cuda::cvtColor( src, gray, COLOR_BGR2GRAY );

    Size sz(cvRound(gray.cols * scale), cvRound(gray.rows * scale));
    if (scale != 1)
    {
        cv::cuda::resize(gray, resized, sz);
    }
    else
    {
        resized = gray;
    }
}

// @Function Main
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[])
{
    
    std::vector<Rect> faces;
    const int *dim_array;
    int l,m,n, dims;
    double scaleFactor = 1.0;
    bool findLargestObject = false;
    bool filterRects = true;
    

        
    // --3. Create input and output matrix and parameters
    Ptr<cv::cuda::GpuMat> frame_gpu = ocvMxGpuArrayToGpuMat_uint8(prhs[0]);
    cv::cuda::GpuMat  gray_gpu, resized_gpu, facesBuf_gpu;
    
    
    //--4. Conversions necessary
    convertAndResize(*frame_gpu, gray_gpu, resized_gpu, scaleFactor);
    
    //-- 5. Apply Classifier

    
    //Detect Faces (use this to change parameters)
    face_cascade->setFindLargestObject(false);
    face_cascade->setScaleFactor(2);
    face_cascade->setMinNeighbors((filterRects || findLargestObject) ? 4 : 0);
    face_cascade->detectMultiScale(resized_gpu, facesBuf_gpu);
    face_cascade->convert(facesBuf_gpu, faces);
    
    int i = 0;
    for( size_t i; i < faces.size(); i++ )
    {
       Point center( faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5 );
        ellipse( *frame_gpu, center, Size( faces[i].width*0.5, faces[i].height*0.5), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
    }
    plhs[0] = ocvMxGpuArrayFromGpuMat_uint8(frame_gpu);
    


    //cv::cuda::GpuMat faceROI = frame_gpu( facesBuf_gpu[i] );
    //std::vector<Rect> eyes;
     
    //--In each face, detect eyes
     
    //eyes_cascade->setFindLargestObject(false);
    //eyes_cascade->setScaleFactor(2);
    //eyes_cascade->setMinNeighbors((filterRects || findLargestObject) ? 4 : 0);
    //eyes_cascade->detectMultiScale(resized_gpu, facesBuf_gpu);
    //eyes_cascade->convert(facesBuf_gpu, eyes);
    
    return;
}

    


