//
//  ViewController.m
//  Face Recognition Library
//
//  Created by Pedro Centieiro on 3/28/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "opencv2/opencv.hpp"
#import "ViewController.h"
#import "facerec.hpp"

@interface ViewController ()

@end

@implementation ViewController

- (IplImage *)CreateIplImageFromUIImage:(UIImage *)image
{
    // Getting CGImage from UIImage
    CGImageRef imageRef = image.CGImage;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // Creating temporal IplImage for drawing
    IplImage *iplimage = cvCreateImage(cvSize(image.size.width,image.size.height), IPL_DEPTH_8U, 4);
    
    // Creating CGContext for temporal IplImage
    CGContextRef contextRef = CGBitmapContextCreate(iplimage->imageData, iplimage->width, iplimage->height,
                                                    iplimage->depth, iplimage->widthStep,
                                                    colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
    // Drawing CGImage to CGContext
    CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    // Creating result IplImage
    IplImage *ret = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 3);
    cvCvtColor(iplimage, ret, CV_RGBA2BGR);
    cvReleaseImage(&iplimage);
    
    return ret;
}

- (IBAction)faceRecognition:(id)sender {
    // load images
    vector<Mat> images;
    vector<int> labels;
    
    int numberOfSubjects = 4;
    int numberPhotosPerSubject = 3;
    
    for (int i=1; i<=numberOfSubjects; i++) {
        for (int j=1; j<=numberPhotosPerSubject; j++) {
            // create grayscale images
            Mat src = [self CreateIplImageFromUIImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%d.jpg", i, j]]];
            Mat dst;
            cv::cvtColor(src, dst, CV_BGR2GRAY);
            
            images.push_back(dst);
            labels.push_back(i);
        }
    }
    
    // get test instances
    Mat testSample = images[images.size() - 1];
    int testLabel = labels[labels.size() - 1];
    
    // ... and delete last element
    images.pop_back();
    labels.pop_back();
    
    // build the Fisherfaces model
    Fisherfaces model(images, labels);
    
    // test model
    int predicted = model.predict(testSample);
    cout << "predicted class = " << predicted << endl;
    cout << "actual class = " << testLabel << endl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
