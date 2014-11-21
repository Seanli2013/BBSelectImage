//
//  BBRoundView.m
//  BBArtisan
//
//  Created by Xiang LI on 6/9/14.
//  Copyright (c) 2014 com.bigbelldev. All rights reserved.
//

#import "BBRoundView.h"

@implementation BBRoundView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupView];
}

- (void)setupView
{
    if (self.borderColor) {
        self.layer.borderColor = self.borderColor.CGColor;
    }
    else
    {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    float borderWidth = [self.borderWidth floatValue];
    
    if (self.borderWidth && borderWidth >= 0 && borderWidth < 5) {
        self.layer.borderWidth = borderWidth;
    }
    else
    {
        self.layer.borderWidth = 1.0;
    }
    
    float cornerRadius = [self.radius floatValue];
    if (self.radius && cornerRadius >= 0 && cornerRadius < 20) {
        self.layer.cornerRadius = cornerRadius;
    }
    else
    {
        self.layer.cornerRadius = 5.0;
    }
}

@end
