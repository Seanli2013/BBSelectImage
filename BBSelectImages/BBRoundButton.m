//
//  BBRoundButton.m
//  BBArtisan
//
//  Created by Xiang LI on 6/2/14.
//  Copyright (c) 2014 com.bigbelldev. All rights reserved.
//

#import "BBRoundButton.h"

@implementation BBRoundButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
        self.layer.borderColor = [UIColor whiteColor].CGColor;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
