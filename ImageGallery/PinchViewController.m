//
//  PinchViewController.m
//  ImageGallery
//
//  Created by Tim Beals on 2016-11-14.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "PinchViewController.h"

@interface PinchViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *pinchScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PinchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
 
 //****
 -(void)setupPanningAndZoomingImage {
     [self.pinchScrollView addSubview:self.pinchScrollView];
     
     self.pinchScrollView.contentSize = self.imageView.bounds.size;
     
     self.pinchScrollView.minimumZoomScale = 1.0;
     self.pinchScrollView.maximumZoomScale = 5.0;
 }
 
 - (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
     return self.imageView;
 }

@end
