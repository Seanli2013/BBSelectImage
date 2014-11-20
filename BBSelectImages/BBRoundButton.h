//
//  BBRoundButton.h
//  BBArtisan
//
//  Created by Xiang LI on 6/2/14.
//  Copyright (c) 2014 com.bigbelldev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBRoundButton : UIButton
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSNumber *borderWidth;
- (void)setupView;
@end
