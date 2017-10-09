//
//  SubjectOneSpecialProjectBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/5/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneSpecialProjectBtn.h"

@implementation SubjectOneSpecialProjectBtn{
    UIImageView *_logoImageView;
    UILabel *_titleLabel;
    UILabel *_numberLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 17, 22, 22)];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_logoImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+15, 22, 50, 15)];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
//    _titleLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame)+8, 22, 50, 15)];
    _numberLabel.textColor = ADB1B9;
    _numberLabel.font = [UIFont systemFontOfSize:15];
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_numberLabel];
    
}

- (void)setModel:(SubjectOneSpecialProjectModel *)model{
    _model = model;
    _logoImageView.image = [UIImage imageNamed:model.imageName];
    _titleLabel.text = model.titleLabel;
    _numberLabel.text = model.numLabel;
    
}

@end
