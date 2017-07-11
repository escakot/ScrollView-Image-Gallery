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
@property (strong, nonatomic) NSArray<NSString*>* images;
@property (strong, nonatomic) NSMutableArray<UIImageView*> *imageViews;



@end

@implementation ImageGalleryViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _images = @[@"Lighthouse-in-Field",@"Lighthouse-night",@"Lighthouse-zoomed",
                    @"chicago",@"toronto",@"montreal"];
        _imageViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupScrollView];
    [self setupImageViews];
    [self setupPagingControl];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self forKeyPath:@"pageChange" options:NSKeyValueObservingOptionNew context:nil];
    [self.pageControl addTarget:self action:@selector(scrollViewChangePage) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)setupPagingControl
{
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.scrollView.subviews.count-2;
    [self.view addSubview:self.pageControl];
    self.pageControl.backgroundColor = [UIColor blackColor];
    self.pageControl.alpha = 0.5;
    [self.pageControl bringSubviewToFront:self.pageControl];
    CGRect frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
    self.pageControl.frame = frame;
}

- (void)setupScrollView
{
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

- (void)setupImageViews
{
    // Add Image Views based on the number of image strings
    for (NSString* image in self.images) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:image];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    // Add Constraints for each image
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if (idx == 0){
            [self addLeadingView:imageView toCenterView:self.imageViews[idx+1] inView:self.scrollView];
        } else if (idx == self.imageViews.count - 1){
            [self addTrailingView:imageView inView:self.scrollView];
        } else {
            [self addCenterView:imageView toNextView:self.imageViews[idx+1] inView:self.scrollView];
        }
    }];
}

//Add anchors to first imageView
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

//Add anchors for views in the middle
- (void)addCenterView:(UIView*)view1 toNextView:(UIView*)view2 inView:(UIView*)view3
{
    [view1.trailingAnchor constraintEqualToAnchor:
     view2.leadingAnchor].active = YES;
    [view1.topAnchor constraintEqualToAnchor:
     view3.topAnchor].active = YES;
    [view1.bottomAnchor constraintEqualToAnchor:
     view3.bottomAnchor].active = YES;
    [view1.widthAnchor constraintEqualToAnchor:
     view3.widthAnchor].active = YES;
    [view1.heightAnchor constraintEqualToAnchor:
     view3.heightAnchor].active = YES;
}

//Add anchors for last ImageView
- (void)addTrailingView:(UIView*)view1 inView:(UIView*)view3
{
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
//    NSLog(@"Image was tapped");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ImageDetailViewController *dvc = segue.destinationViewController;
    CGPoint location = [sender locationInView:self.scrollView];
    int image = location.x/self.scrollView.frame.size.width;
    dvc.galleryImage = [UIImage imageNamed:self.images[image]];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.contentSize.width*self.pageControl.numberOfPages;
    self.pageControl.currentPage = index;
}

-(void)scrollViewChangePage
{
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
