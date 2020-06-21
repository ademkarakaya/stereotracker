// https://au.mathworks.com/help/matlab/matlab_external/standalone-example.html


// nlhs - output arguments
// plhs - output MATLAB array of pointers
// nrhs - input arguments (don't have to modify)
// prhs - input MATLAB array of pointers (do not modify)

#include "opencvmex.hpp"
#include "mex.h"

using namespace cv;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	int i;
	double*inMatrix
    double total
            
    
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL);
    
    // Inputs Provided
	mexPrintf("\n%d input argument(s) provided", nrhs);
	
    //Read the inputs
	for (i= 0; i<nrhs; i++)
	{
		mexPrintf("\n\tInput Arg number %i is of type:\t%s ", i, mxGetClassName(prhs[i]));
        inMatrix = mxGetDoubles(prhs[i]);
        
    }
       
}