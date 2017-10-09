//
//  SubjectDetailRegularCollectionViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectDetailRegularCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SubjectDetailRegularCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLabel.text = titleStr;
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
//    _logoImage.image = [UIImage imageNamed:imageStr];
    [_logoImage sd_setImageWithURL:[NSURL URLWithString:_imageStr] placeholderImage:[UIImage imageNamed:@"pic02"]];
}

@end
