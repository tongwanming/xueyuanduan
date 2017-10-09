//
//  SubjectPractiseBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/5/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractiseBtn.h"

@implementation SubjectPractiseBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.frame.size.width - 25)/2, 11, 25, 25);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+8, self.frame.size.width, 11);
    
}

@end
