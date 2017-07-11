//
//  ImageDetailViewController.m
//  ScrollView Image Gallery
//
//  Created by Errol Cheong on 2017-07-10.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "ImageGalleryViewController.h"

@interface ImageDetailViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailScrollView.delegate = self;
    self.detailScrollView.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = self.galleryImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView sizeToFit];
    [self.detailScrollView addSubview:self.imageView];
    self.detailScrollView.contentSize = self.imageView.bounds.size;
    self.imageView.center = CGPointMake(self.imageView.center.x, self.detailScrollView.center.y);
//    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width , self.imageView.image.size.height);
    
    
    self.detailScrollView.maximumZoomScale = 2.0;
    self.detailScrollView.minimumZoomScale = 0.2;
//    self.detailScrollView.zoomScale = 0.5;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)detailScrollView{
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
