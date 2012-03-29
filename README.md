# Description

This project uses Eigenfaces, Fisherfaces and Local Binary Patterns Histograms algorithms to do face recognition amongst a set of faces. It was implemented for iOS (higher than 5.0) with OpenCV.
You can also use this sample project to do your works with OpenCV in iOS, if you need to. If you want, you can also check how to create an iOS Project working with OpenCV down below (although you can easily reuse the sample project to do your work).
This project was developed with Philipp Wagner's face recognition library in mind. You can find that library here: https://github.com/bytefish/libfacerec.

# Creating an iOS Project working with OpenCV

1) Add a Cocoa Touch Static Library (Add Target on Project) named OpenCV-iPhone (as an example).
2) Add the following User Header Search Paths (on Build Settings) to this new target.

  ThirdParty/OpenCV/include
  ThirdParty/OpenCV/modules/core/include
  ThirdParty/OpenCV/modules/flann/include
  ThirdParty/OpenCV/modules/imgproc/include
  ThirdParty/OpenCV/modules/video/include
  ThirdParty/OpenCV/modules/features2d/include
  ThirdParty/OpenCV/modules/objdetect/include
  ThirdParty/OpenCV/modules/calib3d/include
  ThirdParty/OpenCV/modules/highgui/include
  ThirdParty/OpenCV/modules/ml/include
  ThirdParty/OpenCV/modules/contrib/include
  ThirdParty/iulib
  ThirdParty/iulib-includes
  ThirdParty/ocropus/ocr-utils

3) Add the files mentioned on the sample project under ThirdParty group (no need to copy). Basically all the core and imgproc files.

4) Add all the headers added before (except for config_auto.h) to "Copy Headers" under Project (on Build Phases) to OpenCV-iPhone Library. 22 in total.

5) Add all the cpp files added before to "Compile Sources" under Project (on Build Phases) to OpenCV-iPhone Library. 64 in total.

6) Add the libraries Accelerate.framework and libz.dylib to "Link Binary With Libraries" under Project (on Build Phases) to OpenCV-iPhone Library.

7) Now, go back to your app's target (on Project) and add the same User Header Search Paths (on Build Settings) that you added on step 2. Add also to your project's Build Settings.

8) Go to Build Phases (on the app's target) and add the library that you created on step 1, to your Target Dependencies.

9) Remove the .cpp files that Xcode automatically added to Compile Sources (no need to have it).

10) Add the libOpenCV-iPhone.a, Accelerate.framework and libz.dylib to your Link Binary with Libraries.

11) Add the following to your .pch file:

  #ifdef __cplusplus
  #import "opencv2/opencv.hpp"
  #endif

12) Now, go to your implementation file where you are going to use OpenCV libraries, and change it to Filename.mm instead of just Filename.m. Add #import "opencv2/opencv.hpp", type a line of code (i.e. IplImage *test;) and after building, you shall notice that everything went fine, and you're now ready to run OpenCV on your iPhone!

Note: If you want to update your OpenCV library, you just need to copy the files from the new version available on OpenCV project homepage, and paste it into ThirdParty/OpenCV in order to replace the older version.
Note 2: If you have any problems trying to get OpenCV working, try to copy the Build Settings from the sample project to the new project you're creating.

