//
//  ChoosedClassCollectionViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedClassCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ChoosedClassCollectionViewCell{
    UIImageView *_backGroundView;
    UILabel *_nameLabel;
    UILabel *_priceLabel;
    UILabel *_decLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize{
    _backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _backGroundView.layer.cornerRadius = 8;
    _backGroundView.layer.masksToBounds = YES;
    _backGroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backGroundView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 27, self.frame.size.width-50, 25)];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:25];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [_backGroundView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_nameLabel.frame)+12, self.frame.size.width-50, 14)];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    [_backGroundView addSubview:_priceLabel];
    
    _decLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height-46/2-28/2, self.frame.size.width-50, 14)];
    _decLabel.textColor = [UIColor whiteColor];
    _decLabel.font = [UIFont systemFontOfSize:14];
    _decLabel.textAlignment = NSTextAlignmentLeft;
    _decLabel.alpha = 0.6;
    [_backGroundView addSubview:_decLabel];
}

- (void)setModel:(ChoosedClassModel *)model{
    _model = model;
    
    [_backGroundView sd_setImageWithURL:[NSURL URLWithString:model.imageStr] placeholderImage:[UIImage imageNamed:@"pic06"]];
//    _backGroundView.image = [UIImage imageNamed:model.imageStr];
    
    _nameLabel.text = model.titleStr;
    
    _priceLabel.text = [NSString stringWithFormat:@"%@元起",model.priceStr];
    
    _decLabel.text = model.descStr;
}

@end
