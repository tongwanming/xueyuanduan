//
//  CocchShowCollectionViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "CocchShowCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CocchShowCollectionViewCell{
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_describeLabel;
    UILabel *_describeLabel2;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.layer.doubleSided = NO;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backGroundView.layer.cornerRadius = 8;
    backGroundView.layer.masksToBounds = YES;
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backGroundView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 22, 50, 50)];
    _imageView.layer.cornerRadius = 25;
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame)+25, self.frame.size.width, 15)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = TEXT_COLOR;
    [self addSubview:_nameLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width-12)/2, CGRectGetMaxY(_nameLabel.frame)+11, 6, 1)];
    lineView.backgroundColor = UNMAIN_TEXT_COLOR;
    [self addSubview:lineView];
    
    _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLabel.frame)+30, self.bounds.size.width-20, 12)];
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    _describeLabel.font = [UIFont systemFontOfSize:12];
    _describeLabel.textColor = UNMAIN_TEXT_COLOR;
    [self addSubview:_describeLabel];
    
    _describeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_describeLabel.frame)+6, self.bounds.size.width-20, 12)];
    _describeLabel2.textAlignment = NSTextAlignmentCenter;
    _describeLabel2.font = [UIFont systemFontOfSize:12];
    _describeLabel2.textColor = UNMAIN_TEXT_COLOR;
    [self addSubview:_describeLabel2];
}

- (void)setModel:(ChoosedCocchModel *)model{
    _model = model;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"pic03"]];
    
    _nameLabel.text = _model.name;
    
    _describeLabel.text = model.introducation;
//    _describeLabel.text = _model.describe;
//    
//    _describeLabel2.text = _model.describe2;
    
}

@end
