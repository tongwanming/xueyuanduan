//
//  SamailerImgBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/6/5.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SamailerImgBtn.h"

@implementation SamailerImgBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.imageView.frame = CGRectMake((self.frame.size.width - 20)/2, (self.frame.size.width - 20)/2, 20, 20);
    
    
}

@end
