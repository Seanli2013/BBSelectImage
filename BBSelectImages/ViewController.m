//
//  ViewController.m
//  BBSelectImages
//
//  Created by Xiang LI on 11/20/14.
//  Copyright (c) 2014 Xiang LI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#define kBackgroundImagePortraitUD @"kBackgroundImagePortraitUD"
#define kBackgroundImageLandscapeUD @"kBackgroundImageLandscapeUD"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Fuctions
- (UIImage *)getImageFromStorage:(BBSelectImagesMode)mode
{
    UIImage *image;
    if (mode == BBSelectImagesModePortrait) {
        image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kBackgroundImagePortraitUD]];
    }
    else if (mode == BBSelectImagesModeLandscape)
    {
        image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kBackgroundImageLandscapeUD]];
    }
    else
    {
        NSLog(@"Error: 没有传入正确的参数. getImageFromStorage");
    }
    return image;
}

#pragma Delegates
- (void)willDismiss:(BBSelectImagesViewController *)selectImagesVC saveFlag:(BOOL)saveFlag
{
    if (saveFlag) {
        UIImage *imagePortrait = selectImagesVC.originalPortraitImage;
        UIImage *imageLandscape = selectImagesVC.originalLandscapeImage;
        
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(imagePortrait) forKey:kBackgroundImagePortraitUD];
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(imageLandscape) forKey:kBackgroundImageLandscapeUD];

    }
    else
    {
        // 被取消了，do nothing
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueToBBSelectImagesVC"]) {
        BBSelectImagesViewController *selectImagesVC = segue.destinationViewController;
        selectImagesVC.delegate = self;
        selectImagesVC.originalPortraitImage = [self getImageFromStorage:BBSelectImagesModePortrait];
        selectImagesVC.originalLandscapeImage = [self getImageFromStorage:BBSelectImagesModeLandscape];
    }
}


@end
