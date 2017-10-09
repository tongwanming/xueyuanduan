//
//  personShowControl.m
//  好梦学车
//
//  Created by haomeng on 2017/5/31.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "personShowControl.h"

@implementation personShowControl{
    UIImageView *_logoImageView;
    
    UILabel *_titleLabel;
    UILabel *_titleLabel2;
}

- (instancetype)initWithFrame:(CGRect)frame andImageStr:(NSString *)imageSrtr andTitle1:(NSString *)title1 andTitle2:(NSString *)title2{
    if (self = [super initWithFrame:frame]) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 39, 20, 20)];
        _logoImageView.image = [UIImage imageNamed:imageSrtr];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_logoImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+18, 35, 100, 16)];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = title1;
        [self addSubview:_titleLabel];
        
        _titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+18, CGRectGetMaxY(_titleLabel.frame)+11, 100, 12)];
        _titleLabel2.textColor = ADB1B9;
        _titleLabel2.font = [UIFont systemFontOfSize:12];
        _titleLabel2.text = title2;
        [self addSubview:_titleLabel2];
    }
    return self;
}

@end
