//
//  ImageDetailViewController.m
//  ScrollView Image Gallery
//
//  Created by Errol Cheong on 2017-07-10.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ImageDetailViewController.h"

@interface ImageDetailViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    
    [self.scrollView.leadingAnchor constraintEqualToAnchor:
     self.view.leadingAnchor].active = YES;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:
     self.view.trailingAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:
     self.view.topAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:
     self.view.bottomAnchor].active = YES;
   
    
    [self.scrollView addSubview:self.imageView];
    [self.imageView.leadingAnchor constraintEqualToAnchor:
     self.scrollView.leadingAnchor];
    [self.imageView.trailingAnchor constraintEqualToAnchor:
     self.scrollView.trailingAnchor];
    [self.imageView.topAnchor constraintEqualToAnchor:
     self.scrollView.topAnchor];
    [self.imageView.bottomAnchor constraintEqualToAnchor:
     self.scrollView.bottomAnchor];
    
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.zoomScale = 0.5;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
