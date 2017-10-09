//
//  SubjectRegularCollectionViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectRegularCollectionViewCell.h"

@implementation SubjectRegularCollectionViewCell

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    _logoImage.image = [UIImage imageNamed:_imageStr];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLabel.text = _titleStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    _logoImage.frame = CGRectMake(0, 0, 50, 50);
    // Initialization code
}

@end
