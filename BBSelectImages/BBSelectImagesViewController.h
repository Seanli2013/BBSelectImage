//
//  BBSelectImagesViewController.h
//  BBSelectImages
//
//  Created by Xiang LI on 11/12/14.
//  Copyright (c) 2014 Xiang LI. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBSelectImagesDelegate <NSObject>

@optional
// 选定PortraitImage
- (void)didSelectedImagePortrait:(UIImage *)portraitImage;
// 选定LandscapeImage
- (void)didSelectedImageLandscape:(UIImage *)landscapeImage;
// 要退出前
- (void)willDismiss;
@end

@interface BBSelectImagesViewController : UIViewController
@property (nonatomic, strong) UIImage *portraitImage;
@property (nonatomic, strong) UIImage *landscapeImage;
@property (nonatomic, weak) id <BBSelectImagesDelegate> delegate;
@end

