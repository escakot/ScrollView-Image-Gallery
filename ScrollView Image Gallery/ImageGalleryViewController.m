//
//  ImageGalleryViewController.m
//  ScrollView Image Gallery
//
//  Created by Errol Cheong on 2017-07-10.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ImageGalleryViewController.h"
#import "ImageDetailViewController.h"

@interface ImageGalleryViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;



@end

@implementation ImageGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupScrollView];
    [self setupImageViews];
    [self setupPagingControl];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self forKeyPath:@"pageChange" options:NSKeyValueObservingOptionNew context:nil];
    [self.pageControl addTarget:self action:@selector(scrollViewChangePage) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)setupPagingControl{
    self.pageControl = [[UIPageControl alloc] init];
//    self.pageControl.numberOfPages = self.scrollView.subviews.count;
    self.pageControl.numberOfPages = self.view.subviews.count;
    [self.view addSubview:self.pageControl];
    self.pageControl.backgroundColor = [UIColor blackColor];
    self.pageControl.alpha = 0.5;
    [self.pageControl bringSubviewToFront:self.pageControl];
    CGRect frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
    self.pageControl.frame = frame;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewNextPage)];
//    self.pageControl.userInteractionEnabled = YES;
//    [self.pageControl addGestureRecognizer:tapGesture];
}

- (void)setupScrollView{
    self.scrollView.delegate = self;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView.leadingAnchor constraintEqualToAnchor:
     self.view.leadingAnchor].active = YES;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:
     self.view.trailingAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:
     self.view.topAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:
     self.view.bottomAnchor].active = YES;
    
    self.scrollView.pagingEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    self.scrollView.userInteractionEnabled = YES;
    [self.scrollView addGestureRecognizer:tapGesture];
}

- (void)setupImageViews{
    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.image = [UIImage imageNamed:@"Lighthouse-in-Field"];
    self.imageView1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc] init];
    self.imageView2.image = [UIImage imageNamed:@"Lighthouse-night"];
    self.imageView2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.imageView2];
    
    self.imageView3 = [[UIImageView alloc] init];
    self.imageView3.image = [UIImage imageNamed:@"Lighthouse-zoomed"];
    self.imageView3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.imageView3];
    [self addLeadingView:self.imageView1 toCenterView:self.imageView2 inView:self.scrollView];
    [self addCenterView:self.imageView2 inView:self.scrollView];
    [self addTrailingView:self.imageView3 toCenterView:self.imageView2 inView:self.scrollView];
}

- (void)addLeadingView:(UIView*)view1 toCenterView:(UIView*)view2 inView:(UIView*)view3
{
    [view1.leadingAnchor constraintEqualToAnchor:
     view3.leadingAnchor].active = YES;
    [view1.topAnchor constraintEqualToAnchor:
     view3.topAnchor].active = YES;
    [view1.bottomAnchor constraintEqualToAnchor:
     view3.bottomAnchor].active = YES;
    [view1.trailingAnchor constraintEqualToAnchor:
     view2.leadingAnchor].active = YES;
    [view1.widthAnchor constraintEqualToAnchor:
     view3.widthAnchor].active = YES;
    [view1.heightAnchor constraintEqualToAnchor:
     view3.heightAnchor].active = YES;
}

- (void)addCenterView:(UIView*)view1 inView:(UIView*)view3
{
    [view1.topAnchor constraintEqualToAnchor:
     view3.topAnchor].active = YES;
    [view1.bottomAnchor constraintEqualToAnchor:
     view3.bottomAnchor].active = YES;
    [view1.widthAnchor constraintEqualToAnchor:
     view3.widthAnchor].active = YES;
    [view1.heightAnchor constraintEqualToAnchor:
     view3.heightAnchor].active = YES;
}

- (void)addTrailingView:(UIView*)view1 toCenterView:(UIView*)view2 inView:(UIView*)view3
{
    [view1.leadingAnchor constraintEqualToAnchor:
     view2.trailingAnchor].active = YES;
    [view1.topAnchor constraintEqualToAnchor:
     view3.topAnchor].active = YES;
    [view1.bottomAnchor constraintEqualToAnchor:
     view3.bottomAnchor].active = YES;
    [view1.trailingAnchor constraintEqualToAnchor:
     view3.trailingAnchor].active = YES;
    [view1.widthAnchor constraintEqualToAnchor:
     view3.widthAnchor].active = YES;
    [view1.heightAnchor constraintEqualToAnchor:
     view3.heightAnchor].active = YES;
    
}

- (void)imageViewTapped:(UITapGestureRecognizer*)sender
{
    [self performSegueWithIdentifier:@"detailViewSegue" sender:sender];
    NSLog(@"Image was tapped");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ImageDetailViewController *dvc = segue.destinationViewController;
    CGPoint location = [sender locationInView:self.scrollView];
    NSLog(@"%@", NSStringFromCGPoint(location));
    int image = location.x/self.scrollView.frame.size.width;
    NSLog(@"%i", image);
    switch (image){
        case 0:
            dvc.galleryImage = [UIImage imageNamed:@"Lighthouse-in-Field"];
            break;
        case 1:
            dvc.galleryImage = [UIImage imageNamed:@"Lighthouse-night"];
            break;
        case 2:
            dvc.galleryImage = [UIImage imageNamed:@"Lighthouse-zoomed"];
            break;
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger numberOfPages= scrollView.contentSize.width/scrollView.frame.size.width;
    NSInteger index = scrollView.contentOffset.x/scrollView.contentSize.width*numberOfPages;
    self.pageControl.currentPage = index;
}

-(void)scrollViewChangePage{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
