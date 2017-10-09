//
//  FirstServiceBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstServiceBtn.h"

@implementation FirstServiceBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = UNMAIN_TEXT_COLOR;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.imageView.frame = CGRectMake((self.frame.size.width - 59)/2, 0, 59, 59);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+10, self.frame.size.width, 26);
    
}

@end
