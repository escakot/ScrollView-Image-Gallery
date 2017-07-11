//
//  ImageGalleryViewController.m
//  ScrollView Image Gallery
//
//  Created by Errol Cheong on 2017-07-10.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ImageGalleryViewController.h"
#import "ImageDetailViewController.h"

@interface ImageGalleryViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;


@end

@implementation ImageGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
//    [self.scrollView.widthAnchor constraintEqualToAnchor:
//     self.view.widthAnchor].active = YES;
//    [self.scrollView.heightAnchor constraintEqualToAnchor:
//     self.view.heightAnchor].active = YES;
    
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
    
    self.scrollView.pagingEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    self.scrollView.userInteractionEnabled = YES;
    [self.scrollView addGestureRecognizer:tapGesture];
    
//    tapGesture.delegate = self;
}

- (void)imageViewTapped:(UITapGestureRecognizer*)sender
{
    [super performSegueWithIdentifier:@"detailViewSegue" sender:sender];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
