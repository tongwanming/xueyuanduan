//
//  SubjectOneChoosedBtn.m
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneChoosedBtn.h"

@implementation SubjectOneChoosedBtn{
    SubjectOneChoosedBtnType _type;
    NSInteger _progress;
    NSString *_logoImageNameStr;
    NSString *_backFGroundImageNameStr;
    NSString *_nameNameStr;
    UIColor *_backGroundColor;
    
}

- (instancetype)initWithFrame:(CGRect)frame andType:(SubjectOneChoosedBtnType)type andProgress:(NSInteger)progress{
    if (self = [super initWithFrame:frame]) {
        _type = type;
        _progress = progress;
        [self getData];
        [self initView];
    }
    
    return self;
}

- (void)getData{
    if (_type == SubjectOneChoosedBtnTypeOne) {
        //顺序练题
        _backGroundColor = [UIColor colorWithRed:0.07f green:0.73f blue:0.29f alpha:1.00f];
        _logoImageNameStr = @"btn_arrow";
        _backFGroundImageNameStr = [NSString stringWithFormat:@"%ld%%green",_progress/10*10];
        _nameNameStr = @"顺序练题";
        
    }else{
        //模拟考试
        _backGroundColor = [UIColor colorWithRed:0.02f green:0.63f blue:1.00f alpha:1.00f];
        _logoImageNameStr = @"btn_arrow";
        _backFGroundImageNameStr = [NSString stringWithFormat:@"%ld%%blue",_progress/10*10];;
        _nameNameStr = @"模拟考试";
    }
}

- (void)initView{
    _backGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_backFGroundImageNameStr]];
    _backGroundImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backGroundImageView.userInteractionEnabled = NO;
//    _backGroundImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_backGroundImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(3.5* TYPERATION, 3.5* TYPERATION, 120* TYPERATION, 40* TYPERATION)];
    view.backgroundColor = _backGroundColor;
    view.layer.cornerRadius = 20* TYPERATION;
    view.layer.masksToBounds = YES;
    view.userInteractionEnabled = NO;
    [self addSubview:view];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16* TYPERATION, 25/2.0* TYPERATION, 80* TYPERATION, 15* TYPERATION)];
    _titleLabel.font = [UIFont systemFontOfSize:15* TYPERATION];
    _titleLabel.text = _nameNameStr;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.userInteractionEnabled = NO;
    [view addSubview:_titleLabel];
    
    _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_logoImageNameStr]];
    _logoImageView.layer.cornerRadius = 21/2.0* TYPERATION;
    _logoImageView.layer.masksToBounds = YES;
    _logoImageView.frame = CGRectMake((120-21-19/2.0)* TYPERATION, (19/2.0)* TYPERATION, 21* TYPERATION, 21* TYPERATION);
    _logoImageView.userInteractionEnabled = NO;
    [view addSubview:_logoImageView];
    
    
}


@end
