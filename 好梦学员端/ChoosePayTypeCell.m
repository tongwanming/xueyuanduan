//
//  ChoosePayTypeCell.m
//  好梦学车
//
//  Created by haomeng on 2017/7/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosePayTypeCell.h"

@implementation ChoosePayTypeCell

- (void)awakeFromNib{
    [super awakeFromNib];
    _logoImage.layer.cornerRadius = 21;
    _logoImage.layer.masksToBounds = YES;
}

@end
