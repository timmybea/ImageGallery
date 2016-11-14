//
//  ViewController.m
//  ImageGallery
//
//  Created by Tim Beals on 2016-11-14.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic, readonly) NSArray<UIImage *> *lighthouseArray;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPagingImages];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma  - make image array

- (NSArray<UIImage *> *)lighthouseArray
{
        return @[
                 [UIImage imageNamed:@"Lighthouse-in-Field"],
                 [UIImage imageNamed:@"Lighthouse-night"],
                 [UIImage imageNamed:@"Lighthouse-zoomed"],
                 ];
}

#pragma - setup paging

- (void)setupPagingImages
{
    CGFloat imageXPosition = 0;
    CGFloat scrollViewWidth = CGRectGetWidth(self.view.frame);
    CGFloat scrollViewHeight = CGRectGetHeight(self.view.frame);
    
    for(UIImage *lighthouseImage in self.lighthouseArray)
    {
        UIImageView *lighthouseImageView = [[UIImageView alloc] initWithImage:lighthouseImage];
        
        [self.scrollView addSubview:lighthouseImageView];
        [self constraintImageView:lighthouseImageView WithScrollView:self.scrollView];
        lighthouseImageView.frame = CGRectMake(imageXPosition, 0, scrollViewWidth, scrollViewHeight);
        lighthouseImageView.contentMode = UIViewContentModeScaleAspectFit;
        lighthouseImageView.clipsToBounds = YES;
        imageXPosition += scrollViewWidth;
    }
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth*self.lighthouseArray.count, scrollViewHeight);
    self.scrollView.pagingEnabled = YES;
}

- (void)constraintImageView:(UIImageView *)imageView WithScrollView:(UIScrollView *)scrollView
{
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:scrollView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:scrollView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:0]];
}





@end
