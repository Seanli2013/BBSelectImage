//
//  BBRoundView.h
//  BBArtisan
//
//  Created by Xiang LI on 6/9/14.
//  Copyright (c) 2014 com.bigbelldev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BBRoundView : UIView
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSNumber *borderWidth;
- (void)setupView;

@end
