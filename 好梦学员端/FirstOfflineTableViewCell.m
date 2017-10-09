//
//  FirstOfflineTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstOfflineTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FirstOfflineTableViewCell

- (void)setModel:(OffLineServerStation *)model{
    _model = model;
    if (model.imageUrl) {
         [_logoImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"pic02"]];
    }else{
        [_logoImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"pic02"]];
    }
    
    _FirstTitleLabel.text = [NSString stringWithFormat:@"%@",model.name];
    _SecondTitleLabel.text = [NSString stringWithFormat:@"地址:%@",model.address];
    _Third.text = [NSString stringWithFormat:@"电话:%@",model.phone];
//    _FirstTitleLabel.font = [UIFont boldSystemFontOfSize:15*TYPERATION];
//    _SecondTitleLabel.font = [UIFont systemFontOfSize:12*TYPERATION];
//    _Third.font = [UIFont systemFontOfSize:12*TYPERATION];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.logoImageView.layer.masksToBounds = YES;
    self.logoImageView.layer.cornerRadius = 8;
}
@end
