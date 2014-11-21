//
//  BBSelectImagesViewController.h
//  BBSelectImages
//
//  Created by Xiang LI on 11/12/14.
//  Copyright (c) 2014 Xiang LI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBSelectImagesViewController;

@protocol BBSelectImagesDelegate <NSObject>

@optional
// 选定PortraitImage
- (void)didSelectedImagePortrait:(UIImage *)portraitImage;
// 选定LandscapeImage
- (void)didSelectedImageLandscape:(UIImage *)landscapeImage;
// 要退出前
- (void)willDismiss:(BBSelectImagesViewController *)selectImagesVC saveFlag:(BOOL)saveFlag;
@end

@interface BBSelectImagesViewController : UIViewController
@property (nonatomic, strong) UIImage *originalPortraitImage;
@property (nonatomic, strong) UIImage *originalLandscapeImage;

@property (nonatomic, weak) id <BBSelectImagesDelegate> delegate;

@end

