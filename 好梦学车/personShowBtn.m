//
//  personShowBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/5/31.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "personShowBtn.h"

@implementation personShowBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(CURRENT_BOUNDS.width/6-31/2, 18, 31, 31);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+19, CURRENT_BOUNDS.width/3, 13);
    
    self.titleLabel.textColor = UNMAIN_TEXT_COLOR;
}

@end
