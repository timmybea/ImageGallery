//
//  ViewController.m
//  ImageGallery
//
//  Created by Tim Beals on 2016-11-14.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "ViewController.h"
#import "PinchViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic, readonly) NSArray<UIImage *> *lighthouseArray;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPagingImages];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(segueToDetail:)];
    [self.view addGestureRecognizer:self.tapGesture];
    self.scrollView.delegate = self;
    
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
                 [UIImage imageNamed:@"1-41"],
                 [UIImage imageNamed:@"02"],
                 [UIImage imageNamed:@"486899724"],
                 [UIImage imageNamed:@"shutterstock_14337916"],
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
        lighthouseImageView.userInteractionEnabled = YES;
        imageXPosition += scrollViewWidth;
    }
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth*self.lighthouseArray.count, scrollViewHeight);
    self.scrollView.pagingEnabled = YES;
    self.pageControl.numberOfPages = self.lighthouseArray.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    self.pageControl.currentPage = page;
    
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


- (void)segueToDetail:(UITapGestureRecognizer *)sender
{
    CGPoint tappedLocation = [sender locationInView:self.scrollView];
    UIImageView * tappedView = (UIImageView *)[self.scrollView hitTest:tappedLocation withEvent:nil];
    if ([tappedView isKindOfClass:[UIImageView class]]) {
        [self performSegueWithIdentifier:@"showDetail" sender:tappedView.image];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showDetail"])
    {
        PinchViewController *pinchViewController = segue.destinationViewController;
        pinchViewController.image = (UIImage *)sender;
    }
}

@end
