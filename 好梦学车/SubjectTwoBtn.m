//
//  SubjectTwoBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectTwoBtn.h"

@implementation SubjectTwoBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.frame.size.width-29)/2, 30, 29, 29);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+12, self.frame.size.width, 13);
    
}

@end
