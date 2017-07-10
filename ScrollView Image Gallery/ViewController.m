//
//  ViewController.m
//  ScrollView Image Gallery
//
//  Created by Errol Cheong on 2017-07-10.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.scrollView.leadingAnchor constraintEqualToAnchor:
     self.view.leadingAnchor].active = YES;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:
     self.view.trailingAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:
     self.view.topAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:
     self.view.bottomAnchor].active = YES;
    
    self.imageView1 = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.imageView1];
    [self addLeadingView:self.imageView1 toCenterView:self.imageView2 inView:self.scrollView];
    
    self.imageView2 = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.imageView2];
    [self addCenterView:self.imageView2 inView:self.scrollView];
    
    self.imageView3 = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.imageView3];
    [self addTrailingView:self.imageView3 toCenterView:self.imageView2 inView:self.scrollView];
    
    self.scrollView.pagingEnabled = YES;
}

- (void)addLeadingView:(UIView*)view1 toCenterView:(UIView*)view2 inView:(UIView*)view3{
    [view1.leadingAnchor constraintEqualToAnchor:
     view3.leadingAnchor].active = YES;
    [view1.topAnchor constraintEqualToAnchor:
     view3.topAnchor].active = YES;
    [view1.bottomAnchor constraintEqualToAnchor:
     view3.bottomAnchor].active = YES;
    [view1.trailingAnchor constraintEqualToAnchor:
     view2.leadingAnchor].active = YES;
}

- (void)addCenterView:(UIView*)view1 inView:(UIView*)view3{
    [view1.topAnchor constraintEqualToAnchor:
     view3.topAnchor].active = YES;
    [view1.bottomAnchor constraintEqualToAnchor:
     view3.bottomAnchor].active = YES;
}

- (void)addTrailingView:(UIView*)view1 toCenterView:(UIView*)view2 inView:(UIView*)view3{
    [view1.leadingAnchor constraintEqualToAnchor:
     view2.trailingAnchor].active = YES;
    [view1.topAnchor constraintEqualToAnchor:
     view3.topAnchor].active = YES;
    [view1.bottomAnchor constraintEqualToAnchor:
     view3.bottomAnchor].active = YES;
    [view1.trailingAnchor constraintEqualToAnchor:
     view3.trailingAnchor].active = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
