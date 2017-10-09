//
//  CatStyleApplyNowBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/5/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "CatStyleApplyNowBtn.h"

@implementation CatStyleApplyNowBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.titleLabel.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width, self.frame.size.height);
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+3, self.titleLabel.frame.size.height/2-5.5, 11, 11);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

@end
