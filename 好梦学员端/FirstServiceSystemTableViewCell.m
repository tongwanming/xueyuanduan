//
//  FirstServiceSystemTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstServiceSystemTableViewCell.h"

@implementation FirstServiceSystemTableViewCell

- (void)setName:(NSString *)name{
    _name = name;
    _titleNameLabel.text = name;
}

@end
